## Answer File Format

ActiveDocs uses a structured answer format (version 3.0) to supply data for document assembly. Answers provide the values that are merged into templates during document production -- field values, repeating data, images, snippets, and file references.

Answers can be supplied in JSON format within a `JobDef` submission, or as standalone answer files that are uploaded and referenced by ID.

## Basic Field Types

ActiveDocs supports the following primitive field types. Each answer consists of a `name`, `value`, and `type`.

### Text

```json
{ "name": "ClientName", "value": "Acme Corporation", "type": "Text" }
```

### Numeric

```json
{ "name": "Quantity", "value": "150", "type": "Numeric" }
```

### Currency

```json
{ "name": "TotalAmount", "value": "2499.99", "type": "Currency" }
```

### Percentage

```json
{ "name": "DiscountRate", "value": "12.5", "type": "Percentage" }
```

### Date

Date values use the format `yyyy-MM-dd hh:mm`.

```json
{ "name": "ContractDate", "value": "2026-04-09 00:00", "type": "Date" }
```

### Time

```json
{ "name": "MeetingTime", "value": "14:30", "type": "Time" }
```

### YesNo

```json
{ "name": "IncludeAppendix", "value": "true", "type": "YesNo" }
```

## The ActiveDocsAnswers JSON Structure

The `activeDocsAnswers` object is embedded within a `jobItem` in the `JobDef`. It contains a `version` identifier, optional `properties`, and the `body` with the answer data.

```json
{
  "activeDocsAnswers": {
    "version": "3.0",
    "properties": {
      "description": "Answers for Q4 contract generation",
      "author": "Integration Service"
    },
    "body": {
      "answers": [
        { "name": "ClientName", "value": "Acme Corporation", "type": "Text" },
        { "name": "ContractDate", "value": "2026-04-09 00:00", "type": "Date" },
        { "name": "ContractValue", "value": "50000", "type": "Currency" },
        { "name": "IncludeWarranty", "value": "true", "type": "YesNo" }
      ]
    }
  }
}
```

### Structure Reference

| Field | Type | Description |
| --- | --- | --- |
| `version` | string | Answer format version. Use `"3.0"`. |
| `properties` | object | Optional metadata about the answer set. |
| `body.answers` | array | Array of answer objects. Each object has `name`, `value`, and `type`. |

### Answer Object

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | string | Yes | The field name as defined in the template. |
| `value` | string | Yes | The field value, represented as a string regardless of type. |
| `type` | string | Yes | The data type: `Text`, `Numeric`, `Currency`, `Percentage`, `Date`, `Time`, `YesNo`. |

## Repeating Items (Answer Groups)

Repeating data (such as invoice line items, list entries, or table rows) is represented using `AnswerGroup` objects with `type` set to `RepeatingGroup`. Each iteration of the repeating group is a child `AnswerGroup` containing the fields for that row.

```json
{
  "name": "LineItems",
  "type": "RepeatingGroup",
  "answerGroups": [
    {
      "answers": [
        { "name": "Description", "value": "Widget A", "type": "Text" },
        { "name": "Quantity", "value": "10", "type": "Numeric" },
        { "name": "UnitPrice", "value": "25.00", "type": "Currency" }
      ]
    },
    {
      "answers": [
        { "name": "Description", "value": "Widget B", "type": "Text" },
        { "name": "Quantity", "value": "5", "type": "Numeric" },
        { "name": "UnitPrice", "value": "42.50", "type": "Currency" }
      ]
    }
  ]
}
```

## Full Examples

### SimpleContract

A basic contract with scalar fields only.

```json
{
  "activeDocsAnswers": {
    "version": "3.0",
    "body": {
      "answers": [
        { "name": "ContractNumber", "value": "CNT-2026-0042", "type": "Text" },
        { "name": "ClientName", "value": "Northwind Traders", "type": "Text" },
        { "name": "ClientAddress", "value": "123 Commerce Street, Auckland 1010", "type": "Text" },
        { "name": "ContractDate", "value": "2026-04-09 00:00", "type": "Date" },
        { "name": "ExpiryDate", "value": "2027-04-09 00:00", "type": "Date" },
        { "name": "ContractValue", "value": "75000", "type": "Currency" },
        { "name": "PaymentTerms", "value": "Net 30", "type": "Text" },
        { "name": "IncludeNDA", "value": "true", "type": "YesNo" }
      ]
    }
  }
}
```

### InvoiceWithLineItems

An invoice demonstrating repeating groups for line items.

```json
{
  "activeDocsAnswers": {
    "version": "3.0",
    "body": {
      "answers": [
        { "name": "InvoiceNumber", "value": "INV-2026-1087", "type": "Text" },
        { "name": "InvoiceDate", "value": "2026-04-09 00:00", "type": "Date" },
        { "name": "CustomerName", "value": "Contoso Ltd", "type": "Text" },
        { "name": "DueDate", "value": "2026-05-09 00:00", "type": "Date" },
        { "name": "TaxRate", "value": "15", "type": "Percentage" },
        {
          "name": "LineItems",
          "type": "RepeatingGroup",
          "answerGroups": [
            {
              "answers": [
                { "name": "ProductCode", "value": "WDG-001", "type": "Text" },
                { "name": "Description", "value": "Standard Widget", "type": "Text" },
                { "name": "Quantity", "value": "100", "type": "Numeric" },
                { "name": "UnitPrice", "value": "12.50", "type": "Currency" }
              ]
            },
            {
              "answers": [
                { "name": "ProductCode", "value": "WDG-002", "type": "Text" },
                { "name": "Description", "value": "Premium Widget", "type": "Text" },
                { "name": "Quantity", "value": "25", "type": "Numeric" },
                { "name": "UnitPrice", "value": "34.00", "type": "Currency" }
              ]
            },
            {
              "answers": [
                { "name": "ProductCode", "value": "SVC-010", "type": "Text" },
                { "name": "Description", "value": "Installation Service", "type": "Text" },
                { "name": "Quantity", "value": "1", "type": "Numeric" },
                { "name": "UnitPrice", "value": "500.00", "type": "Currency" }
              ]
            }
          ]
        }
      ]
    }
  }
}
```

### CarInsurancePolicy

A policy document with nested repeating groups for drivers and coverage options.

```json
{
  "activeDocsAnswers": {
    "version": "3.0",
    "body": {
      "answers": [
        { "name": "PolicyNumber", "value": "POL-AUTO-88421", "type": "Text" },
        { "name": "PolicyStartDate", "value": "2026-04-09 00:00", "type": "Date" },
        { "name": "PolicyEndDate", "value": "2027-04-09 00:00", "type": "Date" },
        { "name": "VehicleMake", "value": "Toyota", "type": "Text" },
        { "name": "VehicleModel", "value": "Camry", "type": "Text" },
        { "name": "VehicleYear", "value": "2024", "type": "Numeric" },
        { "name": "VehicleVIN", "value": "1HGBH41JXMN109186", "type": "Text" },
        { "name": "AnnualPremium", "value": "1850.00", "type": "Currency" },
        {
          "name": "Drivers",
          "type": "RepeatingGroup",
          "answerGroups": [
            {
              "answers": [
                { "name": "DriverName", "value": "Jane Smith", "type": "Text" },
                { "name": "LicenseNumber", "value": "DL-9928374", "type": "Text" },
                { "name": "DateOfBirth", "value": "1985-06-15 00:00", "type": "Date" },
                { "name": "IsPrimaryDriver", "value": "true", "type": "YesNo" }
              ]
            },
            {
              "answers": [
                { "name": "DriverName", "value": "John Smith", "type": "Text" },
                { "name": "LicenseNumber", "value": "DL-5537281", "type": "Text" },
                { "name": "DateOfBirth", "value": "1983-02-20 00:00", "type": "Date" },
                { "name": "IsPrimaryDriver", "value": "false", "type": "YesNo" }
              ]
            }
          ]
        },
        {
          "name": "CoverageOptions",
          "type": "RepeatingGroup",
          "answerGroups": [
            {
              "answers": [
                { "name": "CoverageType", "value": "Comprehensive", "type": "Text" },
                { "name": "CoverageLimit", "value": "50000", "type": "Currency" },
                { "name": "Deductible", "value": "500", "type": "Currency" }
              ]
            },
            {
              "answers": [
                { "name": "CoverageType", "value": "Third Party", "type": "Text" },
                { "name": "CoverageLimit", "value": "100000", "type": "Currency" },
                { "name": "Deductible", "value": "250", "type": "Currency" }
              ]
            }
          ]
        }
      ]
    }
  }
}
```

## Image Answers

Images can be embedded in documents using two methods: inline Base64 data or a file path reference.

### Inline Base64 Image

Provide the image data directly as a Base64-encoded string using the `AnswerImageData` structure.

```json
{
  "name": "CompanyLogo",
  "type": "Image",
  "answerImageData": {
    "dataBase64": "/9j/4AAQSkZJRgABAQEASABIAAD/2wBDAAgGBgcGBQgHBwcJCQ..."
  }
}
```

### File Path Reference

Reference an image file accessible from the ActiveDocs server.

```json
{
  "name": "CompanyLogo",
  "type": "Image",
  "answerImageData": {
    "imageFileSource": "C:\\ActiveDocsData\\Images\\company-logo.png"
  }
}
```

The file path must be accessible from the ActiveDocs server's file system. Use UNC paths for network locations.

## Snippet Answers

Snippets are reusable content blocks (rich text, HTML, or other formatted content) that can be inserted into documents. Use the `AnswerSnippetData` structure to supply snippet content.

```json
{
  "name": "TermsAndConditions",
  "type": "Snippet",
  "answerSnippetData": {
    "snippetID": "7A8B9C0D1E2F3A4B5C6D7E8F9A0B1C2D",
    "snippetFormatType": "HTML",
    "dataBase64": "PGgzPlRlcm1zIGFuZCBDb25kaXRpb25zPC9oMz48cD5UaGVzZSB0ZXJtcy4uLjwvcD4="
  }
}
```

| Field | Type | Description |
| --- | --- | --- |
| `snippetID` | string | The GUID of a design component snippet to use. If provided, the snippet content is retrieved from the server. |
| `snippetFormatType` | string | The format of the snippet content: `HTML`, `RTF`, `WordML`, `DocX`. |
| `dataBase64` | string | Base64-encoded snippet content. Used when supplying inline content rather than referencing a stored snippet. |

When `snippetID` is provided, the server retrieves the snippet from the design component library. When `dataBase64` is provided, the inline content is used directly.

## File Reference Snippets

File Reference (FileRef) snippets allow you to merge external documents -- such as PDF files, Word documents, or other file types -- directly into the assembled output. This is useful for appending pre-existing documents like signed agreements, regulatory disclosures, or third-party reports.

```json
{
  "name": "SignedAgreement",
  "type": "Snippet",
  "answerSnippetData": {
    "fileRef": {
      "source": "C:\\ActiveDocsData\\Attachments\\signed-agreement.pdf",
      "formatID": 7,
      "headerHeight": 0,
      "footerHeight": 0,
      "resolution": 300
    }
  }
}
```

### Supported Format IDs

| Format ID | Format |
| --- | --- |
| 1 | WordML |
| 2 | DocX |
| 3 | HTML |
| 5 | RTF |
| 6 | DOC |
| 7 | PDF |
| 8 | TIF |

### FileRef Options

| Field | Type | Description |
| --- | --- | --- |
| `source` | string | File path or URL to the external document. Must be accessible from the ActiveDocs server. |
| `formatID` | integer | The format identifier from the table above. |
| `headerHeight` | number | Height (in points) to reserve for headers when converting the referenced file. Set to `0` if no header adjustment is needed. |
| `footerHeight` | number | Height (in points) to reserve for footers when converting the referenced file. Set to `0` if no footer adjustment is needed. |
| `resolution` | integer | Resolution in DPI for rasterizing the referenced file (applicable to PDF and TIF formats). Common values: `150`, `200`, `300`. |

## Complex Nested Answers

For deeply nested data structures, ActiveDocs supports multiple levels of answer group nesting. Each level uses the `Evaluate` attribute to indicate the nesting depth, and groups are structured using `answergroup` and `group` types.

The following example demonstrates a three-level hierarchy from the Dalmore Corporation sample: Company > Employees > Benefits.

```json
{
  "activeDocsAnswers": {
    "version": "3.0",
    "body": {
      "answers": [
        { "name": "CompanyName", "value": "Dalmore Corporation", "type": "Text" },
        { "name": "CompanyAddress", "value": "45 Highland Drive, Edinburgh EH1 2AB", "type": "Text" },
        {
          "name": "StoreLocations",
          "type": "RepeatingGroup",
          "evaluate": "3",
          "answerGroups": [
            {
              "type": "answergroup",
              "answers": [
                { "name": "StoreName", "value": "Edinburgh Central", "type": "Text" },
                { "name": "StoreManager", "value": "Fiona MacLeod", "type": "Text" },
                {
                  "name": "Employees",
                  "type": "RepeatingGroup",
                  "answerGroups": [
                    {
                      "type": "group",
                      "answers": [
                        { "name": "EmployeeName", "value": "Alistair Grant", "type": "Text" },
                        { "name": "EmployeeRole", "value": "Sales Associate", "type": "Text" },
                        { "name": "StartDate", "value": "2023-03-15 00:00", "type": "Date" },
                        {
                          "name": "Benefits",
                          "type": "RepeatingGroup",
                          "answerGroups": [
                            {
                              "type": "group",
                              "answers": [
                                { "name": "BenefitType", "value": "Health Insurance", "type": "Text" },
                                { "name": "BenefitValue", "value": "1200.00", "type": "Currency" }
                              ]
                            },
                            {
                              "type": "group",
                              "answers": [
                                { "name": "BenefitType", "value": "Pension Contribution", "type": "Text" },
                                { "name": "BenefitValue", "value": "800.00", "type": "Currency" }
                              ]
                            }
                          ]
                        }
                      ]
                    },
                    {
                      "type": "group",
                      "answers": [
                        { "name": "EmployeeName", "value": "Morag Campbell", "type": "Text" },
                        { "name": "EmployeeRole", "value": "Store Supervisor", "type": "Text" },
                        { "name": "StartDate", "value": "2021-08-01 00:00", "type": "Date" },
                        {
                          "name": "Benefits",
                          "type": "RepeatingGroup",
                          "answerGroups": [
                            {
                              "type": "group",
                              "answers": [
                                { "name": "BenefitType", "value": "Health Insurance", "type": "Text" },
                                { "name": "BenefitValue", "value": "1500.00", "type": "Currency" }
                              ]
                            }
                          ]
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            {
              "type": "answergroup",
              "answers": [
                { "name": "StoreName", "value": "Glasgow West", "type": "Text" },
                { "name": "StoreManager", "value": "Ian Robertson", "type": "Text" },
                {
                  "name": "Employees",
                  "type": "RepeatingGroup",
                  "answerGroups": [
                    {
                      "type": "group",
                      "answers": [
                        { "name": "EmployeeName", "value": "Duncan Fraser", "type": "Text" },
                        { "name": "EmployeeRole", "value": "Sales Associate", "type": "Text" },
                        { "name": "StartDate", "value": "2024-01-10 00:00", "type": "Date" },
                        {
                          "name": "Benefits",
                          "type": "RepeatingGroup",
                          "answerGroups": [
                            {
                              "type": "group",
                              "answers": [
                                { "name": "BenefitType", "value": "Health Insurance", "type": "Text" },
                                { "name": "BenefitValue", "value": "1200.00", "type": "Currency" }
                              ]
                            }
                          ]
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    }
  }
}
```

### Nesting Structure Reference

| Concept | Description |
| --- | --- |
| `evaluate` | Indicates the nesting depth for the repeating group. `"3"` means the group contains nested sub-groups up to 3 levels deep. |
| `type: "answergroup"` | Marks a top-level iteration within the repeating group. |
| `type: "group"` | Marks a nested iteration within a parent answer group. |
| `type: "RepeatingGroup"` | Identifies an answer as a container for repeating data at any nesting level. |

## Answer Properties

The optional `properties` object within `activeDocsAnswers` provides metadata about the answer set. These properties do not affect document assembly but are stored with the answer record for reference and auditing.

```json
{
  "activeDocsAnswers": {
    "version": "3.0",
    "properties": {
      "description": "Generated by CRM Integration for order ORD-2026-4521",
      "author": "CRM Integration Service",
      "created": "2026-04-09 10:30",
      "modified": "2026-04-09 10:30",
      "reference": "ORD-2026-4521"
    },
    "body": {
      "answers": []
    }
  }
}
```

| Property | Type | Description |
| --- | --- | --- |
| `description` | string | A human-readable description of the answer set. |
| `author` | string | The user or system that created the answers. |
| `created` | string | The date and time the answer set was created. |
| `modified` | string | The date and time the answer set was last modified. |
| `reference` | string | An external reference identifier for linking to source systems. |
