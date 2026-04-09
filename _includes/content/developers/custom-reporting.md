## Overview

ActiveDocs provides a set of database views for building custom reports. You can create RDLC reports in Visual Studio, deploy them to the ActiveDocs Reports directory, and make them available to users through AdminCenter.

## Database Views

The following reporting views are available in the ActiveDocs database:

| View | Purpose | Key Fields |
|---|---|---|
| `rptActivityGeneral` | General user activity and audit trail. | `ActivityDate`, `UserLogin`, `UserName`, `ActivityType`, `SubsiteName`, `TemplateName`, `DocumentID`, `IPAddress` |
| `rptJobErrors` | Failed job details and error messages. | `JobID`, `ErrorDate`, `ErrorMessage`, `TemplateName`, `SubsiteName`, `QueueName`, `Severity` |
| `rptBatchDeliveryGeneral` | Batch delivery operations and results. | `BatchID`, `BatchName`, `DeliveryDate`, `TotalDocuments`, `SuccessCount`, `FailureCount`, `SubsiteName`, `QueueName` |
| `rptDeliveryGeneral` | Individual document delivery records. | `DeliveryID`, `DocumentID`, `DeliveryDate`, `DeliveryStatus`, `DeliveryChannel`, `RecipientAddress`, `SubsiteName`, `TemplateName`, `FileSize` |
| `rptDocumentsGeneral` | All generated documents and their properties. | `DocumentID`, `DocumentName`, `CreatedDate`, `CreatedByUser`, `TemplateName`, `SubsiteName`, `FileSize`, `FileExtension`, `DocumentStatus` |

## Report Criteria Fields

When building report queries, filter on these common criteria:

| Field | Type | Description |
|---|---|---|
| `ReportDate` | `datetime` | The date/time the activity or event occurred. Use for date range filtering. |
| `Subsite` | `nvarchar` | The subsite name. Filter to restrict reports to a specific subsite. |
| `TemplateName` | `nvarchar` | The template used to produce the document. |
| `DocumentPropertyName` | `nvarchar` | The name of a document property (for property-based filtering). |
| `DocumentPropertyValue` | `nvarchar` | The value of a document property. |
| `DeliveryStatus` | `nvarchar` | The delivery outcome: `Completed`, `Failed`, `Pending`, `TimedOut`. |
| `QueueName` | `nvarchar` | The processing queue name. |

## Creating Custom RDLC Reports

### Step 1: Create the Report in Visual Studio

1. Open Visual Studio and create a new **Class Library** project (or add to an existing reporting project).
2. Add a new item of type **Report** (`.rdlc` file).
3. The Report Designer opens in the layout view.

### Step 2: Configure the Data Source

1. In the **Report Data** pane, right-click **Datasets** and select **Add Dataset**.
2. Choose **Use a dataset embedded in my report**.
3. Create a new data source pointing to the ActiveDocs database.

### Step 3: Add the Dataset

Define the SQL query for the dataset. For example, a document summary query:

```sql
SELECT
    d.DocumentID,
    d.DocumentName,
    d.CreatedDate,
    d.CreatedByUser,
    d.TemplateName,
    d.SubsiteName,
    d.FileSize,
    d.FileExtension
FROM rptDocumentsGeneral d
WHERE d.CreatedDate BETWEEN @StartDate AND @EndDate
  AND (@Subsite IS NULL OR d.SubsiteName = @Subsite)
  AND (@TemplateName IS NULL OR d.TemplateName = @TemplateName)
ORDER BY d.CreatedDate DESC
```

### Step 4: Design the Report Layout

1. Drag a **Table** or **Matrix** control from the toolbox onto the report body.
2. Map dataset fields to table columns.
3. Add a report title using a **TextBox** control.
4. Add headers, footers, and page numbers as needed.
5. Apply formatting — fonts, colors, borders — to match your organization's style.

### Step 5: Add Parameters

Add report parameters that correspond to the SQL query parameters:

| Parameter | Type | Allow Null | Default |
|---|---|---|---|
| `StartDate` | `DateTime` | No | First day of current month |
| `EndDate` | `DateTime` | No | Today |
| `Subsite` | `String` | Yes | `null` (all subsites) |
| `TemplateName` | `String` | Yes | `null` (all templates) |

### Step 6: Deploy

1. Build the project to ensure the `.rdlc` file compiles without errors.
2. Copy the `.rdlc` file to the ActiveDocs **Reports/** directory on the server (typically `C:\inetpub\wwwroot\ActiveDocs\Reports\`).
3. In AdminCenter, navigate to **Reports > Custom Reports** and register the new report file.
4. Assign permissions to control which roles can view the report.

## Example: Document Volume Report

This report shows the number of documents produced over time, grouped by day and template.

### SQL Query

```sql
SELECT
    CAST(d.CreatedDate AS DATE) AS ProductionDate,
    d.TemplateName,
    d.SubsiteName,
    COUNT(*) AS DocumentCount,
    SUM(d.FileSize) AS TotalFileSize,
    AVG(d.FileSize) AS AvgFileSize
FROM rptDocumentsGeneral d
WHERE d.CreatedDate BETWEEN @StartDate AND @EndDate
  AND (@Subsite IS NULL OR d.SubsiteName = @Subsite)
GROUP BY
    CAST(d.CreatedDate AS DATE),
    d.TemplateName,
    d.SubsiteName
ORDER BY
    ProductionDate DESC,
    DocumentCount DESC
```

### Report Layout

Design the report with:

- A **chart** (bar or line) showing document counts over time.
- A **summary table** with columns: Date, Template, Subsite, Document Count, Total Size (MB), Avg Size (KB).
- A **totals row** at the bottom aggregating all counts and sizes.
- **Parameters** displayed in the report header for context.

Format the file sizes for readability:

```sql
-- Total size in megabytes
CAST(SUM(d.FileSize) / 1048576.0 AS DECIMAL(10, 2)) AS TotalSizeMB

-- Average size in kilobytes
CAST(AVG(d.FileSize) / 1024.0 AS DECIMAL(10, 2)) AS AvgSizeKB
```

## Example: Delivery Success Rate Report

This report provides insight into delivery reliability across channels and templates.

### SQL Query

```sql
SELECT
    d.DeliveryChannel,
    d.TemplateName,
    d.SubsiteName,
    COUNT(*) AS TotalDeliveries,
    SUM(CASE WHEN d.DeliveryStatus = 'Completed' THEN 1 ELSE 0 END) AS SuccessCount,
    SUM(CASE WHEN d.DeliveryStatus = 'Failed' THEN 1 ELSE 0 END) AS FailureCount,
    SUM(CASE WHEN d.DeliveryStatus = 'TimedOut' THEN 1 ELSE 0 END) AS TimedOutCount,
    CAST(
        SUM(CASE WHEN d.DeliveryStatus = 'Completed' THEN 1 ELSE 0 END) * 100.0
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(5, 2)
    ) AS SuccessRatePercent,
    CAST(
        SUM(CASE WHEN d.DeliveryStatus = 'Failed' THEN 1 ELSE 0 END) * 100.0
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(5, 2)
    ) AS FailureRatePercent
FROM rptDeliveryGeneral d
WHERE d.DeliveryDate BETWEEN @StartDate AND @EndDate
  AND (@Subsite IS NULL OR d.SubsiteName = @Subsite)
  AND (@DeliveryChannel IS NULL OR d.DeliveryChannel = @DeliveryChannel)
GROUP BY
    d.DeliveryChannel,
    d.TemplateName,
    d.SubsiteName
ORDER BY
    SuccessRatePercent ASC,
    TotalDeliveries DESC
```

### Report Layout

Design the report with:

- A **summary section** showing overall success rate across all channels.
- A **grouped table** with rows per delivery channel and template, columns for Total, Success, Failed, Timed Out, Success %, and Failure %.
- **Conditional formatting** to highlight rows where the failure rate exceeds a threshold (e.g., red background for failure rate above 5%).
- A **pie chart** showing the proportion of each delivery status.

### Report Parameters

| Parameter | Type | Allow Null | Description |
|---|---|---|---|
| `StartDate` | `DateTime` | No | Beginning of the reporting period. |
| `EndDate` | `DateTime` | No | End of the reporting period. |
| `Subsite` | `String` | Yes | Filter by subsite. Null for all. |
| `DeliveryChannel` | `String` | Yes | Filter by channel (e.g., Email, Print, DMS). Null for all. |
