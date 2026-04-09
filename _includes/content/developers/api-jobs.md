The Jobs API is the primary interface for automated document production. It provides endpoints for submitting document assembly jobs, monitoring their progress, retrieving results, and managing the job queue. A job takes a **JobDef** specification containing templates, answer data, and delivery instructions, and produces one or more assembled documents.

## Search Jobs

Search for document assembly jobs based on date range, status, and external reference.

```
GET /api/v2/jobs
```

### Query Parameters

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `rowlimit` | integer | `0` | Maximum number of results to return. `0` returns all matching jobs up to the site-configured limit. |
| `externalref` | string | | Return all jobs created with the same external reference (e.g. `Batch-1234`). |
| `searchdateoption` | string | | Date filter preset. See values below. |
| `searchstatusoption` | string | | Filter by job status: `InProgress`, `Complete`, or `Error`. Best used with a date option. |
| `startdate` | date-time | | Start of a custom date range. Requires `searchdateoption=DateRange`. |
| `enddate` | date-time | | End of a custom date range. Requires `searchdateoption=DateRange`. |

**searchdateoption values:**

| Value | Description |
| --- | --- |
| `AllDates` | No date filtering. |
| `Today` | Jobs created today. |
| `Yesterday` | Jobs created yesterday. |
| `ThisWeek` | Jobs created this week. |
| `LastWeek` | Jobs created last week. |
| `ThisMonth` | Jobs created this month. |
| `LastMonth` | Jobs created last month. |
| `DateRange` | Custom range using `startdate` and `enddate`. |

### Response

`200` -- Returns an array of `JobQueueItem` objects.

### Example

```http
GET /api/v2/jobs?searchstatusoption=Complete&searchdateoption=LastWeek&rowlimit=10
```

---

## Get Queued Job

Retrieve a queued job by Job ID or Document ID, with optionally included related models.

```
GET /api/v2/jobs/{id}
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Job ID or Document ID (GUID, uppercase, no hyphens). |

### Query Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `include` | integer or string | Related models to include. Accepts a bitwise combination of flags or the option name. |

**eJobIncludeOptions flags:**

| Flag | Value | Description |
| --- | --- | --- |
| `None` | 0 | No related models included. |
| `JobDocuments` | 1 | Include the list of documents produced by the job. |
| `JobDef` | 2 | Include the job definition used to create the job. |
| `JobErrors` | 4 | Include any errors recorded against the job. |
| `All` | 7 | Include all related models (JobDocuments + JobDef + JobErrors). |

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns a `QueuedJob` model with the specified related models. |
| `204` | No Content -- Job not found. |

### Example

```http
GET /api/v2/jobs/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67?include=All
```

---

## Get Job Status

Check the current status of a job. Typically used to poll whether a job has completed or encountered an error.

```
GET /api/v2/jobs/{id}/status
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Job ID or Document ID. |

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns a `JobQueueItem` with status information. |
| `204` | No Content -- Job not found. |

> **TIP:** For more detail, use the parent endpoint `GET /api/v2/jobs/{id}` with the `include` parameter to retrieve the full model along with individual document statuses, delivery statuses, and error information in a single request.

---

## Get Job Documents

Retrieve the documents produced by a job. Use this endpoint to obtain Document IDs and Delivery IDs for subsequent operations such as downloading document files or checking delivery status.

```
GET /api/v2/jobs/{id}/documents
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Job ID or Document ID. |

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns a `JobQueueDocuments` model containing the job summary and an array of associated documents with their Document IDs and Delivery IDs. |
| `204` | No Content -- Job not found. |

---

## Get Job Definition

Retrieve the job definition that was used to create the job, including JobItems and answer data.

```
GET /api/v2/jobs/{id}/jobdef
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Job ID or Document ID. |

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns a `JobQueueJobDef` model containing the full JobDef with JobItems and ActiveDocsAnswers. |
| `204` | No Content -- Job not found. |

---

## Get Job Errors

Retrieve any errors recorded against a job.

```
GET /api/v2/jobs/{id}/errors
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Job ID or Document ID. |

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns a `JobQueueErrors` model containing the job summary and an array of error details. |
| `204` | No Content -- Job not found. |

---

## Delete / Cancel Job

Cancel a running job or permanently delete a job and all its associated data from the queue.

```
DELETE /api/v2/jobs/{id}
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Job ID (GUID, uppercase, no hyphens). |

### Query Parameters

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `cancelmessage` | string | `""` | Optional message to log when cancelling the job. |
| `purge` | boolean | `false` | `false` = cancel the job (sets status to cancelled). `true` = permanently delete the job and all associated data. |

### Responses

| Status | Description |
| --- | --- |
| `200` | OK -- Job successfully cancelled or deleted. |
| `204` | No Content -- Job not found. |

### Example

```http
DELETE /api/v2/jobs/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67?cancelmessage=No+longer+required&purge=false
```

---

## Document Conversion

Convert a document from one format to another (e.g. DOCX to PDF). The source document file is submitted in the request body.

```
POST /api/v2/jobs/conversions
```

### Request Body

A `DocumentFileConversion` object.

**Content-Type:** `application/json`

| Field | Type | Description |
| --- | --- | --- |
| `documentName` | string | The name to assign to the converted document. |
| `documentFromFormat` | string | The current format of the source document (e.g. `DocX`, `Word97`). |
| `documentToFormat` | string | The target format for the conversion (e.g. `PDF`, `PDFA_2b`). |
| `fileBytes` | string | Base64-encoded byte array of the source document file. |

### Responses

| Status | Description |
| --- | --- |
| `200` | OK |
| `201` | Returns a `DocumentSummary` object with the conversion status and any errors. |

### Example

```json
{
  "documentName": "Quarterly Report",
  "documentFromFormat": "DocX",
  "documentToFormat": "PDF",
  "fileBytes": "UEsDBBQAAAAIAA1..."
}
```

---

## Submit Job

Submit a new document assembly job. This is the primary endpoint for creating documents programmatically. The API validates the JobDef, creates a Job Queue Item, and starts the document assembly process.

```
POST /api/v2/jobs/jobdef
```

### Request Body

A `JobDef` model containing the complete specification for assembling and optionally delivering one or more documents.

**Content-Type:** `application/json`

### Responses

| Status | Description |
| --- | --- |
| `200` | OK |
| `201` | Returns a `JobQueueItem` containing the allocated Job ID and initial status. Use this Job ID to poll for completion. |

### Minimum Requirements

- At least one `JobItem` in the `jobItems` array.
- Each `JobItem` must reference at least one Template Set containing at least one Template.

### Example

```http
POST /api/v2/jobs/jobdef
Content-Type: application/json
apikey: your-api-key-here
```

See the [JobDef Structure](#jobdef-structure) section below for a complete request body example.

---

## Get JobXML (Legacy)

Retrieve the job and its associated job definition in XML format.

```
GET /api/v2/jobs/{id}/jobxml
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Job ID or Document ID. |

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns the Job Queue Item and associated JobXML containing JobItems and ActiveDocsAnswers data (`application/xml`). |

> **NOTE:** This endpoint is retained for legacy integrations only. New integrations should use `GET /api/v2/jobs/{id}/jobdef` which returns the definition in JSON format.

---

## Job Status Values

| Status | Description |
| --- | --- |
| `InProgress` | The job is currently being processed by the document assembly engine. |
| `Complete` | All documents in the job have been successfully assembled and any deliveries have been completed. |
| `Error` | One or more errors occurred during job processing. Use the errors endpoint to retrieve details. |

---

## JobDef Structure

The `JobDef` model is the specification that drives document assembly. It defines what templates to use, what answer data to merge, how to evaluate calculations, and where to deliver the finished documents.

### Key Properties

| Property | Type | Description |
| --- | --- | --- |
| `externalRef` | string | An external reference for correlating jobs with your system (e.g. order number, case ID). Searchable via the `externalref` query parameter. |
| `subsite` | string | The subsite context for the job. Controls which templates and delivery queues are available. |
| `username` | string | The user context for the job. Used for audit trail and access control. |
| `language` | string | Language code for the job (e.g. `en`, `fr`). Affects template language selection and date/number formatting. |
| `documentFormat` | string | Output document format (e.g. `PDF`, `DocX`). See the Document Formats table in the API Overview. |
| `evaluateOption` | string | Controls calculation and validation behaviour. See [Evaluate Options](#evaluate-options). |
| `saveAnswersOption` | string | Controls how answer data is saved with the document. See [SaveAnswers Options](#saveanswers-options). |
| `jobStatusCallback` | string | URL to receive a webhook notification when the job status changes. See [Integration Patterns](#integration-patterns). |
| `template` | object | A single template reference (use for simple single-template jobs). |
| `templateSet` | object | A single template set reference. |
| `templateSets` | array | An array of template set references (use for multi-template-set jobs). |
| `deliveryQueues` | array | An array of delivery queue configurations for routing finished documents. |
| `jobItems` | array | An array of `JobItem` objects. Each JobItem produces one document set. |

### Complete JobDef Example

```json
{
  "externalRef": "ORD-2026-00142",
  "subsite": "Sales",
  "username": "jsmith",
  "language": "en",
  "documentFormat": "PDF",
  "evaluateOption": "PerformCalcs",
  "saveAnswersOption": "SaveInitialAnswers",
  "jobStatusCallback": "https://example.com/api/webhooks/activedocs",
  "jobItems": [
    {
      "templateSets": [
        {
          "name": "Customer Proposal Pack",
          "templates": [
            {
              "name": "Cover Letter"
            },
            {
              "name": "Product Quotation"
            },
            {
              "name": "Terms and Conditions"
            }
          ]
        }
      ],
      "deliveryQueues": [
        {
          "name": "Email Delivery",
          "deliverySettings": {
            "email": {
              "sender": "proposals@example.com",
              "subject": "Your Proposal - ORD-2026-00142",
              "message": "Please find your proposal documents attached.",
              "recipients": [
                {
                  "emailAddress": "customer@example.com",
                  "recipientType": "To"
                },
                {
                  "emailAddress": "sales-archive@example.com",
                  "recipientType": "BCC"
                }
              ],
              "attachmentType": "File"
            }
          }
        }
      ],
      "answers": {
        "answerGroups": [
          {
            "name": "CustomerDetails",
            "answers": [
              {
                "name": "CompanyName",
                "value": "Acme Corporation",
                "type": "Text"
              },
              {
                "name": "ContactName",
                "value": "Jane Doe",
                "type": "Text"
              },
              {
                "name": "ProposalDate",
                "value": "2026-04-09",
                "type": "Date"
              },
              {
                "name": "DiscountRate",
                "value": "12.5",
                "type": "Percentage"
              },
              {
                "name": "IncludeWarranty",
                "value": "true",
                "type": "YesNo"
              }
            ]
          }
        ]
      }
    }
  ]
}
```

---

## Answer Data Types

Each answer value in the JobDef must specify a data type. The type determines how the value is interpreted and formatted in the assembled document.

| Type | Description | Example Value |
| --- | --- | --- |
| `Text` | Plain text string. | `"Acme Corporation"` |
| `Numeric` | Numeric value. | `"42"` or `"3.14159"` |
| `Currency` | Currency value. Formatting is determined by the template locale. | `"1250.00"` |
| `Percentage` | Percentage value. Stored as a decimal number. | `"12.5"` |
| `Date` | Date value. Use ISO 8601 format. | `"2026-04-09"` |
| `Time` | Time value. | `"14:30:00"` |
| `YesNo` | Boolean value. | `"true"` or `"false"` |
| `Image` | Base64-encoded image data or a URL to an image resource. | `"data:image/png;base64,iVBOR..."` |
| `Hyperlink` | A URL. | `"https://example.com"` |
| `Snippet` | Reference to a design component snippet by name or ID. | `"Legal Disclaimer v2"` |

---

## Basic Answer Structure

Answers are organized into answer groups. Each group contains a flat list of named answer values.

```json
{
  "answers": {
    "answerGroups": [
      {
        "name": "PolicyDetails",
        "answers": [
          {
            "name": "PolicyNumber",
            "value": "POL-2026-001234",
            "type": "Text"
          },
          {
            "name": "EffectiveDate",
            "value": "2026-05-01",
            "type": "Date"
          },
          {
            "name": "PremiumAmount",
            "value": "1500.00",
            "type": "Currency"
          },
          {
            "name": "IsRenewal",
            "value": "false",
            "type": "YesNo"
          }
        ]
      }
    ]
  }
}
```

---

## Repeating Items

For tabular or repeating data (e.g. line items in an invoice, dependents on a policy), use answer groups with `type` set to `RepeatingGroup`. Each repetition is represented as a nested answer group.

```json
{
  "answers": {
    "answerGroups": [
      {
        "name": "InvoiceHeader",
        "answers": [
          {
            "name": "InvoiceNumber",
            "value": "INV-00567",
            "type": "Text"
          },
          {
            "name": "InvoiceDate",
            "value": "2026-04-09",
            "type": "Date"
          }
        ]
      },
      {
        "name": "LineItems",
        "type": "RepeatingGroup",
        "answerGroups": [
          {
            "name": "LineItem",
            "answers": [
              {
                "name": "Description",
                "value": "Widget A",
                "type": "Text"
              },
              {
                "name": "Quantity",
                "value": "10",
                "type": "Numeric"
              },
              {
                "name": "UnitPrice",
                "value": "25.00",
                "type": "Currency"
              }
            ]
          },
          {
            "name": "LineItem",
            "answers": [
              {
                "name": "Description",
                "value": "Widget B",
                "type": "Text"
              },
              {
                "name": "Quantity",
                "value": "5",
                "type": "Numeric"
              },
              {
                "name": "UnitPrice",
                "value": "42.50",
                "type": "Currency"
              }
            ]
          },
          {
            "name": "LineItem",
            "answers": [
              {
                "name": "Description",
                "value": "Consulting Services",
                "type": "Text"
              },
              {
                "name": "Quantity",
                "value": "8",
                "type": "Numeric"
              },
              {
                "name": "UnitPrice",
                "value": "150.00",
                "type": "Currency"
              }
            ]
          }
        ]
      }
    ]
  }
}
```

---

## Evaluate Options

The `evaluateOption` property controls how the document assembly engine processes calculations and validation rules defined in the template.

| Option | Description |
| --- | --- |
| `None` | No calculations or validation. Answers are merged as-is into the template. Fastest option for pre-validated data. |
| `PerformCalcs` | Run all calculation rules defined in the template. Calculated fields are populated based on the provided answers. |
| `PerformCalcsValidate` | Run calculations and then validate the answers against the validation rules defined in the template. If validation fails, the job will report errors. |
| `ProcessNestedAnswers` | Process complex nested answer structures, including dynamic snippet resolution and conditional answer evaluation. Use this when templates contain advanced logic. |

---

## SaveAnswers Options

The `saveAnswersOption` property controls how answer data is persisted with the assembled document.

| Option | Description |
| --- | --- |
| `DoNotSave` | Answer data is not saved with the document. The document file is produced but cannot be regenerated from its answers. |
| `SaveInitialAnswers` | Save the answer data exactly as provided in the JobDef. This is the default behaviour. Allows the document to be regenerated with the original inputs. |
| `SaveResolvedAnswers` | Save the complete answer set after evaluation, including all calculated and resolved values. Useful when you need the full computed state for downstream processing. |

---

## Template Sets in JobDef

Template sets group one or more templates that are assembled together as a document set. There are several ways to reference template sets in a JobDef.

### By Name

Reference a published template set by its name. The latest approved version is used.

```json
{
  "templateSets": [
    {
      "name": "Customer Onboarding Pack",
      "templates": [
        { "name": "Welcome Letter" },
        { "name": "Account Agreement" },
        { "name": "Privacy Notice" }
      ]
    }
  ]
}
```

### By ID

Reference a specific template set and templates by their component IDs.

```json
{
  "templateSets": [
    {
      "id": "4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67",
      "templates": [
        { "id": "A1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6" },
        { "id": "B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6A1" }
      ]
    }
  ]
}
```

### Inline Definition

Define a template set inline with multiple templates. This is useful when you need to assemble an ad-hoc combination of templates that is not saved as a published template set.

```json
{
  "templateSets": [
    {
      "name": "Ad-Hoc Report Pack",
      "templates": [
        {
          "name": "Executive Summary",
          "id": "A1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6"
        },
        {
          "name": "Financial Appendix",
          "id": "C3D4E5F6A7B8C9D0E1F2A3B4C5D6A1B2"
        },
        {
          "name": "Risk Assessment",
          "id": "D4E5F6A7B8C9D0E1F2A3B4C5D6A1B2C3"
        }
      ]
    }
  ]
}
```

---

## Delivery Queues in JobDef

Delivery queues define where and how assembled documents are sent after production. Each JobItem can specify one or more delivery queues. The delivery queue configuration varies by channel type.

### Email Delivery

Send documents via email with configurable recipients, subject, body, and attachment handling.

```json
{
  "deliveryQueues": [
    {
      "name": "Email Delivery",
      "deliverySettings": {
        "email": {
          "sender": "noreply@example.com",
          "subject": "Your Document is Ready",
          "message": "Please find your document attached.",
          "recipients": [
            {
              "emailAddress": "recipient@example.com",
              "recipientType": "To"
            },
            {
              "emailAddress": "manager@example.com",
              "recipientType": "CC"
            },
            {
              "emailAddress": "archive@example.com",
              "recipientType": "BCC"
            }
          ],
          "attachmentType": "File"
        }
      }
    }
  ]
}
```

**Recipient types:** `To`, `CC`, `BCC`

**Attachment types:**

| Type | Description |
| --- | --- |
| `None` | No attachment. The email is sent without the document. |
| `File` | The document is attached as a file to the email. |
| `Body` | The document content is embedded in the email body (HTML format). |

### Print Delivery

Send documents to a printer.

```json
{
  "deliveryQueues": [
    {
      "name": "Office Printer",
      "deliverySettings": {
        "print": {
          "printerName": "\\\\printserver\\HP-LaserJet-4050",
          "copies": 2,
          "duplex": true
        }
      }
    }
  ]
}
```

### File System Delivery

Write documents to a file system location.

```json
{
  "deliveryQueues": [
    {
      "name": "Archive File Share",
      "deliverySettings": {
        "fileSystem": {
          "location": "\\\\fileserver\\documents\\archive\\2026",
          "documentFormat": "PDF",
          "fileNameOption": "TemplateNameAndDate",
          "customFileName": ""
        }
      }
    }
  ]
}
```

**File name options:**

| Option | Description |
| --- | --- |
| `TemplateNameAndDate` | File name is generated from the template name and the current date/time. |
| `TemplateName` | File name is the template name only. |
| `Custom` | Use the value in `customFileName`. |

---

## Integration Patterns

### Synchronous Polling

The simplest integration pattern. Submit a job, then poll the status endpoint until the job completes or errors.

```javascript
async function submitAndWaitForJob(apiBaseUrl, apiKey, jobDef) {
  // Submit the job
  const submitResponse = await fetch(`${apiBaseUrl}/api/v2/jobs/jobdef`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "apikey": apiKey
    },
    body: JSON.stringify(jobDef)
  });

  const jobQueueItem = await submitResponse.json();
  const jobId = jobQueueItem.id;
  console.log(`Job submitted: ${jobId}`);

  // Poll for completion
  let status = "InProgress";
  while (status === "InProgress") {
    await new Promise(resolve => setTimeout(resolve, 2000)); // Wait 2 seconds

    const statusResponse = await fetch(
      `${apiBaseUrl}/api/v2/jobs/${jobId}/status`,
      { headers: { "apikey": apiKey } }
    );
    const statusResult = await statusResponse.json();
    status = statusResult.jobStatus;
    console.log(`Job ${jobId} status: ${status}`);
  }

  if (status === "Error") {
    // Retrieve error details
    const errResponse = await fetch(
      `${apiBaseUrl}/api/v2/jobs/${jobId}/errors`,
      { headers: { "apikey": apiKey } }
    );
    const errors = await errResponse.json();
    throw new Error(`Job failed: ${JSON.stringify(errors)}`);
  }

  // Retrieve the completed job with documents
  const jobResponse = await fetch(
    `${apiBaseUrl}/api/v2/jobs/${jobId}?include=All`,
    { headers: { "apikey": apiKey } }
  );
  return await jobResponse.json();
}
```

### Asynchronous with Webhook Callback

For production systems, use the `jobStatusCallback` property in the JobDef to receive a webhook notification when the job completes. This avoids the overhead and latency of polling.

1. Set `jobStatusCallback` in your JobDef to a URL on your server that can receive POST requests.
2. Submit the job via `POST /api/v2/jobs/jobdef`.
3. Store the returned Job ID for correlation.
4. When the job completes (or errors), ActiveDocs sends a POST request to your callback URL with the `JobQueueItem` payload.
5. Your callback handler retrieves the full job results using the Job ID.

```json
{
  "jobStatusCallback": "https://example.com/api/webhooks/activedocs/job-complete",
  "jobItems": [ ... ]
}
```

### Bulk Processing with Multiple JobItems

A single JobDef can contain multiple JobItems, each producing a separate document set. This is efficient for batch operations where many documents share the same template configuration but have different answer data.

```json
{
  "externalRef": "BATCH-2026-04-09",
  "documentFormat": "PDF",
  "evaluateOption": "PerformCalcs",
  "jobItems": [
    {
      "templateSets": [{ "name": "Invoice Template Set" }],
      "answers": {
        "answerGroups": [
          {
            "name": "InvoiceData",
            "answers": [
              { "name": "CustomerName", "value": "Acme Corp", "type": "Text" },
              { "name": "InvoiceTotal", "value": "1250.00", "type": "Currency" }
            ]
          }
        ]
      }
    },
    {
      "templateSets": [{ "name": "Invoice Template Set" }],
      "answers": {
        "answerGroups": [
          {
            "name": "InvoiceData",
            "answers": [
              { "name": "CustomerName", "value": "Globex Inc", "type": "Text" },
              { "name": "InvoiceTotal", "value": "3400.00", "type": "Currency" }
            ]
          }
        ]
      }
    }
  ]
}
```

Each JobItem is processed independently. The job status reflects the aggregate state -- it is `Complete` only when all JobItems have been successfully processed, and `Error` if any JobItem fails.
