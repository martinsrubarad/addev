The Diagnostics and Site Management API provides endpoints for monitoring system health, retrieving usage statistics, reviewing event logs, and managing site-level configuration and resources.

## Diagnostics

### Get Health Status

Run a health check command against the ActiveDocs environment. Use this endpoint to verify connectivity, test document creation, validate services, and perform other diagnostic operations.

```
GET /api/v2/diagnostics
```

#### Query Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `command` | string | Yes | The health check command to execute (see table below). |
| `returnErrorResponse` | boolean | No | If `true`, returns detailed error information in the response body when the check fails. Defaults to `false`. |
| `TemplateNameOrID` | string | No | Template name or ID used by test document creation commands (`TestDocCreateDOCX`, `TestDocCreateDOC`, `TestDocCreatePDF`). |
| `Subsite` | string | No | Subsite name or ID to scope the diagnostic check to a specific subsite. |
| `EnvName` | string | No | Environment name for environment-scoped checks. |
| `EnvDbName` | string | No | Environment database name for database-scoped checks. |

#### Health Check Commands (eHealthCheckCommand)

| Command | Description |
| --- | --- |
| `Ping` | Basic connectivity check. Verifies the API is reachable and responsive. |
| `RestartServices` | Restart the ActiveDocs background services. |
| `CheckDB` | Verify database connectivity and integrity. |
| `CheckServices` | Verify that all required ActiveDocs services are running. |
| `TestDocCreateDOCX` | Create a test document in DOCX format using the specified template. Requires `TemplateNameOrID`. |
| `TestDocCreateDOC` | Create a test document in DOC format using the specified template. Requires `TemplateNameOrID`. |
| `TestDocCreatePDF` | Create a test document in PDF format using the specified template. Requires `TemplateNameOrID`. |
| `RefreshWindowsUsers` | Refresh the cached list of Windows domain users. |
| `ValidateLDAP` | Validate the LDAP/Active Directory connection configuration. |
| `CheckActiveDocsLicense` | Verify the current ActiveDocs license status and validity. |
| `TestError` | Trigger a test error for verifying error handling and logging. |

#### Responses

| Status | Description |
| --- | --- |
| `200` | Returns the health check result with status and any diagnostic details. |

#### Examples

```
GET /api/v2/diagnostics?command=Ping
```

```
GET /api/v2/diagnostics?command=TestDocCreatePDF&TemplateNameOrID=InvoiceTemplate&Subsite=Production
```

```
GET /api/v2/diagnostics?command=CheckDB&returnErrorResponse=true
```

---

### Get ADP Statistics

Retrieve document production usage statistics for the ActiveDocs environment. This endpoint reports on total production counts relative to the licensed limits.

```
GET /api/v2/diagnostics/adp-stats
```

#### Query Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `externalref` | string | Optional external reference to filter statistics by a specific integration or batch context. |

#### Response Model (DocumentUsageStats)

| Field | Type | Description |
| --- | --- | --- |
| `totalProduction` | integer | Total number of documents produced in the current license period. |
| `licenseLimit` | integer | Maximum number of documents allowed under the current license. |
| `licensePeriod` | string | License period type (see table below). |
| `anniversaryDate` | date-time | Date when the current license period resets. |

#### License Period Types

| Period | Description |
| --- | --- |
| `Monthly` | License resets on a monthly cycle. |
| `Quarterly` | License resets every three months. |
| `Annually` | License resets once per year. |
| `Perpetual` | No reset — the license limit is a lifetime cap. |

#### License Threshold Alerts

The system generates alerts when document production approaches the license limit:

| Threshold | Alert Level | Description |
| --- | --- | --- |
| 80% | Warning | Production has reached 80% of the licensed limit. Plan for increased capacity. |
| 90% | Critical | Production has reached 90% of the licensed limit. Action recommended. |
| 95% | Urgent | Production has reached 95% of the licensed limit. Document creation may be restricted. |

#### Responses

| Status | Description |
| --- | --- |
| `200` | Returns a `DocumentUsageStats` object. |

#### Example

```
GET /api/v2/diagnostics/adp-stats
```

---

### Get Event Log

Retrieve event log entries for the ActiveDocs environment, filtered by date range and entry type.

```
GET /api/v2/diagnostics/eventlog
```

#### Query Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `startDate` | date-time | Return log entries from this date onward. |
| `endDate` | date-time | Return log entries up to and including this date. |
| `entryType` | string | Filter by entry type: `All`, `Errors`, `Information`. Defaults to `All`. |

#### Responses

| Status | Description |
| --- | --- |
| `200` | Returns an array of event log entry objects. |

#### Example

```
GET /api/v2/diagnostics/eventlog?startDate=2026-04-01&endDate=2026-04-09&entryType=Errors
```

---

### Get Diagnostics Report

Generate and download a comprehensive diagnostics report in Excel format. The report includes system configuration, service statuses, license details, and recent event log entries.

```
GET /api/v2/diagnostics/report
```

#### Responses

| Status | Description |
| --- | --- |
| `200` | Returns the diagnostics report as a byte array (`application/octet-stream`). The response contains an Excel file. |

#### Example

```
GET /api/v2/diagnostics/report
```

> **TIP:** Save the response body directly to a `.xlsx` file for review.

---

## Site Management

Site properties and resources define the global configuration for the ActiveDocs installation, including branding images, system-wide settings, and default values.

---

### Get Site Properties

Retrieve all site-level configuration properties.

```
GET /api/v2/site/properties
```

#### Responses

| Status | Description |
| --- | --- |
| `200` | Returns an array of site property objects, each containing a property name and its current value. |

#### Example

```
GET /api/v2/site/properties
```

---

### Update Site Properties

Update one or more site-level configuration properties. Each property must include its current value (`OldValue`) to prevent concurrent modification conflicts.

```
PUT /api/v2/site/properties
```

#### Request Body

An array of `SiteField` objects.

**Content-Type:** `application/json`

```json
[
  {
    "Name": "SiteTitle",
    "Value": "ActiveDocs Production",
    "OldValue": "ActiveDocs"
  },
  {
    "Name": "MaxDocumentRows",
    "Value": "500",
    "OldValue": "200"
  }
]
```

#### SiteField Model

| Field | Type | Description |
| --- | --- | --- |
| `Name` | string | Property name. |
| `Value` | string | New value for the property. |
| `OldValue` | string | Current value of the property. Used for optimistic concurrency — the update fails if the current value no longer matches. |

#### Responses

| Status | Description |
| --- | --- |
| `200` | OK — Site properties updated successfully. |

---

### Get Site Property by Name

Retrieve a single site property by its name.

```
GET /api/v2/site/properties/{propertyname}
```

#### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `propertyname` | string | Yes | The name of the site property to retrieve. |

#### Responses

| Status | Description |
| --- | --- |
| `200` | Returns the site property object with its name and current value. |
| `204` | No Content — Property not found. |

#### Example

```
GET /api/v2/site/properties/SiteTitle
```

---

### Get Site Resources

Retrieve site-level resources such as branding images and logos used across the ActiveDocs interface.

```
GET /api/v2/site/resources
```

#### Responses

| Status | Description |
| --- | --- |
| `200` | Returns an array of site resource objects containing resource names and their data. |

#### Example

```
GET /api/v2/site/resources
```

---

### Upload Site Resources

Upload or update site-level resources such as images and logos. Existing resources with the same name are replaced.

```
PUT /api/v2/site/resources
```

#### Request Body

An array of `SiteResource` objects.

**Content-Type:** `application/json`

```json
[
  {
    "Name": "CompanyLogo",
    "Data": "iVBORw0KGgoAAAANSUhEUgAA..."
  },
  {
    "Name": "EmailBanner",
    "Data": "R0lGODlhAQABAIAAAP///..."
  }
]
```

#### SiteResource Model

| Field | Type | Description |
| --- | --- | --- |
| `Name` | string | Resource name (used as the identifier). |
| `Data` | string | Base64-encoded file content of the resource. |

#### Responses

| Status | Description |
| --- | --- |
| `200` | OK — Site resources uploaded successfully. |
