## Delivery Overview

ActiveDocs supports multiple delivery channels for distributing assembled documents to their intended recipients or destinations. Delivery is configured within the `JobDef` and processed by the assembly engine after document production is complete.

### Delivery Channels

| Channel | Description |
| --- | --- |
| **Email** | Send documents as email attachments or inline body content. |
| **Print** | Send documents to network printers or local print queues. |
| **File System** | Save documents to file system locations, network shares, or mapped drives. |
| **SharePoint** | Deliver documents to SharePoint document libraries. |
| **Web Service** | Deliver documents to custom REST endpoints or third-party systems. |

### Delivery Architecture

Delivery is managed through **queues** and **channels**. Delivery queues are configured in AdminCenter and define the connection settings, credentials, and default behaviors for each channel. The `JobDef` references these queues and can override settings per job.

Delivery can be synchronous (completed during job processing) or asynchronous (deferred, requiring external confirmation).

## Email Delivery

Email delivery sends documents to one or more recipients as attachments or as the email body content itself.

### JobEmailQueue Structure

```json
{
  "jobEmailQueue": {
    "deliveryQueueID": "E1F2A3B4C5D6E7F8A9B0C1D2E3F4A5B6",
    "recipients": {
      "to": "client@example.com; partner@example.com",
      "cc": "manager@company.com",
      "bcc": "archive@company.com"
    },
    "sender": "documents@company.com",
    "senderDisplayName": "Company Documents",
    "subject": "Your Contract Documents - {{ContractNumber}}",
    "body": "Please find your contract documents attached.\n\nRegards,\nDocument Services",
    "attachmentType": "File"
  }
}
```

### Email Parameters

| Field | Type | Description |
| --- | --- | --- |
| `deliveryQueueID` | string | The GUID of the email delivery queue configured in AdminCenter. |
| `recipients.to` | string | Semicolon-separated list of primary recipients. |
| `recipients.cc` | string | Semicolon-separated list of CC recipients. |
| `recipients.bcc` | string | Semicolon-separated list of BCC recipients. |
| `sender` | string | The sender email address. |
| `senderDisplayName` | string | Display name for the sender. |
| `subject` | string | Email subject line. Supports answer field placeholders. |
| `body` | string | Email body text. Supports answer field placeholders. |
| `attachmentType` | string | How the document is attached: `None`, `File`, or `Body`. |

### Attachment Types

| Type | Description |
| --- | --- |
| `None` | No document attachment. The email is sent as a notification only. |
| `File` | The document is attached as a file (PDF, DOCX, etc.). |
| `Body` | The document content is embedded as the email body (HTML format). |

### Full JobDef Example with Email Queue

```json
{
  "jobItems": [
    {
      "templateSets": [
        {
          "id": "4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67",
          "templates": [
            { "id": "A1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6" }
          ]
        }
      ],
      "activeDocsAnswers": {
        "version": "3.0",
        "body": {
          "answers": [
            { "name": "ClientName", "value": "Acme Corporation", "type": "Text" },
            { "name": "ContractNumber", "value": "CNT-2026-0042", "type": "Text" }
          ]
        }
      },
      "jobEmailQueue": {
        "deliveryQueueID": "E1F2A3B4C5D6E7F8A9B0C1D2E3F4A5B6",
        "recipients": {
          "to": "legal@acme.com",
          "cc": "contracts@company.com"
        },
        "sender": "documents@company.com",
        "senderDisplayName": "Contract Services",
        "subject": "Contract CNT-2026-0042 - Acme Corporation",
        "body": "Dear Acme Corporation,\n\nPlease find your contract attached.\n\nRegards,\nContract Services",
        "attachmentType": "File"
      }
    }
  ]
}
```

## Print Delivery

Print delivery sends assembled documents directly to network printers. It supports copy counts and extended properties for file output formatting.

### JobPrintQueue Structure

```json
{
  "jobPrintQueue": {
    "deliveryQueueID": "P1A2B3C4D5E6F7A8B9C0D1E2F3A4B5C6",
    "copies": 2
  }
}
```

### Extended Properties for File Output

When the print queue is configured for file output (e.g., printing to a file rather than a physical printer), additional properties control the file format and grouping.

```json
{
  "jobPrintQueue": {
    "deliveryQueueID": "P1A2B3C4D5E6F7A8B9C0D1E2F3A4B5C6",
    "copies": 1,
    "extendedProperties": {
      "filegrouping": "AllInOne",
      "fileformat": "PDF"
    }
  }
}
```

| Property | Values | Description |
| --- | --- | --- |
| `filegrouping` | `AllInOne`, `OnePerDocument`, `OnePerPage` | Controls how documents are grouped in output files. |
| `fileformat` | `PDF`, `DocX`, `RTF`, `Tiff` | The output file format. |

### Printer Optimization for High-Volume

When producing high volumes of print output, configure the following printer settings in AdminCenter to optimize throughput:

| Setting | Description |
| --- | --- |
| **Printer Sharing** | Enable printer sharing to allow multiple assembly threads to send to the same printer simultaneously. |
| **Port Configuration** | Use direct TCP/IP ports rather than Windows printer sharing for faster spool times. |
| **Priority** | Set print job priority to control ordering when multiple jobs compete for the same printer. |
| **Spool Settings** | Configure "Start printing after last page is spooled" for large documents to avoid incomplete output. Use "Start printing immediately" for smaller documents to reduce latency. |

## File System Delivery

File system delivery saves assembled documents to a specified location on the file system, network share, or mapped drive.

### JobDeliveryQueue Structure

```json
{
  "jobDeliveryQueue": {
    "deliveryQueueID": "F1A2B3C4D5E6F7A8B9C0D1E2F3A4B5C6",
    "location": "\\\\fileserver\\documents\\contracts",
    "locationLibrary": "ContractDocuments",
    "locationSubFolder": "2026\\Q2",
    "documentFormat": "PDF",
    "fileNameOption": "AppendDateTime",
    "createDocumentSetFolder": true
  }
}
```

### File System Parameters

| Field | Type | Description |
| --- | --- | --- |
| `deliveryQueueID` | string | The GUID of the file system delivery queue configured in AdminCenter. |
| `location` | string | The root file path or UNC path for document delivery. |
| `locationLibrary` | string | A logical library name within the location. |
| `locationSubFolder` | string | Subfolder path appended to the location. |
| `documentFormat` | string | Output format for delivered documents: `PDF`, `DocX`, `RTF`, etc. |
| `fileNameOption` | string | Controls how file name conflicts are handled (see table below). |
| `createDocumentSetFolder` | boolean | If `true`, creates a subfolder named after the Document Set to group related documents. |

### File Name Options

| Option | Description |
| --- | --- |
| `DoNotAllowDuplicates` | Fails delivery if a file with the same name already exists at the destination. |
| `AllowOverWriting` | Overwrites any existing file with the same name. |
| `AppendCounter` | Appends an incrementing counter to the file name (e.g., `Contract_1.pdf`, `Contract_2.pdf`). |
| `AppendID` | Appends the document GUID to the file name for uniqueness. |
| `AppendDateTime` | Appends the current date and time to the file name (e.g., `Contract_20260409_143022.pdf`). |

## SharePoint Delivery

SharePoint delivery uploads documents to a SharePoint document library.

```json
{
  "jobDeliveryQueue": {
    "deliveryQueueID": "S1A2B3C4D5E6F7A8B9C0D1E2F3A4B5C6",
    "location": "https://sharepoint.company.com/sites/documents",
    "locationLibrary": "Shared Documents",
    "locationSubFolder": "Contracts/2026",
    "documentFormat": "PDF",
    "fileNameOption": "AppendCounter"
  }
}
```

### SharePoint Configuration

SharePoint delivery queues are configured in AdminCenter with the following settings:

| Setting | Description |
| --- | --- |
| **Site URL** | The SharePoint site URL. |
| **Library** | The target document library name. |
| **Authentication** | Service account credentials or app-only authentication for SharePoint Online. |
| **Metadata Mapping** | Optional mapping of answer fields to SharePoint column values. |

## Web Service Delivery

Web service delivery sends documents to custom REST endpoints, enabling integration with third-party document management systems, e-signature platforms, and other services.

### IDocumentManagerNET Interface

Custom delivery web services implement the `IDocumentManagerNET` interface. This interface defines the contract between ActiveDocs and your delivery endpoint.

```csharp
public interface IDocumentManagerNET
{
    DocumentManagerResult DeliverDocument(
        string documentID,
        string documentName,
        byte[] documentData,
        string documentFormat,
        Dictionary<string, string> properties
    );
}
```

The web service receives the assembled document as binary data along with metadata, processes the delivery, and returns a result indicating success or failure.

### Web Service Configuration

Configure web service delivery queues in AdminCenter by specifying:

| Setting | Description |
| --- | --- |
| **Endpoint URL** | The URL of your REST delivery endpoint. |
| **Authentication** | API key, OAuth token, or basic authentication credentials. |
| **Timeout** | Maximum time to wait for the web service to respond. |
| **Retry Policy** | Number of retry attempts on failure. |

## Asynchronous Delivery

Some delivery channels operate asynchronously. When a delivery service cannot confirm completion immediately, it returns an `ASYNC` status with HTTP `200 OK`. The delivery remains in a pending state until confirmed by an external callback.

### Confirming Delivery Status

Confirm a single delivery:

```http
PUT /activedocs/api/v2/deliveries/{id}/status HTTP/1.1
Host: your-server
apikey: your-api-key-here
Content-Type: application/json
```

```json
{
  "status": "Complete",
  "message": "Document delivered successfully to external system."
}
```

Confirm multiple deliveries in batch:

```http
PUT /activedocs/api/v2/deliveries/status HTTP/1.1
Host: your-server
apikey: your-api-key-here
Content-Type: application/json
```

```json
{
  "deliveries": [
    { "id": "D1A2B3C4D5E6F7A8B9C0D1E2F3A4B5C6", "status": "Complete", "message": "OK" },
    { "id": "D2B3C4D5E6F7A8B9C0D1E2F3A4B5C6D7", "status": "Error", "message": "Remote system unavailable" }
  ]
}
```

### Delivery Status Values

| Status | Description |
| --- | --- |
| `Pending` | Delivery has been queued but not yet processed. |
| `InProgress` | Delivery is currently being processed. |
| `Complete` | Delivery completed successfully. |
| `Error` | Delivery failed. Check the `message` field for details. |
| `ASYNC` | Delivery has been handed off to an external system and awaits confirmation. |
| `Cancelled` | Delivery was cancelled before completion. |

## Delivery Settings Override in JobDef

Default delivery queue settings can be overridden at the job level within the `JobDef`. This allows you to customize delivery behavior per job without modifying the queue configuration in AdminCenter.

```json
{
  "jobItems": [
    {
      "templateSets": [
        {
          "id": "4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67",
          "templates": [{ "id": "A1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6" }]
        }
      ],
      "jobDeliveryQueue": {
        "deliveryQueueID": "F1A2B3C4D5E6F7A8B9C0D1E2F3A4B5C6",
        "location": "\\\\fileserver\\documents\\priority",
        "locationSubFolder": "urgent",
        "documentFormat": "PDF",
        "fileNameOption": "AppendDateTime"
      },
      "jobEmailQueue": {
        "deliveryQueueID": "E1F2A3B4C5D6E7F8A9B0C1D2E3F4A5B6",
        "recipients": {
          "to": "urgent@company.com"
        },
        "subject": "URGENT: Document Ready",
        "attachmentType": "File"
      }
    }
  ]
}
```

When both a delivery queue default and a `JobDef` override are present, the `JobDef` values take precedence.

## Document Set Delivery

Document Set delivery controls how documents within a set are packaged and delivered together. This is configured at the template set level and allows fine-grained control over which templates contribute to the delivery output.

### Enable Document Set Delivery

Enable Document Set delivery in the template set configuration:

```json
{
  "templateSets": [
    {
      "id": "4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67",
      "enableDocumentSetDelivery": true,
      "templates": [
        {
          "id": "A1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6",
          "deliveryOption": "Deliver"
        },
        {
          "id": "B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6E7",
          "deliveryOption": "DeliverAsEmailBody"
        },
        {
          "id": "C3D4E5F6A7B8C9D0E1F2A3B4C5D6E7F8",
          "deliveryOption": "DontDeliver"
        }
      ]
    }
  ]
}
```

### Per-Template Delivery Options

| Option | Description |
| --- | --- |
| `DontDeliver` | The template output is assembled but not included in the delivery. Useful for internal-only documents or drafts. |
| `DeliverAsEmailBody` | The template output is used as the email body content when delivering via email. Only one template per set can use this option. |
| `Deliver` | The template output is included as a standard delivery attachment or file. This is the default. |

### PDF Merging

When Document Set delivery is enabled and the output format is PDF, all delivered templates are merged into a single PDF file by default. This produces a consolidated document package rather than multiple individual files.

To control merging behavior, configure the following in the template set:

```json
{
  "templateSets": [
    {
      "id": "4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67",
      "enableDocumentSetDelivery": true,
      "mergeDocumentSetPDF": true,
      "templates": [
        {
          "id": "A1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6",
          "deliveryOption": "Deliver"
        },
        {
          "id": "B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6E7",
          "deliveryOption": "Deliver"
        }
      ]
    }
  ]
}
```

When `mergeDocumentSetPDF` is `true`, the output from all templates with `deliveryOption` set to `Deliver` are combined into a single PDF in the order they appear in the template list.
