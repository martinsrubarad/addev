## Prerequisites

Before you begin integrating with ActiveDocs, ensure the following requirements are met:

- **ActiveDocs Server** installed and running with a valid **Solutions Studio** license.
- **API access enabled** in AdminCenter. Your administrator must enable the REST API and generate at least one API key.
- A network path from your application to the ActiveDocs server over HTTPS (port 443 by default).
- At least one **approved Template Set** containing one or more approved Templates available for document assembly.

## Architecture Overview

ActiveDocs Solutions Studio is built on **ASP.NET** running on the **.NET Framework V4** platform. Understanding the key components will help you design effective integrations.

```
+-----------------+       +-------------------+       +----------------------+
|  Your App /     | HTTPS |  ActiveDocs       |       |  Document Assembly   |
|  Integration    |------>|  REST API (V2)    |------>|  Engine              |
|                 |       |                   |       |  (multi-threaded)    |
+-----------------+       +-------------------+       +----------------------+
                                  |                            |
                          +-------+-------+            +-------+-------+
                          |  WorkCenter   |            |  Delivery     |
                          |  Web App      |            |  Channels     |
                          +---------------+            +---------------+
```

| Component | Description |
| --- | --- |
| **ASP.NET Server** | Hosts the REST API and WorkCenter web application on IIS. |
| **WorkCenter** | Browser-based application for interactive document creation, management, and workflow. |
| **REST API (V2)** | HTTP API for programmatic document production, component management, and delivery. |
| **Document Assembly Engine** | Multi-threaded engine capable of producing 1,000,000+ pages per month. Supports multi-server deployments for horizontal scalability. |
| **AdminCenter** | Administration console for server configuration, API key management, user management, and delivery queue setup. |

## Setting Up API Access

### Obtaining an API Key

1. Open **AdminCenter** on your ActiveDocs server.
2. Navigate to **Configuration > API Keys**.
3. Click **Add API Key** and provide a descriptive name (e.g., `CRM Integration`).
4. Configure the key's permissions scope and subsite access as needed.
5. Copy the generated API key. Store it securely -- it will not be shown again.

### Configuring API Requests

Every request to the ActiveDocs REST API must include the API key in the `apikey` HTTP header:

```http
GET /activedocs/api/v2/jobs HTTP/1.1
Host: your-server
apikey: your-api-key-here
Content-Type: application/json
```

The base URL for all V2 endpoints is:

```
https://{your-server}/activedocs/api/v2/
```

## Your First Document

This walkthrough demonstrates the complete lifecycle of producing a document via the API: constructing a job definition, submitting it, polling for completion, and retrieving the finished document.

### Step 1: Construct the JobDef JSON

The `JobDef` specifies which template set and templates to use, along with the answers (data) to merge into the document. You will need the GUIDs for your Template Set and Template, which can be found in WorkCenter or retrieved via the Design Components API.

```json
{
  "jobItems": [
    {
      "templateSets": [
        {
          "id": "4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67",
          "templates": [
            {
              "id": "A1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6"
            }
          ]
        }
      ],
      "activeDocsAnswers": {
        "version": "3.0",
        "body": {
          "answers": [
            { "name": "ClientName", "value": "Acme Corporation", "type": "Text" },
            { "name": "ContractDate", "value": "2026-04-09 00:00", "type": "Date" },
            { "name": "ContractValue", "value": "50000", "type": "Currency" }
          ]
        }
      }
    }
  ]
}
```

### Step 2: Submit the Job

Post the JobDef to the jobs endpoint to start document assembly:

```http
POST /activedocs/api/v2/jobs/jobdef HTTP/1.1
Host: your-server
apikey: your-api-key-here
Content-Type: application/json
```

A successful submission returns `201 Created` with a `JobQueueItem` containing the allocated Job ID.

### Step 3: Poll for Status

Use the Job ID from the response to poll for completion:

```http
GET /activedocs/api/v2/jobs/{jobId}/status HTTP/1.1
Host: your-server
apikey: your-api-key-here
```

Continue polling until the status indicates the job is complete or has errored.

### Step 4: Retrieve the Document

Once the job is complete, retrieve the document list and download the assembled document:

```http
GET /activedocs/api/v2/jobs/{jobId}/documents HTTP/1.1
Host: your-server
apikey: your-api-key-here
```

The response contains document IDs that you can use to download the actual document files via the Documents API.

### Complete Working Example (JavaScript)

```javascript
const BASE_URL = "https://your-server/activedocs/api/v2";
const API_KEY = "your-api-key-here";

async function produceDocument() {
  // Step 1: Define the job
  const jobDef = {
    jobItems: [
      {
        templateSets: [
          {
            id: "4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67",
            templates: [
              { id: "A1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6" }
            ]
          }
        ],
        activeDocsAnswers: {
          version: "3.0",
          body: {
            answers: [
              { name: "ClientName", value: "Acme Corporation", type: "Text" },
              { name: "ContractDate", value: "2026-04-09 00:00", type: "Date" },
              { name: "ContractValue", value: "50000", type: "Currency" }
            ]
          }
        }
      }
    ]
  };

  // Step 2: Submit the job
  const submitResponse = await fetch(`${BASE_URL}/jobs/jobdef`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "apikey": API_KEY
    },
    body: JSON.stringify(jobDef)
  });

  if (!submitResponse.ok) {
    throw new Error(`Job submission failed: ${submitResponse.status}`);
  }

  const job = await submitResponse.json();
  const jobId = job.id;
  console.log(`Job submitted. ID: ${jobId}`);

  // Step 3: Poll for completion
  let status = "InProgress";
  while (status === "InProgress") {
    await new Promise(resolve => setTimeout(resolve, 2000)); // Wait 2 seconds

    const statusResponse = await fetch(`${BASE_URL}/jobs/${jobId}/status`, {
      headers: { "apikey": API_KEY }
    });

    const statusData = await statusResponse.json();
    status = statusData.status;
    console.log(`Job status: ${status}`);
  }

  if (status === "Error") {
    const errResponse = await fetch(`${BASE_URL}/jobs/${jobId}/errors`, {
      headers: { "apikey": API_KEY }
    });
    const errData = await errResponse.json();
    throw new Error(`Job failed: ${JSON.stringify(errData.errors)}`);
  }

  // Step 4: Retrieve documents
  const docsResponse = await fetch(`${BASE_URL}/jobs/${jobId}/documents`, {
    headers: { "apikey": API_KEY }
  });

  const docsData = await docsResponse.json();
  console.log(`Documents produced: ${docsData.documents.length}`);

  // Download each document
  for (const doc of docsData.documents) {
    const fileResponse = await fetch(`${BASE_URL}/documents/${doc.id}/file`, {
      headers: { "apikey": API_KEY }
    });

    const fileBlob = await fileResponse.blob();
    console.log(`Downloaded document: ${doc.id} (${fileBlob.size} bytes)`);
  }

  return docsData;
}

produceDocument()
  .then(result => console.log("Complete.", result))
  .catch(err => console.error("Error:", err));
```

## Using Postman

ActiveDocs ships with a Postman collection that provides ready-to-use requests for all API endpoints.

### Import the Collection

1. Open Postman and click **Import**.
2. Select the file `ActiveDocsAPI.json` from your ActiveDocs server installation directory.
3. The collection will appear in your Postman sidebar under **ActiveDocs API V2**.

### Configure the Environment

1. In Postman, create a new **Environment** (e.g., `ActiveDocs Dev`).
2. Add the following variables:

| Variable | Value | Description |
| --- | --- | --- |
| `baseUrl` | `https://your-server/activedocs/api/v2` | Your ActiveDocs server base URL |
| `apiKey` | `your-api-key-here` | Your API key from AdminCenter |

3. Select the environment from the dropdown in the top-right corner of Postman.
4. The collection requests are pre-configured to use `{{baseUrl}}` and `{{apiKey}}` variables.

## Sample Code

ActiveDocs ships with sample solutions that demonstrate common integration patterns. These are located at:

```
C:\Program Files\ActiveDocs\Solutions Studio\Samples\
```

| Solution Name | Description |
| --- | --- |
| ActiveDocs JobXML Feeder | Demonstrates constructing and submitting JobXML for automated document production. |
| Automated Document Production | End-to-end example of batch document generation from external data sources. |
| Bulk Email Delivery | Producing and delivering documents to multiple recipients via email. |
| DataView Web Service Google Maps | Integrating Google Maps data into templates using a custom Data View web service. |
| DataView Web Service SQLS | Connecting Data Views to SQL Server databases for dynamic data retrieval. |
| Design Component Migration | Migrating design components between ActiveDocs environments programmatically. |
| Diagnostics Service | Querying server health, version, and configuration diagnostics. |
| Document Web Service -- Adobe Sign | Delivering documents to Adobe Sign for electronic signature workflows. |
| Document Web Service - Alfresco | Delivering documents to the Alfresco content management system. |
| Document Web Service - AWS S3 | Delivering documents to Amazon S3 storage buckets. |
| Document Web Service | General-purpose custom document delivery web service implementation. |
| Document Wizard Automation | Automating the Document Wizard workflow programmatically. |
| Find Design Components | Searching and retrieving design components via the API. |
| Transform Template Set Handler | Implementing a Wizard Step Event Handler to transform template set selections. |
| Wizard Step Event Handler | Implementing custom validation and data injection during Document Wizard steps. |

## Best Practices

### Use HTTPS

Always connect to the ActiveDocs API over HTTPS. HTTP connections expose API keys and document data to interception. Configure your ActiveDocs server with a valid TLS certificate and enforce HTTPS-only connections.

### Batch Documents

When producing multiple documents, group them into a single `JobDef` with multiple `jobItems` rather than submitting individual jobs. Batch processing reduces HTTP overhead and allows the assembly engine to optimize resource usage.

```json
{
  "jobItems": [
    { "templateSets": [{ "id": "SET1...", "templates": [{ "id": "TPL1..." }] }] },
    { "templateSets": [{ "id": "SET1...", "templates": [{ "id": "TPL1..." }] }] },
    { "templateSets": [{ "id": "SET1...", "templates": [{ "id": "TPL1..." }] }] }
  ]
}
```

### Appropriate Polling Intervals

When polling for job status, use a reasonable interval to avoid overloading the server:

| Scenario | Recommended Interval |
| --- | --- |
| Single document, interactive user | 1--2 seconds |
| Small batch (< 50 documents) | 3--5 seconds |
| Large batch (50+ documents) | 10--30 seconds |

For high-volume scenarios, consider using delivery callbacks or webhooks instead of polling.

### Error Handling

Always check the response status code and handle errors gracefully. When a job fails, retrieve the error details using the `GET /api/v2/jobs/{id}/errors` endpoint before retrying. Common error scenarios include invalid template IDs, missing required answers, and license limits.

### Connection Pooling

Reuse HTTP connections when making multiple API calls. Most HTTP client libraries support connection pooling by default. Avoid creating a new HTTP client instance for each request, as this wastes resources and can exhaust available sockets under load.

```javascript
// Good: reuse a single client/session
const headers = { "apikey": API_KEY, "Content-Type": "application/json" };

// Bad: creating new connections per request
// Each fetch() below reuses the underlying connection pool automatically in modern runtimes
```

For .NET integrations, use a single `HttpClient` instance (or `IHttpClientFactory`) rather than creating and disposing clients per request.
