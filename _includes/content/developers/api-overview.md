## Architecture Overview

ActiveDocs Solutions Studio is built on **ASP.NET** running on the **.NET Framework V4** platform. The system comprises several components:

- **WorkCenter** — The web application providing the user interface for document management, approvals, and workflow operations.
- **REST API** — A comprehensive HTTP API (V2) for programmatic access to all document production and design component management capabilities.
- **Solutions Studio Toolkit** — Design-time tools integrated with Microsoft Word for creating and managing templates, snippets, and other design components.
- **Document Assembly Engine** — A high-throughput engine capable of producing **1,000,000+ pages per month**, supporting **multi-threaded** and **multi-server** deployments for horizontal scalability.

The REST API enables integration with external systems such as CRM platforms, ERP systems, web portals, and business process automation tools to drive automated document production at scale.

## Base URL

All V2 API endpoints are relative to your ActiveDocs server installation:

```
https://{your-server}/activedocs/api/v2/
```

Replace `{your-server}` with the hostname of your ActiveDocs server. All examples in this documentation use paths relative to this base URL.

## Authentication

### API Key Authentication

Every API request must include an API key in the `apikey` HTTP header:

```http
GET /activedocs/api/v2/jobs HTTP/1.1
Host: your-server
apikey: your-api-key-here
```

API keys are configured and managed in **AdminCenter**. Each key can be scoped to specific permissions and subsites.

### User Authentication (Optional)

For scenarios requiring user-level identity (e.g., enforcing per-user access rights or recording audit trails), the API supports JWT-based user authentication.

**Authenticate a user:**

```http
POST /activedocs/api/v2/users/authenticate HTTP/1.1
Host: your-server
apikey: your-api-key-here
Content-Type: application/json
```

```json
{
  "login": "jsmith",
  "password": "userpassword"
}
```

**Response:**

```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "expiration": "2026-04-09T15:30:00Z",
  "refreshToken": "a1b2c3d4e5f6..."
}
```

The returned JWT token is valid for **60 minutes** and can be used in place of the API key in subsequent requests:

```http
GET /activedocs/api/v2/documents/search HTTP/1.1
Host: your-server
apikey: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

To refresh an expiring token without re-authenticating, include the `refreshToken` parameter:

```http
POST /activedocs/api/v2/users/authenticate HTTP/1.1
Host: your-server
Content-Type: application/json
```

```json
{
  "refreshToken": "a1b2c3d4e5f6..."
}
```

## Key Conventions

### ID Format

All `id` parameters are GUIDs formatted in **uppercase with no hyphens** (32 characters), unless otherwise specified.

```
Example: 4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67
```

### Date Formats

Query string dates accept the following formats. The time portion is optional.

| Format | Example |
| --- | --- |
| `yyyy-mm-dd hh:mm:ss` (24-hour) | `2026-04-09 14:30:00` |
| `yyyy-mm-ddThh:mm:ssZ` (ISO 8601) | `2026-04-09T14:30:00Z` |
| `yyyy-mm-dd` (date only) | `2026-04-09` |

### Include Parameter

Many endpoints support an optional `include` query parameter to fetch related data in a single request. The value is an integer representing a bitwise combination of flags, or the name of the option:

```http
GET /api/v2/documents/{id}?include=all
GET /api/v2/jobs/{id}?include=7
```

Each endpoint defines its own set of include options. Refer to the specific endpoint documentation for available values.

### Content Types

The API accepts and returns JSON by default. XML is also supported on most endpoints.

| Content-Type | Usage |
| --- | --- |
| `application/json` | Default for request and response bodies |
| `application/xml` | Supported alternative for request and response bodies |
| `application/octet-stream` | Used for file download endpoints |

## Document Formats

The following document format identifiers are used across the API when specifying output formats, conversion targets, or filtering by format.

| Format ID | Description |
| --- | --- |
| `WordML` | Microsoft Word XML (WordML) |
| `Word97` | Microsoft Word 97-2003 (.doc) |
| `RTF` | Rich Text Format |
| `PDF` | Portable Document Format |
| `Tiff` | Tagged Image File Format |
| `DocX` | Microsoft Word Open XML (.docx) |
| `DocM` | Microsoft Word Macro-Enabled (.docm) |
| `XPS` | XML Paper Specification |
| `ODT` | OpenDocument Text |
| `PDFA_2a` | PDF/A-2a (archival, accessible) |
| `PDFA_2b` | PDF/A-2b (archival, basic) |

## Error Handling

The API uses standard HTTP status codes to indicate the outcome of each request.

| Status Code | Meaning | Description |
| --- | --- | --- |
| `200` | OK | The request was successful. The response body contains the requested data. |
| `201` | Created | A new resource was successfully created. The response body contains the created resource. |
| `204` | No Content | The request was successful but there is no data to return (e.g., resource not found). |
| `400` | Bad Request | The request was malformed or contained invalid parameters. The response body contains error details. |
| `401` | Unauthorized | The API key is missing, invalid, or expired. |
| `404` | Not Found | The requested endpoint does not exist. |
| `500` | Internal Server Error | An unexpected error occurred on the server. Contact your administrator. |

Error responses include a message describing the problem:

```json
{
  "message": "Invalid Job ID format. Expected a 32-character uppercase GUID with no hyphens.",
  "errorCode": 400
}
```

## Security Headers

The following optional HTTP headers provide additional security context and impersonation capabilities for API requests.

| Header | Type | Description |
| --- | --- | --- |
| `adeQueryUserID` | string | The GUID of the user to associate with the request for audit and access control purposes. |
| `adeQueryUserLogin` | string | The login name of the user to associate with the request. |
| `adeQuerySubsiteID` | string | The GUID of the subsite context for the request. Limits results to the specified subsite. |
| `behalfofuser` | string | Execute the request on behalf of the specified user. The user's access rights and permissions are applied to the operation. |

These headers are typically used when a system-level API key is used but operations need to be scoped to a specific user or subsite context.

## Quick Reference: Endpoint Groups

The V2 API is organized into the following endpoint groups.

| Endpoint Group | Base Path | Description |
| --- | --- | --- |
| **Jobs** | `/api/v2/jobs` | Create, monitor, and manage automated document assembly jobs. Submit JobDef specifications, poll for status, retrieve results, and manage the job queue. |
| **Documents** | `/api/v2/documents` | Search, retrieve, update, and manage assembled documents. Access document files, answers, properties, deliveries, approvals, and workflow state. |
| **Document Sets** | `/api/v2/document-sets` | Manage groups of related documents produced from a single job. |
| **Design Components** | `/api/v2/design-components` | Search, retrieve, import, and export design components including templates, template sets, snippets, data views, and workflows. |
| **Deliveries** | `/api/v2/deliveries` | Manage document delivery records for email, print, and file system outputs. |
| **Delivery Queues** | `/api/v2/delivery-queues` | Configure and manage delivery queue definitions for email, print, and file system delivery channels. |
| **Subsites** | `/api/v2/subsites` | Manage subsites for multi-tenant or departmental isolation of design components and documents. |
| **Users** | `/api/v2/users` | Authenticate users, manage user accounts, and retrieve user information. |
| **Diagnostics** | `/api/v2/diagnostics` | Health checks, version information, and system status endpoints. |
| **Site Management** | `/api/v2/site-management` | Administrative operations for site configuration and maintenance. |
