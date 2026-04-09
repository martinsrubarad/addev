## Overview

Data View Web Services allow you to create custom data sources that ActiveDocs templates consume through the **Data View** Active Field. By exposing your data as an **OData V4** endpoint, you enable template designers to bind live data directly into documents — tables, lists, filtered record sets, and even images — without writing custom integration code.

OData (Open Data Protocol) V4 is a standardized REST protocol for querying and manipulating data. ActiveDocs leverages OData V4 to query external data sources at assembly time, passing security context headers so your service can enforce access control.

## Security Headers

When ActiveDocs queries your OData endpoint, it passes the following HTTP headers to identify the requesting user and subsite context:

| Header | Description |
|---|---|
| `adeQueryUserID` | The internal ActiveDocs user ID of the user assembling the document. |
| `adeQueryUserLogin` | The login name of the user assembling the document. |
| `adeQuerySubsiteID` | The internal ID of the subsite from which the document is being assembled. |
| `adeQuerySubsiteName` | The display name of the subsite. |

Your OData service should inspect these headers to filter data or enforce authorization. For example, you may restrict query results to records belonging to the requesting user's department.

```csharp
// Reading ActiveDocs security headers in a Web API controller
string userLogin = Request.Headers.GetValues("adeQueryUserLogin").FirstOrDefault();
string subsiteName = Request.Headers.GetValues("adeQuerySubsiteName").FirstOrDefault();
```

## SQL Server OData Example

This walkthrough creates a complete OData V4 service backed by a SQL Server database.

### Step 1: Create the ASP.NET Project

Create a new **ASP.NET Web Application** project in Visual Studio, selecting the **Web API** template.

### Step 2: Install the OData Package

Install the OData NuGet package:

```
Install-Package Microsoft.AspNet.OData
```

### Step 3: Generate the Entity Data Model

Add an **ADO.NET Entity Data Model** to the project using the **EF Designer from database** workflow:

1. Point the wizard at your SQL Server database.
2. Select the tables you want to expose (for example, `Customers`, `Orders`).
3. Entity Framework generates the context class and entity classes automatically.

The generated context typically looks like:

```csharp
public partial class SalesEntities : DbContext
{
    public SalesEntities()
        : base("name=SalesEntities")
    {
    }

    public virtual DbSet<Customer> Customers { get; set; }
    public virtual DbSet<Order> Orders { get; set; }
}
```

### Step 4: Configure the OData Endpoint

In `App_Start/WebApiConfig.cs`, configure the OData model builder and route:

```csharp
using System.Web.Http;
using System.Web.OData.Builder;
using System.Web.OData.Extensions;

public static class WebApiConfig
{
    public static void Register(HttpConfiguration config)
    {
        // Build the Entity Data Model
        ODataConventionModelBuilder builder = new ODataConventionModelBuilder();

        builder.EntitySet<Customer>("Customers").EntityType.HasKey(c => c.CustomerID);
        builder.EntitySet<Order>("Orders").EntityType.HasKey(o => o.OrderID);

        // Map the OData service route
        config.MapODataServiceRoute(
            routeName: "ODataRoute",
            routePrefix: "odata",
            model: builder.GetEdmModel()
        );

        config.EnsureInitialized();
    }
}
```

### Step 5: Create OData Controllers

Create a controller for each entity set. Each controller extends `ODataController` and uses the `[EnableQuery]` attribute to support OData query options.

```csharp
using System.Linq;
using System.Web.Http;
using System.Web.OData;

public class CustomersController : ODataController
{
    private SalesEntities db = new SalesEntities();

    // GET /odata/Customers
    [EnableQuery]
    public IQueryable<Customer> Get()
    {
        // Optionally filter by ActiveDocs security headers
        string userLogin = Request.Headers
            .GetValues("adeQueryUserLogin")
            .FirstOrDefault();

        if (!string.IsNullOrEmpty(userLogin))
        {
            return db.Customers.Where(c => c.AssignedRep == userLogin);
        }

        return db.Customers;
    }

    // GET /odata/Customers(5)
    [EnableQuery]
    public SingleResult<Customer> Get([FromODataUri] int key)
    {
        return SingleResult.Create(
            db.Customers.Where(c => c.CustomerID == key)
        );
    }

    protected override void Dispose(bool disposing)
    {
        db.Dispose();
        base.Dispose(disposing);
    }
}
```

### Step 6: Add Custom Header Processing

For advanced security scenarios, create a delegating handler that validates the ActiveDocs headers before the request reaches the controller:

```csharp
using System.Net;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;

public class ActiveDocsHeaderHandler : DelegatingHandler
{
    protected override async Task<HttpResponseMessage> SendAsync(
        HttpRequestMessage request,
        CancellationToken cancellationToken)
    {
        IEnumerable<string> userIdValues;
        if (!request.Headers.TryGetValues("adeQueryUserID", out userIdValues))
        {
            return request.CreateErrorResponse(
                HttpStatusCode.Unauthorized,
                "Missing ActiveDocs security headers.");
        }

        return await base.SendAsync(request, cancellationToken);
    }
}
```

Register the handler in `WebApiConfig.Register`:

```csharp
config.MessageHandlers.Add(new ActiveDocsHeaderHandler());
```

### Step 7: Configure the Data View in ActiveDocs

In Solutions Studio, configure the Data View Active Field:

1. Set the **Data Source Type** to **OData**.
2. Enter the service URL: `https://your-server/odata/Customers`.
3. Map entity fields to template columns.
4. Optionally set query filters in the Active Field properties to pass runtime values.

### Step 8: Test the OData Endpoint

Verify the service responds to standard OData URLs:

| URL | Purpose |
|---|---|
| `/odata/$metadata` | Returns the Entity Data Model in CSDL XML format. |
| `/odata/Customers?$filter=City eq 'Auckland'` | Filters customers by city. |
| `/odata/Customers?$select=CustomerID,Name,Email` | Returns only selected properties. |
| `/odata/Customers?$orderby=Name asc` | Orders results alphabetically by name. |
| `/odata/Customers?$top=10` | Returns the first 10 records. |
| `/odata/Customers?$filter=City eq 'Auckland'&$select=Name&$orderby=Name&$top=5` | Combines multiple query options. |

## Google Maps Example

You can build an OData service that returns map images for use with the **Image** Active Field in ActiveDocs templates.

### API Setup

1. Obtain a Google Maps API key from the [Google Cloud Console](https://console.cloud.google.com/).
2. Enable the **Maps Static API** for your project.
3. Store the API key in your application's configuration:

```xml
<appSettings>
  <add key="GoogleMapsApiKey" value="YOUR_API_KEY_HERE" />
</appSettings>
```

### OData Service for Map Images

Create an OData service that accepts location parameters and returns map image data from the Google Static Maps API:

```csharp
using System.Configuration;
using System.IO;
using System.Net.Http;
using System.Web.Http;
using System.Web.OData;

public class MapImagesController : ODataController
{
    private static readonly HttpClient httpClient = new HttpClient();

    // GET /odata/MapImages(Location='Auckland,NZ',Zoom=12,Width=600,Height=400)
    [EnableQuery]
    public async Task<IHttpActionResult> Get(
        [FromODataUri] string Location,
        [FromODataUri] int Zoom = 13,
        [FromODataUri] int Width = 640,
        [FromODataUri] int Height = 480)
    {
        string apiKey = ConfigurationManager.AppSettings["GoogleMapsApiKey"];

        string url = $"https://maps.googleapis.com/maps/api/staticmap"
            + $"?center={Uri.EscapeDataString(Location)}"
            + $"&zoom={Zoom}"
            + $"&size={Width}x{Height}"
            + $"&maptype=roadmap"
            + $"&markers=color:red|{Uri.EscapeDataString(Location)}"
            + $"&key={apiKey}";

        byte[] imageBytes = await httpClient.GetByteArrayAsync(url);

        var result = new HttpResponseMessage(System.Net.HttpStatusCode.OK)
        {
            Content = new ByteArrayContent(imageBytes)
        };
        result.Content.Headers.ContentType =
            new System.Net.Http.Headers.MediaTypeHeaderValue("image/png");

        return ResponseMessage(result);
    }
}
```

### ActiveDocs Template Configuration

To use the map image service in a template:

1. Add an **Image** Active Field to your template in Solutions Studio.
2. Set the image source to **URL**.
3. Configure the URL to point to your OData map endpoint, using template data fields to supply the location parameter:

```
https://your-server/odata/MapImages(Location='{CustomerCity},{CustomerCountry}',Zoom=14,Width=600,Height=300)
```

At assembly time, ActiveDocs replaces the template tokens with actual data values and fetches the corresponding map image for each document.
