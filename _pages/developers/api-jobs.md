---
title: "Automated Document Production"
permalink: /developers/api-jobs/
layout: single
sidebar:
  nav: "developers"
toc: true
toc_sticky: true
---

The Jobs API provides endpoints for creating, monitoring, and managing automated document assembly jobs.

## Search Jobs

Search for document assembly jobs based on various criteria.

```
GET /api/v2/jobs
```

### Query Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `rowlimit` | integer | Limit for the number of items returned. Defaults to the site document row limit configuration. |
| `externalref` | string | Return all jobs created with the same external reference (e.g. `Batch-1234`). |
| `searchdateoption` | string | Date search option: `LastMonth`, `LastWeek`, etc. |
| `searchstatusoption` | string | Job status filter: `InProgress`, `Complete`, `Error`. Best used with a date range. |
| `startdate` | date-time | Start date filter. |
| `enddate` | date-time | End date filter. |

### Response

`200` — Returns an array of `JobQueueItem` objects.

### Example

```
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
| `include` | string | Related models to include. Options: `JobDocuments` (1), `JobDef` (2), `JobErrors` (4), `All` (7). |

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns a `QueuedJob` model with the specified related models. |
| `204` | No Content — Job not found. |

### Example

```
GET /api/v2/jobs/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67?include=All
```

---

## Get Job Status

Check the status of a job. Typically used to poll whether a job has completed or has an error.

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
| `204` | No Content — Job not found. |

> **TIP:** Use the parent endpoint `GET /api/v2/jobs/{id}` with the `include` parameter to get the full model and related data such as individual Document and Delivery statuses.

---

## Get Job Documents

Retrieve the queued job and its associated documents. Typically used to find IDs for Documents, Document Sets, and Deliveries needed for further operations (e.g. downloading the actual document file).

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
| `200` | Returns a `JobQueueDocuments` model (job + associated document list). |
| `204` | No Content — Job not found. |

---

## Get Job Definition

Retrieve the queued job with its associated Job Definition — the specification used to assemble and optionally deliver documents.

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
| `200` | Returns a `JobQueueJobDef` model containing JobItems and ActiveDocsAnswers. |
| `204` | No Content — Job not found. |

---

## Get Job Errors

Retrieve the queued job and its associated error list.

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
| `200` | Returns a `JobQueueErrors` model (job + associated error list). |
| `204` | No Content — Job not found. |

---

## Delete Job

Cancel or permanently delete a job from the queue.

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
| `purge` | boolean | `false` | If `true`, the job and all associated data is permanently deleted. If `false`, the job is cancelled. |

### Responses

| Status | Description |
| --- | --- |
| `200` | OK — Job successfully cancelled or deleted. |
| `204` | No Content — Job not found. |

### Example

```
DELETE /api/v2/jobs/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67?purge=true
```

---

## Add Document Conversion Job

Create a job to convert a document from one format to another. The document file must be supplied along with its current format.

```
POST /api/v2/jobs/conversions?convertDocumentFormat={format}
```

### Query Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `convertDocumentFormat` | string | Target document format for conversion. |

### Request Body

A `DocumentFile` object containing the source document and its current format.

**Content-Type:** `application/json`

### Responses

| Status | Description |
| --- | --- |
| `200` | OK |
| `201` | Returns a `DocumentSummary` object with the current conversion status and any errors. |

---

## Add Job Definition

Submit a new document assembly job. Creates a Job Queue Item and starts the document assembly process.

```
POST /api/v2/jobs/jobdef
```

### Request Body

A `JobDef` model containing the definition/specification required to assemble and optionally deliver one or more documents. Must include:

- At least one `JobItem`
- At least one Template Set with at least one Template specified

**Content-Type:** `application/json`

### Responses

| Status | Description |
| --- | --- |
| `200` | OK |
| `201` | Returns a `JobQueueItem` containing the allocated Job ID and status information. |

### Example Request Body

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
      ]
    }
  ]
}
```

---

## Get Job XML (Legacy)

Retrieve the job and associated Job Definition as XML. **Legacy use only.**

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
