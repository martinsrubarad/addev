The Subsites and Users API provides endpoints for managing subsites, user accounts, authentication, and access control within an ActiveDocs environment.

## Subsite Management

A subsite is an isolated workspace within an ActiveDocs installation. Each subsite has its own templates, settings, users, and delivery configuration.

---

### Get Subsites

Retrieve all subsites accessible to the authenticated user, with optional related models.

```
GET /api/v2/subsites
```

#### Query Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `include` | string | Related models to include. Accepts a comma-delimited list or a numeric bitmask value. |

#### Include Options (eSubsiteIncludeOptions)

| Name | Value | Description |
| --- | --- | --- |
| `None` | 0 | No related models included. |
| `CustomFields` | 1 | Include custom field definitions for the subsite. |
| `Settings` | 2 | Include subsite configuration settings (sensitive data excluded). |
| `Users` | 4 | Include users assigned to the subsite. |
| `UserGroups` | 8 | Include user groups defined in the subsite. |
| `Workflow` | 16 | Include workflow configuration for the subsite. |
| `All` | 31 | Include all related models. |

#### Responses

| Status | Description |
| --- | --- |
| `200` | Returns an array of subsite objects with the requested related models. |

#### Example

```
GET /api/v2/subsites?include=All
```

---

### Get Subsite

Retrieve a specific subsite by its ID or name.

```
GET /api/v2/subsites/{id}
```

#### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Subsite ID (GUID, uppercase, no hyphens) or subsite name. |

#### Responses

| Status | Description |
| --- | --- |
| `200` | Returns the subsite object. |
| `204` | No Content — Subsite not found. |

#### Example

```
GET /api/v2/subsites/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67
```

```
GET /api/v2/subsites/Production
```

---

### Get Subsite Settings

Retrieve the configuration settings for a specific subsite. Sensitive data such as passwords and connection strings is excluded from the response.

```
GET /api/v2/subsites/{id}/settings
```

#### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Subsite ID (GUID, uppercase, no hyphens) or subsite name. |

#### Responses

| Status | Description |
| --- | --- |
| `200` | Returns the subsite settings object. Sensitive fields are omitted. |
| `204` | No Content — Subsite not found. |

---

### Get Subsite User Groups

Retrieve the user groups defined within a specific subsite.

```
GET /api/v2/subsites/{id}/usergroups
```

#### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Subsite ID (GUID, uppercase, no hyphens) or subsite name. |

#### Responses

| Status | Description |
| --- | --- |
| `200` | Returns an array of user group objects for the subsite. |
| `204` | No Content — Subsite not found. |

---

### Get Subsite Users

Retrieve the users assigned to a specific subsite.

```
GET /api/v2/subsites/{id}/users
```

#### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Subsite ID (GUID, uppercase, no hyphens) or subsite name. |

#### Responses

| Status | Description |
| --- | --- |
| `200` | Returns an array of user objects assigned to the subsite. |
| `204` | No Content — Subsite not found. |

---

### Get Subsite Custom Fields

Retrieve the custom field definitions configured for a specific subsite.

```
GET /api/v2/subsites/{id}/customfields
```

#### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Subsite ID (GUID, uppercase, no hyphens) or subsite name. |

#### Responses

| Status | Description |
| --- | --- |
| `200` | Returns an array of custom field definitions for the subsite. |
| `204` | No Content — Subsite not found. |

---

### Get Subsite Workflow

Retrieve the workflow configuration for a specific subsite, including approval stages and routing rules.

```
GET /api/v2/subsites/{id}/workflow
```

#### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | Subsite ID (GUID, uppercase, no hyphens) or subsite name. |

#### Responses

| Status | Description |
| --- | --- |
| `200` | Returns the workflow configuration for the subsite. |
| `204` | No Content — Subsite not found. |

---

## User Management

Users represent individual accounts that can authenticate with ActiveDocs and access subsites based on their assigned permissions.

### User Model

| Field | Type | Description |
| --- | --- | --- |
| `id` | string | User ID (GUID, uppercase, no hyphens). |
| `userName` | string | Login username for the user. |
| `firstName` | string | User's first name. |
| `lastName` | string | User's last name. |
| `email` | string | User's email address. |
| `isActive` | boolean | Whether the user account is active. |
| `isAdmin` | boolean | Whether the user has administrative privileges. |
| `dateCreated` | date-time | Date and time the user account was created. |
| `lastLogin` | date-time | Date and time of the user's most recent login. |

---

### Get Users

Retrieve all users, optionally filtered by subsite.

```
GET /api/v2/users
```

#### Query Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `subsite` | string | Filter users by subsite. Accepts a subsite ID, subsite name, or `"default"` for the default subsite. |

#### Responses

| Status | Description |
| --- | --- |
| `200` | Returns an array of user objects. |

#### Example

```
GET /api/v2/users?subsite=default
```

---

### Get User

Retrieve a specific user by ID, with optional related models.

```
GET /api/v2/users/{id}
```

#### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | User ID (GUID, uppercase, no hyphens). |

#### Query Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `include` | string | Related models to include. Accepts a comma-delimited list or a numeric bitmask value. |

#### Include Options (eUserIncludeOptions)

| Name | Value | Description |
| --- | --- | --- |
| `None` | 0 | No related models included. |
| `CustomFields` | 1 | Include custom fields assigned to the user. |
| `Subsites` | 2 | Include subsites the user has access to. |
| `SystemFunctions` | 4 | Include system function permissions for the user. |
| `All` | 7 | Include all related models (CustomFields + Subsites + SystemFunctions). |

#### Responses

| Status | Description |
| --- | --- |
| `200` | Returns a `User` model with the requested related models. |
| `204` | No Content — User not found. |

#### Example

```
GET /api/v2/users/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67?include=All
```

---

### Get User Custom Fields

Retrieve the custom fields assigned to a specific user.

```
GET /api/v2/users/{id}/customfields
```

#### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | User ID (GUID, uppercase, no hyphens). |

#### Responses

| Status | Description |
| --- | --- |
| `200` | Returns an array of custom field objects for the user. |
| `204` | No Content — User not found. |

---

### Get User Subsites

Retrieve the subsites a specific user has access to.

```
GET /api/v2/users/{id}/subsites
```

#### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | User ID (GUID, uppercase, no hyphens). |

#### Responses

| Status | Description |
| --- | --- |
| `200` | Returns an array of subsite objects the user is assigned to. |
| `204` | No Content — User not found. |

---

### Get User System Functions

Retrieve the system function permissions assigned to a user, optionally scoped to a specific subsite.

```
GET /api/v2/users/{id}/systemfunctions
```

#### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | User ID (GUID, uppercase, no hyphens). |

#### Query Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `subsite` | string | Scope the system functions to a specific subsite. Accepts a subsite ID, subsite name, or `"default"`. |

#### Responses

| Status | Description |
| --- | --- |
| `200` | Returns an array of system function permission objects for the user. |
| `204` | No Content — User not found. |

#### Example

```
GET /api/v2/users/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67/systemfunctions?subsite=default
```

---

### Authenticate User

Authenticate a user with credentials or refresh an existing session token. Returns a JWT token that is valid for 60 minutes.

```
POST /api/v2/users/authenticate
```

#### Query Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `refreshToken` | boolean | If `true`, the response includes a refresh token ID that can be used to obtain a new JWT without re-supplying credentials. |

#### Request Body

A `UserSignIn` object containing authentication credentials.

**Content-Type:** `application/json`

**Authenticate with username and password:**

```json
{
  "userName": "admin",
  "password": "P@ssw0rd"
}
```

**Authenticate with a refresh token:**

```json
{
  "tokenRefreshID": "A1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6"
}
```

#### Responses

| Status | Description |
| --- | --- |
| `200` | Returns an authentication result containing the JWT token, expiry information, and optionally a refresh token ID. |
| `401` | Unauthorized — Invalid credentials or expired refresh token. |

#### Authentication Flow

1. **Initial login:** Send a `POST` request with `userName` and `password`. Include `?refreshToken=true` if you want a refresh token for subsequent requests.
2. **Use the JWT:** Include the returned token in the `Authorization` header of all subsequent API requests as a Bearer token: `Authorization: Bearer {token}`.
3. **Token refresh:** Before the 60-minute token expires, send a new `POST` request with the `tokenRefreshID` to obtain a fresh JWT without re-entering credentials.
4. **Token expiry:** If the JWT expires without being refreshed, the user must authenticate again with username and password.

#### Example

```
POST /api/v2/users/authenticate?refreshToken=true
```

---

### Update User Custom Field

Update the value of a specific custom field for a user.

```
PUT /api/v2/users/{id}/customfields/{field}
```

#### Path Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | Yes | User ID (GUID, uppercase, no hyphens). |
| `field` | string | Yes | Custom field name or ID to update. |

#### Request Body

A `CustomField` object containing the new field value.

**Content-Type:** `application/json`

```json
{
  "name": "Department",
  "value": "Engineering"
}
```

#### Responses

| Status | Description |
| --- | --- |
| `200` | OK — Custom field updated successfully. |
| `204` | No Content — User or custom field not found. |

#### Example

```
PUT /api/v2/users/4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67/customfields/Department
```
