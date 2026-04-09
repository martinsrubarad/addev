## Overview

ActiveDocs supports integration with external document management systems (DMS) to store, retrieve, and manage assembled documents. You can implement a custom document manager by building a .NET class that implements the `IDocumentManagerNET` interface, or by exposing a REST web service that ActiveDocs calls during delivery.

This guide covers the interface contract, REST service methods, and integration patterns for Adobe Sign, Alfresco, and AWS S3.

## IDocumentManagerNET Interface

The `IDocumentManagerNET` interface defines the contract that your custom document manager must implement.

### SetDocument

Stores a document in the external system. ActiveDocs calls this method during document delivery.

```csharp
void SetDocument(
    byte[] document,        // The assembled document content
    string internalID,      // ActiveDocs internal document ID
    string externalID,      // External reference ID (may be empty on first save)
    string docName,         // Document file name without extension
    string docExtension,    // File extension (e.g., "pdf", "docx")
    string answersXml,      // XML containing all template answers
    string settingsXml      // XML containing delivery and configuration settings
);
```

**Parameters:**

| Parameter | Type | Description |
|---|---|---|
| `document` | `byte[]` | The raw bytes of the assembled document. |
| `internalID` | `string` | The unique ActiveDocs document identifier. |
| `externalID` | `string` | An external system identifier. Empty on first delivery; populated on subsequent updates if your implementation returns an ID. |
| `docName` | `string` | The document name as configured in the template delivery settings. |
| `docExtension` | `string` | The output file extension (e.g., `pdf`, `docx`, `xlsx`). |
| `answersXml` | `string` | XML containing all answers collected during document assembly. |
| `settingsXml` | `string` | XML containing delivery configuration parameters. |

### GetDocument

Retrieves a previously stored document from the external system.

```csharp
byte[] GetDocument(string documentID);
```

**Parameters:**

| Parameter | Type | Description |
|---|---|---|
| `documentID` | `string` | The external document identifier returned by a prior `SetDocument` call. |

**Returns:** The document content as a byte array.

## REST Web Service Methods

If you prefer a REST-based integration, implement the following HTTP endpoints. ActiveDocs calls these during delivery and retrieval operations.

### POST /documents

Stores a new document.

```http
POST /documents HTTP/1.1
Content-Type: application/octet-stream
X-AD-InternalID: 12345
X-AD-DocName: CustomerAgreement
X-AD-DocExtension: pdf
```

The request body contains the raw document bytes. Document metadata is passed in HTTP headers.

**Response:**

```json
{
  "documentID": "ext-98765",
  "status": "stored"
}
```

### GET /documents/{id}

Retrieves a stored document by its external identifier.

```http
GET /documents/ext-98765 HTTP/1.1
Accept: application/octet-stream
```

**Response:** The document content as a binary stream with the appropriate `Content-Type` header.

### PUT /documents/{id}

Updates an existing document (for example, when a template is re-assembled with new answers).

```http
PUT /documents/ext-98765 HTTP/1.1
Content-Type: application/octet-stream
X-AD-InternalID: 12345
X-AD-DocName: CustomerAgreement
X-AD-DocExtension: pdf
```

**Response:**

```json
{
  "documentID": "ext-98765",
  "status": "updated"
}
```

## Adobe Sign Integration

ActiveDocs integrates with Adobe Sign to enable electronic signature workflows for assembled documents.

### Overview

The integration sends completed documents to Adobe Sign for signature collection, monitors signing status, and updates the ActiveDocs document record when signing is complete.

### Configuration

Configure the Adobe Sign integration in AdminCenter under **Integrations > Adobe Sign**:

| Setting | Description |
|---|---|
| **API Access Token** | OAuth token from your Adobe Sign account. |
| **API Base URL** | The Adobe Sign API endpoint (e.g., `https://api.na1.adobesign.com`). |
| **Delivery Channel** | The ActiveDocs delivery channel that triggers Adobe Sign. |
| **Document Properties** | Map ActiveDocs document properties to Adobe Sign agreement fields (signer email, signer name, agreement name). |

### Workflow

The signing workflow follows these stages:

1. **Document Created** — ActiveDocs assembles the document and delivers it to the Adobe Sign delivery channel.
2. **Send to Adobe Sign** — The integration uploads the document to Adobe Sign and creates an agreement with the configured signers.
3. **Signing** — Signers receive email notifications and sign the document via the Adobe Sign interface.
4. **Status Updates** — ActiveDocs polls Adobe Sign for status changes and updates the document's delivery status.
5. **Final** — When all signatures are collected, the signed document is retrieved and stored back in ActiveDocs.

## Alfresco DMS Integration via CMIS

ActiveDocs integrates with Alfresco using the CMIS (Content Management Interoperability Services) protocol via the **PortCMIS** library.

### Web.config Settings

Configure the CMIS connection in your document manager's `web.config`:

```xml
<appSettings>
  <add key="CMISAtomPubUrl"
       value="https://alfresco-server/alfresco/api/-default-/public/cmis/versions/1.1/atom" />
  <add key="CMISUser" value="admin" />
  <add key="CMISPassword" value="your-password" />
  <add key="CMISDocumentType" value="D:ad:activedocsDocument" />
</appSettings>
```

| Setting | Description |
|---|---|
| `CMISAtomPubUrl` | The Alfresco CMIS AtomPub binding URL. |
| `CMISUser` | The user account for CMIS authentication. |
| `CMISPassword` | The password for the CMIS user. |
| `CMISDocumentType` | The CMIS document type to use when storing documents. Use `D:ad:activedocsDocument` for the custom ActiveDocs type. |

### Custom Type Definition

Define a custom Alfresco content type for ActiveDocs documents. Deploy this type definition XML to Alfresco:

```xml
<type name="ad:activedocsDocument">
  <title>ActiveDocs Document</title>
  <parent>cm:content</parent>
  <properties>
    <property name="ad:internalID">
      <title>ActiveDocs Internal ID</title>
      <type>d:text</type>
      <mandatory>false</mandatory>
    </property>
    <property name="ad:externalID">
      <title>External ID</title>
      <type>d:text</type>
      <mandatory>false</mandatory>
    </property>
    <property name="ad:documentName">
      <title>Document Name</title>
      <type>d:text</type>
      <mandatory>false</mandatory>
    </property>
    <property name="ad:createdDate">
      <title>Created Date</title>
      <type>d:datetime</type>
      <mandatory>false</mandatory>
    </property>
  </properties>
</type>
```

### SetDocument Implementation

```csharp
using PortCMIS;
using PortCMIS.Client;
using PortCMIS.Client.Impl;
using PortCMIS.Data.Impl;
using System.Collections.Generic;
using System.Configuration;
using System.IO;

public class AlfrescoDocumentManager : IDocumentManagerNET
{
    private ISession GetCmisSession()
    {
        var parameters = new Dictionary<string, string>
        {
            [SessionParameter.BindingType] = BindingType.AtomPub,
            [SessionParameter.AtomPubUrl] =
                ConfigurationManager.AppSettings["CMISAtomPubUrl"],
            [SessionParameter.User] =
                ConfigurationManager.AppSettings["CMISUser"],
            [SessionParameter.Password] =
                ConfigurationManager.AppSettings["CMISPassword"]
        };

        SessionFactory factory = SessionFactory.NewInstance();
        IList<IRepository> repositories = factory.GetRepositories(parameters);
        return repositories[0].CreateSession();
    }

    public void SetDocument(
        byte[] document, string internalID, string externalID,
        string docName, string docExtension,
        string answersXml, string settingsXml)
    {
        ISession session = GetCmisSession();

        // Get or create the target folder
        IFolder rootFolder = session.GetRootFolder();
        string folderPath = "/ActiveDocs/" + DateTime.UtcNow.ToString("yyyy/MM");
        IFolder targetFolder = GetOrCreateFolderPath(session, rootFolder, folderPath);

        // Set document properties
        string docType = ConfigurationManager.AppSettings["CMISDocumentType"];
        var properties = new Dictionary<string, object>
        {
            ["cmis:objectTypeId"] = docType,
            ["cmis:name"] = $"{docName}.{docExtension}",
            ["ad:internalID"] = internalID,
            ["ad:externalID"] = externalID,
            ["ad:documentName"] = docName,
            ["ad:createdDate"] = DateTime.UtcNow
        };

        // Create content stream
        ContentStream contentStream = new ContentStream
        {
            FileName = $"{docName}.{docExtension}",
            MimeType = GetMimeType(docExtension),
            Length = document.Length,
            Stream = new MemoryStream(document)
        };

        // Create the document in Alfresco
        targetFolder.CreateDocument(properties, contentStream, null);
    }

    public byte[] GetDocument(string documentID)
    {
        ISession session = GetCmisSession();

        ICmisObject obj = session.GetObject(documentID);
        IDocument doc = obj as IDocument;

        using (Stream stream = doc.GetContentStream().Stream)
        using (MemoryStream ms = new MemoryStream())
        {
            stream.CopyTo(ms);
            return ms.ToArray();
        }
    }

    private string GetMimeType(string extension)
    {
        switch (extension.ToLower())
        {
            case "pdf": return "application/pdf";
            case "docx": return "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
            case "xlsx": return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            default: return "application/octet-stream";
        }
    }

    private IFolder GetOrCreateFolderPath(
        ISession session, IFolder root, string path)
    {
        // Implementation omitted for brevity — walk path segments,
        // creating folders as needed via root.CreateFolder()
        throw new NotImplementedException();
    }
}
```

## AWS S3 Integration

Store assembled documents in Amazon S3 buckets with metadata tagging.

### SetDocument Implementation

```csharp
using Amazon;
using Amazon.S3;
using Amazon.S3.Model;
using System.IO;

public class S3DocumentManager : IDocumentManagerNET
{
    private const string BucketName = "activedocs-documents";

    private AmazonS3Client GetS3Client()
    {
        var config = new AmazonS3Config
        {
            RegionEndpoint = RegionEndpoint.APSoutheast2,
            Timeout = TimeSpan.FromSeconds(30),
            MaxErrorRetry = 3
        };

        return new AmazonS3Client(
            "YOUR_ACCESS_KEY",
            "YOUR_SECRET_KEY",
            config);
    }

    public void SetDocument(
        byte[] document, string internalID, string externalID,
        string docName, string docExtension,
        string answersXml, string settingsXml)
    {
        using (var client = GetS3Client())
        using (var stream = new MemoryStream(document))
        {
            string key = $"documents/{DateTime.UtcNow:yyyy/MM}/{internalID}/{docName}.{docExtension}";

            var request = new PutObjectRequest
            {
                BucketName = BucketName,
                Key = key,
                InputStream = stream,
                ContentType = GetMimeType(docExtension)
            };

            // Attach ActiveDocs metadata
            request.Metadata.Add("x-amz-meta-ad-internalid", internalID);
            request.Metadata.Add("x-amz-meta-ad-externalid", externalID);
            request.Metadata.Add("x-amz-meta-ad-docname", docName);
            request.Metadata.Add("x-amz-meta-ad-created",
                DateTime.UtcNow.ToString("o"));

            PutObjectResponse response = client.PutObject(request);
        }
    }

    public byte[] GetDocument(string documentID)
    {
        using (var client = GetS3Client())
        {
            var request = new GetObjectRequest
            {
                BucketName = BucketName,
                Key = documentID
            };

            using (GetObjectResponse response = client.GetObject(request))
            using (MemoryStream ms = new MemoryStream())
            {
                response.ResponseStream.CopyTo(ms);
                return ms.ToArray();
            }
        }
    }

    private string GetMimeType(string extension)
    {
        switch (extension.ToLower())
        {
            case "pdf": return "application/pdf";
            case "docx": return "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
            default: return "application/octet-stream";
        }
    }
}
```

## Asynchronous Delivery Pattern

For integrations where document processing takes significant time (e.g., external approval workflows, virus scanning, format conversion), ActiveDocs supports an asynchronous delivery pattern.

### ASYNC Response

When your document management service receives a document via `POST /documents`, it can return an `ASYNC` status to indicate that processing will complete later:

```json
{
  "documentID": "ext-98765",
  "status": "ASYNC"
}
```

ActiveDocs marks the delivery as **In Progress** and waits for a confirmation callback.

### Delivery Confirmation

When your service finishes processing, it notifies ActiveDocs by calling the delivery status endpoint:

```http
PUT /api/v2/deliveries/status HTTP/1.1
Host: activedocs-server
apikey: your-api-key
Content-Type: application/json
```

```json
{
  "internalID": "12345",
  "externalID": "ext-98765",
  "status": "Completed",
  "message": "Document stored and indexed successfully."
}
```

**Status values:**

| Status | Description |
|---|---|
| `Completed` | The document was successfully processed and stored. |
| `Failed` | Processing failed. Include a descriptive `message` for troubleshooting. |

If the external service does not confirm delivery within the configured timeout period, ActiveDocs marks the delivery as **Timed Out** and can be configured to retry automatically.
