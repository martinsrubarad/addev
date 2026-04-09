The ActiveDocs API (V2) provides RESTful endpoints for automated document production and design component management. It is available with the **Solutions Studio** license.

## Base URL

All API endpoints are relative to your ActiveDocs server:

```
https://{your-server}/api/v2/
```

## Key Conventions

### ID Format

All `id` parameters are GUIDs formatted in **uppercase with no hyphens** (32 characters), unless otherwise specified.

```
Example: 4B1D5E6FA7C84D3E9F0A1B2C3D4E5F67
```

### Date Formats

Query string dates accept the following formats (time portion is optional):

| Format | Example |
| --- | --- |
| `yyyy-mm-dd hh:mm:ss` (24-hour) | `2026-03-27 14:30:00` |
| `yyyy-mm-ddThh:mm:ssZ` (ISO 8601) | `2026-03-27T14:30:00Z` |

### Include Parameter

Many endpoints support an optional `include` parameter to fetch related data in a single request. Set it to `all` or a comma-delimited list of elements:

```
GET /api/v2/documents/{ID}?include=answerfile,properties
GET /api/v2/jobs/{ID}?include=all
```

### Content Types

The API accepts and returns JSON by default. XML is also supported on most endpoints.

- `application/json`
- `application/xml`

## Support

For more information, refer to the **ActiveDocs Solutions Studio Developers Guide** or contact [ActiveDocs Support](https://www.activedocs.com/technical/technical_support/).
