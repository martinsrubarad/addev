---
title: "Design Component Management"
permalink: /developers/api-design-components/
layout: single
sidebar:
  nav: "developers"
toc: true
toc_sticky: true
---

The Design Components API provides endpoints for searching and retrieving Design Components such as Templates, Template Sets, Snippets, Design Item Sets, Data Views, and Workflows.

## Search Design Components

Search for Design Components based on various criteria including date range, component status, and component type.

```
POST /api/v2/design-components/search
```

### Query Parameters

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `behalfOfUser` | string | `""` | If supplied, the results are filtered by this user's access rights. |
| `summary` | boolean | `true` | If `true`, returns a Design Component with a minimal set of attributes. |

### Request Body

A `ComponentSearchCriteria` object that can optionally specify:

- Date range
- Component status
- Component type

**Content-Type:** `application/json`

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns an array of `DesignComponentItem` objects matching the search criteria. |

> **NOTE:** The number of rows returned is controlled by the `limitRows` property in the search criteria. Defaults to 200.

### Example

```
POST /api/v2/design-components/search?summary=true
```

```json
{
  "limitRows": 50,
  "componentType": "Template",
  "status": "Approved"
}
```

---

## Get Design Component

Retrieve a specific Design Component by ID, with optional related child models.

```
GET /api/v2/design-components/{id}
```

### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | ID for the Design Component (GUID, uppercase, no hyphens). |

### Query Parameters

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `version` | integer | `0` | Version of the Design Component to retrieve. `0` returns the latest version. |
| `include` | string | — | Include related child models (e.g. `properties`, `versions`). |
| `summary` | boolean | `false` | If `true`, returns a component with a minimal set of attributes (Name, Description, etc.). |

### Responses

| Status | Description |
| --- | --- |
| `200` | Returns a `DesignComponent` model including properties and child models. |
| `204` | No Content — Design Component not found. |

### Examples

Retrieve a template with all related data:

```
GET /api/v2/design-components/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67?include=all
```

Retrieve a summary of a specific version:

```
GET /api/v2/design-components/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67?version=3&summary=true
```
