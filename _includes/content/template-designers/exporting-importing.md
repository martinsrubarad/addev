Design Components can be exported as packages for transfer between environments and imported to restore or update components. The export/import process uses the APKX package format and supports conflict detection, version management, and category assignment.

## Exporting Design Components

Exporting a Design Component creates a package file that contains the component definition, its Design Items, and optionally its referenced Snippets. The package can then be imported into another ActiveDocs environment.

### What Version Gets Exported

The version included in the export package depends on the current Version Control state of the component:

- If the component is **published**, the current published version is exported.
- If the component is **checked out**, the checked-out working version is exported.
- If the component has a **draft** version that is not yet published, the draft version is exported.

### Export Steps

To export a Design Component:

1. Right-click the Design Component and select **Export**, or select the component and click **Export** on the ribbon.
2. The **Export** dialog opens.
3. Choose the save location and file name for the export package.
4. Select the **Save as type** option:

| Save as Type | Description |
| --- | --- |
| **APKX** | The current ActiveDocs package format. This is the recommended option for transfers between ActiveDocs environments running the same or compatible versions. |
| **APK ActiveDocs Compatible** | An older package format that maintains compatibility with previous ActiveDocs versions. Use this when the target environment runs an earlier version of ActiveDocs. |
| **APK Raptor Compatible** | A package format compatible with Raptor-based systems. Use this when migrating components to or from a Raptor-based environment. |

5. Optionally enable **Export this Design Component only** to exclude referenced child components (such as linked Snippets or Design Item Sets) from the package. When this option is disabled, all referenced components are included.
6. Optionally configure **Include Snippets filtered by Categories** to restrict which Snippets are included in the export. When enabled, only Snippets assigned to the specified categories are packaged. This is useful for reducing package size or excluding irrelevant Snippets.
7. Click **Save** to create the export package.

> **NOTE:** When exporting as **APK Raptor Compatible**, some ActiveDocs-specific features that do not have Raptor equivalents may be converted or omitted during the export. Review the exported component in the target environment to verify that all features were preserved correctly.

## Importing Design Components

Importing a package adds or updates Design Components in the current WorkCenter Site. The import process performs conflict checking to identify components that already exist in the target environment, and provides options for handling each component individually.

### Import Methods

- Use the **Import** button on the ribbon or right-click menu to open the Import Package dialog.
- **Drag and drop** a package file directly into the WorkCenter Client to initiate the import.

### Version Numbering

When importing a component that already exists in the target environment, the imported version is assigned the next version number in the existing component's version history. The import targets the existing component based on its **internal ID**, regardless of whether the component's name or folder location has changed since it was exported.

### Import Package Dialog

The Import Package dialog displays the contents of the package and provides controls for each component:

| Column | Description |
| --- | --- |
| **Name** | The name of the Design Component in the package. |
| **Date** | The date the component was last modified when it was exported. |
| **Folder Name** | The folder where the component was located in the source environment. |
| **Categories** | The categories assigned to the component in the source environment. |
| **Current Name** | The name of the matching existing component in the target environment (if one exists). |
| **Current Date** | The date the existing component was last modified in the target environment. |
| **Publish Date** | The scheduled publish date for the imported version (if deferred publishing is configured). |

### Import Actions

For each component in the package, select one of the following actions:

| Action | Description |
| --- | --- |
| **Import** | Import the component. If a matching component exists, it is updated with the imported version. If no match exists, a new component is created. |
| **Do not Import** | Skip this component. It is not imported or updated. |
| **Update Folder** | Change the target folder for the imported component. Use this to place the component in a different folder than where it was originally located. |
| **Publish Options** | Configure when the imported version is published. Options include immediate publication and deferred publication to a specified date. |
| **Assign Category** | Assign one or more categories to the imported component in the target environment. |
| **Remove Category** | Remove one or more category assignments from the imported component. |

### Data View Options

When importing packages that contain Data Views, additional options are available for configuring offline data modes:

- **Make Data View available offline** — Stores the Data View data locally so the component can be used without a live connection to the data source.
- **Update offline data** — Refreshes the locally stored data with the current data from the source.

These options are relevant when the target environment operates in a disconnected or intermittently connected mode.

### Approval Interaction

If the target folder has Design Component Approval enabled, imported components enter the approval workflow. The imported version is not published until it is approved by the designated approver(s).

### Overwrite Warnings

When importing a component that matches an existing component in the target environment, a warning is displayed indicating that the existing component will be updated. The previous version is retained in the version history, allowing rollback if needed.

> **NOTE:** The import process matches components by internal ID, not by name or location. If a component was renamed or moved in the target environment after it was originally exported, the import still targets the correct component based on its ID.
