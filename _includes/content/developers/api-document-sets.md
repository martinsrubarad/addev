The Document Sets API provides endpoints for retrieving document sets and their associated documents, attachments, and deliveries. A Document Set groups one or more documents produced by a single job item.

## DocumentSet Model

| Field | Type | Description |
| --- | --- | --- |
| `id` | string | Document Set ID (GUID, uppercase, no hyphens). |
| `name` | string | Display name of the Document Set. |
| `documentCount` | integer | Number of documents contained in the set. |
| `dateCreated` | date-time | Date and time the Document Set was created. |
| `isFinalizeReady` | boolean | Indicates whether all documents in the set have been assembled and the set is ready for finalization. |
| `documentStatus` | string | Aggregate status of documents within the set. |

## Attachment Model

| Field | Type | Description |
| --- | --- | --- |
| `id` | string | Attachment ID (GUID, uppercase, no hyphens). |
| `name` | string | Display name of the attachment. |
| `attachmentName` | string | Original file name of the attachment. |
| `format` | string | File format of the attachment (e.g. `PDF`, `DOCX`). |
| `dateCreated` | date-time | Date and time the attachment was created. |
| `status` | string | Current status of the attachment. |
| `attachmentFile` | string | Base64-encoded file content. Populated only when the attachment file is explicitly requested. |

---

## Get DocumentSet

Retrieve a Document Set by ID, with optional related models.

```
GET /api/v2/document-sets/{id}
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Document Set ID (GUID, uppercase, no hyphens). |

### Query Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `include` | string | Related models to include. Accepts a comma-delimited list or a numeric bitmask value. |

### Include Options (eDocumentSetIncludeOptions)

| Name | Value | Description |
| --- | --- | --- |
| `None` | 0 | No related models included. |
| `Documents` | 1 | Include the documents belonging to the set. |
| `Attachments` | 2 | Include attachments associated with the set. |
| `Deliveries` | 4 | Include delivery records for the set. |
| `All` | 7 | Include all related models (Documents + Attachments + Deliveries). |

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns a `DocumentSet` model with the requested related models. |
| `204` | No Content — Document Set not found. |

### Example

```
GET /api/v2/document-sets/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67?include=All
```

---

## Get DocumentSet Documents

Retrieve the documents belonging to a Document Set.

```
GET /api/v2/document-sets/{id}/documents
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Document Set ID (GUID, uppercase, no hyphens). |

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns an array of documents associated with the Document Set. |
| `204` | No Content — Document Set not found. |

### Example

```
GET /api/v2/document-sets/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67/documents
```

---

## Get DocumentSet Attachments

Retrieve the attachments associated with a Document Set.

```
GET /api/v2/document-sets/{id}/attachments
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Document Set ID (GUID, uppercase, no hyphens). |

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns an array of `Attachment` objects associated with the Document Set. |
| `204` | No Content — Document Set not found. |

### Example

```
GET /api/v2/document-sets/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67/attachments
```

---

## Get DocumentSet Attachment File

Download the file content of a specific attachment within a Document Set.

```
GET /api/v2/document-sets/{id}/attachments/{attachmentid}/file
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Document Set ID (GUID, uppercase, no hyphens). |
| `attachmentid` | string | Yes | Attachment ID (GUID, uppercase, no hyphens). |

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns the attachment file content. |
| `204` | No Content — Document Set or Attachment not found. |

### Example

```
GET /api/v2/document-sets/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67/attachments/A1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6/file
```

---

## Get DocumentSet Deliveries

Retrieve the delivery records associated with a Document Set.

```
GET /api/v2/document-sets/{id}/deliveries
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Document Set ID (GUID, uppercase, no hyphens). |

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns an array of delivery records associated with the Document Set. |
| `204` | No Content — Document Set not found. |

### Example

```
GET /api/v2/document-sets/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67/deliveries
```

---

## Get Snippet Attachment

Retrieve a Snippet attachment by its attachment ID. Snippet attachments are files associated with Snippet design components rather than with a specific Document Set.

```
GET /api/v2/document-sets/snippet-attachments/{attachmentid}
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `attachmentid` | string | Yes | Snippet Attachment ID (GUID, uppercase, no hyphens). |

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns the Snippet `Attachment` object including file content. |
| `204` | No Content — Snippet Attachment not found. |

### Example

```
GET /api/v2/document-sets/snippet-attachments/A1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6
```
