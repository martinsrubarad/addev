The Design Components API provides endpoints for searching, retrieving, importing, and exporting design components. Design components are the building blocks of document production -- templates, template sets, snippets, data views, workflows, and design item sets.

## Search Design Components

Search for design components based on various criteria including status, type, date range, and keyword.

```
POST /api/v2/design-components/search
```

### Query Parameters

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `behalfOfUser` | string | `""` | If supplied, results are filtered by this user's access rights. |
| `summary` | boolean | `true` | If `true`, returns components with a minimal set of attributes (Name, Description, Status, etc.). |

### Request Body

A `ComponentSearchCriteria` object.

**Content-Type:** `application/json`

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `searchComponentStatus` | string | | Filter by component status. See [Component Status Values](#component-status-values). |
| `searchTerm` | string | | Keyword to search for in component names and descriptions. |
| `searchTermCategory` | string | | Filter by category/tag name. |
| `searchDateOption` | string | | Date filter preset: `AllDates`, `Today`, `Yesterday`, `ThisWeek`, `LastWeek`, `ThisMonth`, `LastMonth`, `DateRange`. |
| `startDate` | date-time | | Start of a custom date range. Requires `searchDateOption` = `DateRange`. |
| `endDate` | date-time | | End of a custom date range. Requires `searchDateOption` = `DateRange`. |
| `searchTermOption` | string | | How to match the search term: `Exact`, `StartsWith`, `Contains`. |
| `limitRows` | integer | `200` | Maximum number of results to return. |
| `searchComponentType` | string | | Filter by component type. See [Search Component Types](#search-component-types). |
| `searchDesignItemType` | string | | Filter by design item type within a design item set. |
| `myComponentsOnly` | boolean | `false` | If `true`, only return components owned by or checked out to the current user. |

### Response

`200` -- Returns an array of `DesignComponentItem` objects matching the search criteria.

### Example

```http
POST /api/v2/design-components/search?summary=true
Content-Type: application/json
```

```json
{
  "searchComponentType": "Template",
  "searchComponentStatus": "Approved",
  "searchTerm": "Invoice",
  "searchTermOption": "Contains",
  "limitRows": 50
}
```

---

## Get Design Component

Retrieve a specific design component by ID, with optional related child models.

```
GET /api/v2/design-components/{id}
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Design component ID (GUID, uppercase, no hyphens). |

### Query Parameters

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `version` | integer | `0` | Version to retrieve. `0` returns the latest published version. |
| `include` | integer or string | | Related child models to include. Accepts a bitwise combination of flags or the option name. |
| `summary` | boolean | `false` | If `true`, returns a component with a minimal set of attributes. |

**eDesignComponentIncludeOptions flags:**

| Flag | Value | Description |
| --- | --- | --- |
| `None` | 0 | No related models included. |
| `Versions` | 1 | Include version history. |
| `Dependencies` | 2 | Include dependency information (snippets, data views, etc. used by this component). |
| `Approvals` | 4 | Include approval records. |
| `WorkFlow` | 8 | Include workflow state. |
| `Categories` | 16 | Include category/tag assignments. |
| `ComponentFile` | 32 | Include the component file bytes (e.g. the .dotm template file). |
| `ComponentFilePreview` | 64 | Include a preview image of the component. |
| `QuestionStructure` | 128 | Include the question/field structure defined in the component. |
| `Properties` | 256 | Include custom properties (tags). |
| `All` | 511 | Include all related models. |

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns a `DesignComponent` model with the specified related child models. |
| `204` | No Content -- Design component not found. |

### Examples

Retrieve a template with all related data:

```http
GET /api/v2/design-components/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67?include=All
```

Retrieve version 3 as a summary:

```http
GET /api/v2/design-components/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67?version=3&summary=true
```

---

## Get Question Structure

Retrieve the question and field structure defined in a design component. This describes the fields, rules, calculations, and question groups that the template expects.

```
GET /api/v2/design-components/{id}/questionstructure
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Design component ID. |

### Query Parameters

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `version` | integer | `0` | Version to retrieve. `0` returns the latest. |
| `scriptRuleMode` | string | | Controls which rule types are returned: `ModelOnly` (data model rules only), `JavaScriptOnly` (client-side JavaScript rules only), `Both` (all rules). |
| `preserveIDs` | boolean | `false` | If `true`, preserves the internal IDs of fields and rules. Useful when mapping answer data programmatically. |

### Response

`200` -- Returns a `QuestionStructure` model containing:

| Property | Description |
| --- | --- |
| `activeFieldDefinitions` | Array of field definitions with names, types, default values, and validation rules. |
| `ruleDefinitions` | Array of business rules that control field visibility and behaviour. |
| `calcDefinitions` | Array of calculation definitions for computed fields. |
| `questionGroups` | Hierarchical grouping of questions as they appear in the wizard UI. |

---

## Get Component File

Download the component file bytes. For templates, this returns the `.dotm` (Word macro-enabled template) file.

```
GET /api/v2/design-components/{id}/file
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Design component ID. |

### Response

`200` -- Returns the file as `application/octet-stream`.

---

## Get Component File Preview

Download a preview image of the design component.

```
GET /api/v2/design-components/{id}/filepreview
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Design component ID. |

### Response

`200` -- Returns a `.png` preview image.

---

## Get Workflow

Retrieve the workflow state for a design component.

```
GET /api/v2/design-components/{id}/workflow
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Design component ID. |

### Response

`200` -- Returns the workflow state including current step, assigned users, and history.

---

## Get Approvals

Retrieve the approval history for a design component.

```
GET /api/v2/design-components/{id}/approvals
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Design component ID. |

### Response

`200` -- Returns an array of approval records including approver, date, status, and comments.

---

## Get Versions

Retrieve the version history for a design component, including publish status for each version.

```
GET /api/v2/design-components/{id}/versions
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Design component ID. |

### Response

`200` -- Returns an array of version records with version number, publish date, publish status, and author.

---

## Get Properties

Retrieve the custom properties (tags) assigned to a design component.

```
GET /api/v2/design-components/{id}/properties
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Design component ID. |

### Response

`200` -- Returns an array of property key-value pairs.

---

## Get Dependencies

Retrieve the dependency tree for a design component. Shows which other components (snippets, data views, etc.) are referenced by this component.

```
GET /api/v2/design-components/{id}/dependencies
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Design component ID. |

### Response

`200` -- Returns a dependency tree showing referenced components with their IDs, types, and names.

---

## Export Package

Export a single design component as a package file.

```
GET /api/v2/design-components/{id}/package
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Design component ID. |

### Query Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `packageType` | string | Package format: `apk` (compressed) or `apkx` (uncompressed). |

### Response

`200` -- Returns the package file as `application/octet-stream`.

---

## Export Package by Selection

Export multiple design components as a single package file. Allows fine-grained control over which components and dependencies to include.

```
POST /api/v2/design-components/package
```

### Request Body

An array of `DesignComponentExportSelection` objects.

**Content-Type:** `application/json`

| Field | Type | Description |
| --- | --- | --- |
| `id` | string | Design component ID to include in the export. |
| `componentType` | string | The type of the component (e.g. `Template`, `Snippet`). |
| `exportThisDesignItemOnly` | boolean | If `true`, export only this component without its dependencies. |
| `includeSnippetsFilteredByCategories` | boolean | If `true`, include only snippets that match the category filters configured on the component. |

### Response

`200` -- Returns the combined package file as `application/octet-stream`.

### Example

```json
[
  {
    "id": "4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67",
    "componentType": "Template",
    "exportThisDesignItemOnly": false,
    "includeSnippetsFilteredByCategories": true
  },
  {
    "id": "B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6A1",
    "componentType": "Snippet",
    "exportThisDesignItemOnly": true,
    "includeSnippetsFilteredByCategories": false
  }
]
```

---

## Import Package

Import a design component package into the system. This can create new components or update existing ones.

```
PUT /api/v2/design-components/package
```

### Query Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `behalfOfUser` | string | User context for the import. The imported components are attributed to this user. |
| `publishComment` | string | Comment to record against the published version. |
| `publishDate` | date-time | Scheduled publish date. If not specified, the components are published immediately. |
| `discardCheckOut` | boolean | If `true`, discard any existing check-out on the target components before importing. |

### Request Body

A `DesignComponentPackage` object containing the package data.

**Content-Type:** `application/json`

### Response

`200` -- Import completed successfully.

---

## Design Component Types

| Type | Description |
| --- | --- |
| `Template` | A Word-based document template (.dotm) containing merge fields, rules, and calculations. |
| `TemplateSet` | A named collection of templates that are assembled together as a document set. |
| `DesignItemSet` | A grouping container for organizing related design items. |
| `Snippet` | A reusable content block that can be inserted into templates. May be static or dynamic (active). |
| `SnippetActive` | An active snippet with its own fields and rules that are evaluated at assembly time. |
| `DataView` | A data connection definition for retrieving data from external sources during assembly. |
| `Workflow` | A workflow definition controlling the approval and lifecycle of design components. |

---

## Component Status Values

| Status | Description |
| --- | --- |
| `NotSet` | Status has not been assigned. |
| `Approved` | The component has been approved and is available for use in document production. |
| `Disabled` | The component has been disabled and cannot be used in new jobs. |
| `Deleted` | The component has been soft-deleted. |
| `Error` | The component has an error that prevents it from being used. |
| `PendingApproval` | The component has been submitted for approval and is awaiting review. |
| `ApprovalDeclined` | The component's approval request was declined. |

---

## Search Component Types

The `searchComponentType` field in the search criteria accepts the following values to filter results by component type.

| Value | Description |
| --- | --- |
| `Template` | Search for templates only. |
| `TemplateSet` | Search for template sets only. |
| `Snippet` | Search for snippets (both static and active). |
| `SnippetActive` | Search for active snippets only. |
| `DataView` | Search for data views only. |
| `Workflow` | Search for workflows only. |
| `DesignItemSet` | Search for design item sets only. |

---

## Check Out Status Values

Design components use a check-out model to prevent concurrent editing. The following status values indicate the current check-out state.

| Status | Description |
| --- | --- |
| `NotCheckedOut` | The component is not checked out and is available for editing. |
| `CheckedOut` | The component is checked out by a user. Only that user can modify it until it is checked in. |
| `CheckedOutByOther` | The component is checked out by a different user. The current user cannot modify it. |
| `CheckedIn` | The component has been checked in after editing. A new version may be pending approval. |
