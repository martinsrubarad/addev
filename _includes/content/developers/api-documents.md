The Documents API provides endpoints for searching, retrieving, updating, and managing assembled documents. Documents are the output of the Jobs API -- each completed job produces one or more documents that can be accessed, delivered, approved, and managed through these endpoints.

## Search Documents

Search for documents based on various criteria including status, date range, ownership, and keyword.

```
POST /api/v2/documents/search
```

### Query Parameters

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `behalfofuser` | string | `""` | If supplied, results are filtered by this user's access rights. |
| `summary` | boolean | `true` | If `true`, returns documents with a minimal set of attributes. |

### Request Body

A `DocumentSearchCriteria` object.

**Content-Type:** `application/json`

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `documentStatus` | string | | Filter by document status. See [Document Status Values](#document-status-values). |
| `timeZone` | string | | Time zone identifier for date filtering (e.g. `UTC`, `America/New_York`). |
| `searchTerm` | string | | Keyword to search for in document names, template names, and external references. |
| `subsite` | string | | Filter by subsite name. |
| `searchDateOption` | string | | Date filter preset. See values below. |
| `documentListOption` | string | | Ownership/scope filter. See values below. |
| `startDate` | date-time | | Start of a custom date range. Requires `searchDateOption` = `DateRange`. |
| `endDate` | date-time | | End of a custom date range. Requires `searchDateOption` = `DateRange`. |
| `documentSearchTermOption` | string | | How to match the search term. See values below. |
| `limitRows` | integer | `200` | Maximum number of results to return. |
| `sortProperty` | string | | Property to sort results by. See supported values below. |
| `sortAscending` | boolean | `true` | Sort direction. `true` for ascending, `false` for descending. |

**searchDateOption values:**

| Value | Description |
| --- | --- |
| `AllDates` | No date filtering. |
| `Today` | Documents created today. |
| `Yesterday` | Documents created yesterday. |
| `ThisWeek` | Documents created this week. |
| `LastWeek` | Documents created last week. |
| `ThisMonth` | Documents created this month. |
| `LastMonth` | Documents created last month. |
| `DateRange` | Custom range using `startDate` and `endDate`. |

**documentListOption values:**

| Value | Description |
| --- | --- |
| `AllDocuments` | Return all documents the user has access to. |
| `MyDocuments` | Return only documents owned by the current user. |
| `MySubsiteDocuments` | Return documents in the current user's subsite. |

**documentSearchTermOption values:**

| Value | Description |
| --- | --- |
| `Exact` | The search term must match exactly. |
| `StartsWith` | Match documents where the name starts with the search term. |
| `Contains` | Match documents where the name contains the search term. |
| `ExactTemplateName` | Match documents produced by a template with this exact name. |
| `ExactTemplateSetName` | Match documents produced by a template set with this exact name. |

**sortProperty supported values:**

| Value | Description |
| --- | --- |
| `DocumentName` | Sort by document name. |
| `TemplateName` | Sort by the template used to produce the document. |
| `CreatedDate` | Sort by creation date. |
| `ModifiedDate` | Sort by last modified date. |
| `Status` | Sort by document status. |
| `Owner` | Sort by document owner. |

### Response

`200` -- Returns an array of document objects matching the search criteria.

### Example

```http
POST /api/v2/documents/search?summary=true
Content-Type: application/json
```

```json
{
  "documentStatus": "Complete",
  "searchDateOption": "ThisMonth",
  "documentListOption": "MyDocuments",
  "searchTerm": "Invoice",
  "documentSearchTermOption": "Contains",
  "limitRows": 50,
  "sortProperty": "CreatedDate",
  "sortAscending": false
}
```

---

## Get Document

Retrieve a specific document by ID, with optional related child models.

```
GET /api/v2/documents/{id}
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Document ID (GUID, uppercase, no hyphens). |

### Query Parameters

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `include` | integer or string | | Related child models to include. Accepts a bitwise combination of flags or the option name. |
| `onbehalfuser` | string | | Execute the request with this user's access rights. |
| `summary` | boolean | `false` | If `true`, returns a document with a minimal set of attributes. |

**eDocumentIncludeOptions flags:**

| Flag | Value | Description |
| --- | --- | --- |
| `None` | 0 | No related models included. |
| `Answers` | 1 | Include the answer data used to produce the document. |
| `Properties` | 2 | Include custom properties (tags) assigned to the document. |
| `Approvals` | 4 | Include approval records. |
| `WorkFlow` | 8 | Include workflow state. |
| `Deliveries` | 16 | Include delivery records showing where and how the document was delivered. |
| `DocumentFile` | 32 | Include the document file bytes (Base64-encoded). |
| `JobDef` | 64 | Include the job definition used to create the document. |
| `Errors` | 128 | Include any errors recorded against the document. |
| `All` | 255 | Include all related models. |

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns a document model with the specified related child models. |
| `204` | No Content -- Document not found. |

### Examples

Retrieve a document with answers and deliveries:

```http
GET /api/v2/documents/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67?include=17
```

Retrieve a document with all related data:

```http
GET /api/v2/documents/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67?include=All
```

---

## Delete Document

Delete a document. Supports soft delete (mark as deleted but retain data) and hard delete (permanent removal).

```
DELETE /api/v2/documents/{id}
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Document ID. |

### Query Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `deleteOption` | string | Deletion mode. See values below. |

**deleteOption values:**

| Value | Description |
| --- | --- |
| `SoftDelete` | Mark the document as deleted. The document data is retained and can be restored. |
| `HardDeleteAll` | Permanently delete the document and all associated data (file, answers, deliveries, etc.). |
| `HardDeleteFileOnly` | Permanently delete only the document file. Metadata, answers, and other associated data are retained. |

### Responses

| Status | Description |
| --- | --- |
| `200` | OK -- Document successfully deleted. |
| `204` | No Content -- Document not found. |

---

## Get Answers

Retrieve the answer data that was used to produce the document.

```
GET /api/v2/documents/{id}/answers
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Document ID. |

### Response

`200` -- Returns the `ActiveDocsAnswers` model containing answer groups and individual answer values.

---

## Get Document File

Download the assembled document file.

```
GET /api/v2/documents/{id}/file
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Document ID. |

### Response

`200` -- Returns the document file as `application/octet-stream`.

---

## Update Document File

Replace the document file with a new version.

```
PUT /api/v2/documents/{id}/file
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Document ID. |

### Query Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `isDraft` | boolean | If `true`, the uploaded file is saved as a draft version. If `false`, it replaces the current document file. |

### Request Body

A `DocumentFile` object containing the new file data.

**Content-Type:** `application/json`

### Response

`200` -- Document file updated successfully.

---

## Get Properties

Retrieve the custom properties (tags) assigned to a document.

```
GET /api/v2/documents/{id}/properties
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Document ID. |

### Response

`200` -- Returns an array of property key-value pairs.

---

## Update Properties

Update the custom properties (tags) on a document.

```
PUT /api/v2/documents/{id}/properties
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Document ID. |

### Request Body

An array of property key-value pairs.

**Content-Type:** `application/json`

### Response

`200` -- Properties updated successfully.

---

## Get Job Definition

Retrieve the job definition that was used to create the document.

```
GET /api/v2/documents/{id}/jobdef
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Document ID. |

### Response

`200` -- Returns the `JobDef` model that was used to produce this document.

---

## Get Deliveries

Retrieve the delivery records for a document, showing where and how the document was delivered.

```
GET /api/v2/documents/{id}/deliveries
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Document ID. |

### Response

`200` -- Returns an array of delivery records with channel type, status, destination, and timestamps.

---

## Get Approvals

Retrieve the approval history for a document.

```
GET /api/v2/documents/{id}/approvals
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Document ID. |

### Response

`200` -- Returns an array of approval records including approver, date, action, and comments.

---

## Get Workflow

Retrieve the current workflow state for a document.

```
GET /api/v2/documents/{id}/workflow
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Document ID. |

### Response

`200` -- Returns the workflow state including current step, assigned users, and available actions.

---

## Update Workflow

Perform a workflow action on a document, such as sending for approval, recalling, finalizing, approving, or declining.

```
PUT /api/v2/documents/{id}/workflow
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Document ID. |

### Query Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `action` | string | Yes | The workflow action to perform. See [Workflow Actions](#workflow-actions). |
| `user` | string | No | The user performing the action (login name or user ID). |
| `comment` | string | No | A comment to record with the workflow action. |

### Response

`200` -- Workflow action completed successfully.

---

## Get Errors

Retrieve any errors recorded against a document.

```
GET /api/v2/documents/{id}/errors
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Document ID. |

### Response

`200` -- Returns an array of error records with error messages, timestamps, and severity.

---

## Update Answer File

Replace the answer data associated with a document.

```
PUT /api/v2/documents/{id}/answerfile
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Document ID. |

### Request Body

An `ActiveDocsAnswers` object containing the replacement answer data.

**Content-Type:** `application/json`

### Response

`200` -- Answer data updated successfully.

---

## Add Answer File

Create a new answer file record without an associated document. This can be used to pre-stage answer data for later use in document production.

```
POST /api/v2/documents/answerfile
```

### Request Body

An `ActiveDocsAnswers` object containing the answer data to store.

**Content-Type:** `application/json`

### Responses

| Status | Description |
| --- | --- |
| `201` | Created. Returns the allocated Document ID for the new answer file record. |

---

## Document Status Values

| Status | Description |
| --- | --- |
| `AnyStatus` | Used in search criteria only. Matches documents with any status. |
| `Assembling` | The document is currently being assembled by the document production engine. |
| `Complete` | The document has been successfully assembled and is ready for use. |
| `Error` | An error occurred during assembly or delivery. Use the errors endpoint for details. |
| `Paused` | The document assembly has been paused (e.g. awaiting user input or external data). |
| `ConvertingFormat` | The document is being converted from one format to another (e.g. DOCX to PDF). |
| `ApprovalPending` | The document has been submitted for approval and is awaiting review. |
| `ApprovalDeclined` | The document's approval request was declined by a reviewer. |
| `FinalApproved` | The document has received final approval and is locked from further editing. |
| `Draft` | The document is in draft state and has not been finalized. |
| `Deleted` | The document has been soft-deleted. |
| `Delivered` | The document has been successfully delivered to all configured delivery channels. |
| `DeliveryError` | One or more deliveries failed. The document itself was assembled successfully. |

---

## Document Include Options

The `include` parameter on `GET /api/v2/documents/{id}` accepts a bitwise combination of the following flags. Combine values by adding them together (e.g. `Answers` + `Deliveries` = `1 + 16 = 17`).

| Flag | Value | Description |
| --- | --- | --- |
| `None` | 0 | No related models included. |
| `Answers` | 1 | Answer data used to produce the document. |
| `Properties` | 2 | Custom properties (tags). |
| `Approvals` | 4 | Approval records. |
| `WorkFlow` | 8 | Workflow state. |
| `Deliveries` | 16 | Delivery records. |
| `DocumentFile` | 32 | The document file bytes (Base64-encoded). |
| `JobDef` | 64 | The job definition used to create the document. |
| `Errors` | 128 | Error records. |
| `All` | 255 | All related models. |

### Combining Include Flags

To include multiple related models in a single request, add the flag values together:

```http
GET /api/v2/documents/{id}?include=5
```

This example includes `Answers` (1) + `Approvals` (4) = 5.

You can also use the `All` option to include everything:

```http
GET /api/v2/documents/{id}?include=All
```

---

## Workflow Actions

The following actions can be performed via `PUT /api/v2/documents/{id}/workflow`.

| Action | Description |
| --- | --- |
| `ApprovalSend` | Submit the document for approval. Moves the document into the approval workflow and notifies the designated approvers. |
| `ApprovalRecall` | Recall a document that has been submitted for approval. Returns the document to its previous state before submission. |
| `Finalize` | Finalize the document. Locks the document from further editing and marks it as complete. |
| `Approve` | Approve the document. Records the approval and advances the workflow to the next step (or marks as final approved if this is the last step). |
| `Decline` | Decline the document. Records the rejection with an optional comment and returns the document to the submitter for revision. |

### Example

```http
PUT /api/v2/documents/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67/workflow?action=Approve&user=jsmith&comment=Reviewed+and+approved
```
