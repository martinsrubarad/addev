The Delivery API provides endpoints for managing document deliveries and delivery queues. Deliveries are the mechanism by which assembled documents are sent to their destination — whether by print, email, file system, FTP, or web service.

## Delivery Status Values

| Status | Description |
| --- | --- |
| `Pending` | The delivery has been queued but not yet processed. |
| `Error` | The delivery failed. Use the errors endpoint to retrieve details. |
| `Delivered` | The delivery was successfully processed and sent to its destination. |
| `Deleted` | The delivery has been soft-deleted and is no longer active. |

## Delivery Channel Types

| Channel | Description |
| --- | --- |
| `Print` | Send to a printer. |
| `Email` | Send as an email with the document as an attachment. |
| `FileSystem` | Write the document to a file system path. |
| `FTP` | Upload the document to an FTP server. |
| `WebServiceXML` | Deliver via web service using XML format. |
| `SharePoint` | Upload to a SharePoint document library. |
| `WebServiceJSON` | Deliver via web service using JSON format. |

## Asynchronous Delivery Pattern

Many delivery channels process asynchronously. When a delivery is created, the service may return a status of `Pending` while the delivery is processed in the background. To track delivery completion:

1. Submit the delivery via `POST /api/v2/deliveries`.
2. The response includes a delivery ID with a `Pending` status.
3. Poll `GET /api/v2/deliveries/{id}` to check the current status, or configure a `confirmationWebhook` in the delivery settings so the system calls back to your endpoint when the delivery completes.
4. When using webhooks, update the delivery status via `PUT /api/v2/deliveries/{id}/status` or `PUT /api/v2/deliveries/status` (batch) to confirm receipt.

## DeliverySettings Structure

The `DeliverySettings` object controls how a document is delivered. Its structure varies by delivery channel.

```json
{
  "confirmationWebhook": "https://example.com/api/delivery-callback",
  "print": {
    "printerName": "\\\\server\\printer",
    "copies": 1,
    "duplex": true
  },
  "email": {
    "sender": "noreply@example.com",
    "message": "Please find your document attached.",
    "subject": "Your Document",
    "recipients": [
      {
        "address": "user@example.com",
        "type": "To"
      },
      {
        "address": "manager@example.com",
        "type": "CC"
      }
    ]
  },
  "location": {
    "path": "\\\\server\\share\\documents",
    "overwrite": true
  }
}
```

| Property | Type | Description |
| --- | --- | --- |
| `confirmationWebhook` | string | URL that receives a callback when the delivery completes or fails. |
| `print` | object | Print-specific settings: printer name, copies, duplex. |
| `email` | object | Email-specific settings: sender address, subject, message body, and recipient list. |
| `email.recipients` | array | Array of recipient objects, each with `address` (string) and `type` (`To`, `CC`, `BCC`). |
| `location` | object | File system or FTP path settings, including whether to overwrite existing files. |

---

## Get Document Delivery

Retrieve a delivery record by ID, with optional related models.

```
GET /api/v2/deliveries/{id}
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Delivery ID (GUID, uppercase, no hyphens). |

### Query Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `include` | string | Related models to include. Accepts a comma-delimited list or a numeric bitmask value. |

### Include Options (eDeliveryIncludeOptions)

| Name | Value | Description |
| --- | --- | --- |
| `None` | 0 | No related models included. |
| `DeliverySettings` | 1 | Include the delivery settings configuration. |
| `Errors` | 2 | Include any delivery error records. |
| `All` | 3 | Include all related models (DeliverySettings + Errors). |

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns a `DocumentDelivery` model with the requested related models. |
| `204` | No Content — Delivery not found. |

### Example

```
GET /api/v2/deliveries/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67?include=All
```

---

## Get Delivery Errors

Retrieve the error records associated with a delivery.

```
GET /api/v2/deliveries/{id}/errors
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Delivery ID (GUID, uppercase, no hyphens). |

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns the delivery record with its associated error list. |
| `204` | No Content — Delivery not found. |

---

## Get Delivery Settings

Retrieve the delivery settings configuration for a specific delivery.

```
GET /api/v2/deliveries/{id}/settings
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Delivery ID (GUID, uppercase, no hyphens). |

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns the delivery record with its associated `DeliverySettings` object. |
| `204` | No Content — Delivery not found. |

---

## Update Delivery Statuses (Batch)

Update the status of multiple deliveries in a single request. This endpoint is typically used as a webhook callback to confirm delivery outcomes.

```
PUT /api/v2/deliveries/status
```

### Request Body

An array of `DocumentDeliveryID` objects, each specifying the delivery to update and its new status.

**Content-Type:** `application/json`

```json
[
  {
    "deliveryID": "4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67",
    "deliveryStatus": "Delivered"
  },
  {
    "deliveryID": "A1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6",
    "deliveryStatus": "Error"
  }
]
```

### Responses

| Status | Description |
| --- | --- |
| `200` | OK — All delivery statuses updated successfully. |

---

## Update Delivery Status

Update the status of a single delivery. This endpoint is typically used as a webhook callback.

```
PUT /api/v2/deliveries/{id}/status
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Delivery ID (GUID, uppercase, no hyphens). |

### Request Body

A `DocumentDeliveryID` object with the new delivery status.

**Content-Type:** `application/json`

```json
{
  "deliveryID": "4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67",
  "deliveryStatus": "Delivered"
}
```

### Responses

| Status | Description |
| --- | --- |
| `200` | OK — Delivery status updated successfully. |
| `204` | No Content — Delivery not found. |

---

## Add Document Delivery

Create a new delivery for a document, optionally overriding the default delivery settings.

```
POST /api/v2/deliveries
```

### Query Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `queuename` | string | Yes | Name of the delivery queue to add the delivery to. |
| `documentid` | string | Yes | Document ID to deliver (GUID, uppercase, no hyphens). |

### Request Body

An optional `DeliverySettings` object to override the queue's default settings. If omitted, the queue's configured settings are used.

**Content-Type:** `application/json`

```json
{
  "confirmationWebhook": "https://example.com/api/delivery-callback",
  "email": {
    "sender": "noreply@example.com",
    "subject": "Your Document",
    "message": "Please find your document attached.",
    "recipients": [
      {
        "address": "user@example.com",
        "type": "To"
      }
    ]
  }
}
```

### Responses

| Status | Description |
| --- | --- |
| `200` | OK |
| `201` | Returns the created `DocumentDelivery` record with its assigned delivery ID and initial status. |

### Example

```
POST /api/v2/deliveries?queuename=EmailQueue&documentid=4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67
```

---

## Delete Document Deliveries

Delete delivery records, optionally filtered by queue name and date. Supports soft delete and hard delete modes.

```
DELETE /api/v2/deliveries
```

### Query Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `queuename` | string | No | Filter deletions to a specific delivery queue. If omitted, applies across all queues. |
| `beforedate` | date-time | No | Delete only deliveries created before this date. |
| `deleteOption` | string | Yes | Deletion mode (see table below). |

### Delete Options

| Option | Description |
| --- | --- |
| `SoftDelete` | Marks the delivery records as deleted without removing data. Records remain in the database and can be queried with a deleted status filter. |
| `HardDeleteAll` | Permanently removes the delivery records and all associated files from the database. |
| `HardDeleteFileOnly` | Permanently removes only the delivered file data while retaining the delivery metadata records. |

### Responses

| Status | Description |
| --- | --- |
| `200` | OK — Deliveries deleted successfully. |

### Example

```
DELETE /api/v2/deliveries?queuename=EmailQueue&beforedate=2026-01-01&deleteOption=SoftDelete
```

---

## Delivery Queue Management

Delivery queues define how and when documents are delivered. Each queue is associated with a delivery channel and can be scheduled to process deliveries at defined intervals.

### Delivery Queue Schedule Types

| Type | Description |
| --- | --- |
| `Immediate` | Deliveries are processed as soon as they are added to the queue. |
| `Scheduled` | Deliveries are batched and processed at a configured time interval. |
| `Manual` | Deliveries remain in the queue until manually triggered. |

---

## Get Delivery Queue Summaries

Retrieve summary information for all delivery queues, including pending and processed counts.

```
GET /api/v2/deliveryqueues
```

### Query Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `fromdate` | date-time | Return delivery counts from this date onward. Useful for scoping summary statistics to a specific period. |

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns an array of delivery queue summary objects. |

### Example

```
GET /api/v2/deliveryqueues?fromdate=2026-01-01
```

---

## Get Delivery Queue Summary

Retrieve summary information for a single delivery queue.

```
GET /api/v2/deliveryqueues/{id}
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Delivery Queue ID (GUID, uppercase, no hyphens). |

### Query Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `fromdate` | date-time | Return delivery counts from this date onward. |

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns a delivery queue summary object. |
| `204` | No Content — Delivery Queue not found. |

### Example

```
GET /api/v2/deliveryqueues/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67?fromdate=2026-01-01
```

---

## Update Delivery Queue

Update the configuration of a delivery queue, including enabling or disabling it and resetting its state.

```
PUT /api/v2/deliveryqueues/{id}
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Delivery Queue ID (GUID, uppercase, no hyphens). |

### Query Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `queuename` | string | New name for the delivery queue. |
| `enableaction` | string | Set to `Enable` to activate the queue or `Disable` to deactivate it. Disabled queues do not process deliveries. |
| `reset` | boolean | If `true`, resets the queue state, clearing any error conditions and restarting processing. |

### Responses

| Status | Description |
| --- | --- |
| `200` | OK — Delivery Queue updated successfully. |
| `204` | No Content — Delivery Queue not found. |

### Example

```
PUT /api/v2/deliveryqueues/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67?enableaction=Enable&reset=true
```
