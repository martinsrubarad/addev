Version Control in ActiveDocs manages the revision history of Design Components, prevents concurrent editing conflicts, and supports publishing workflows. It applies to Templates, Template Sets, Snippets, Design Item Sets, Data Views, and Workflows.

## Viewing Design Component Relationship Information

Design Components often reference or depend on other components. The Relationships feature provides visibility into these dependencies.

To view relationship information:

1. Right-click the Design Component and select **Relationships**, or select the component and click **Relationships** on the ribbon.
2. The **Relationships** dialog opens, displaying three tabs:

| Tab | Description |
| --- | --- |
| **Contents** | Lists the Design Items and other elements contained within the component. |
| **Child Components** | Lists the Design Components that this component references or depends on (e.g., Snippets linked from a Template, Data Views used by a Template). |
| **Parent Components** | Lists the Design Components that reference this component (e.g., Templates that use this Snippet, Template Sets that include this Template). |

Click **Report** to generate a printable report of the relationship information.

## Understanding Design Component Version Control

Version Control provides the following capabilities:

- Maintains a complete history of all versions of a Design Component.
- Allows rolling back to any previous version.
- Prevents concurrent editing through a check-out/check-in mechanism.
- Supports deferred publishing, allowing a checked-in version to be scheduled for publication at a future date.
- Supports draft versions that are checked in but not yet published.

> **NOTE:** Version Control is a server-configured setting. It must be enabled on the ActiveDocs Server for the features described in this section to be available. Version Control is not available for Design Components stored in mapped (external) folders.

## Using Design Component Version Control

Each time a Design Component is checked in, a new version is recorded. The version history tracks all previous versions, including the user who made the change, the date, and any version comment provided.

To view the version history, right-click the Design Component and select **Version History**, or use the **Version History** button on the ribbon. The Versions tab displays all recorded versions.

### Rolling Back to a Previous Version

To restore a Design Component to a previous version:

1. Open the **Version History** for the component.
2. Select the desired version from the list.
3. Click **Check Out** to check out that version. It becomes the new working version.
4. Check in the component to publish the restored version.

## Check Out and Check In

The check-out/check-in mechanism prevents concurrent editing of Design Components. When a component is checked out, other users cannot edit it until it is checked back in.

## Checking Out a Design Component

A Design Component is checked out automatically when it is created or opened for editing. It can also be checked out manually.

To manually check out a component:

1. Right-click the Design Component and select **Check Out**, or select the component and click **Check Out** on the ribbon.

A **red checkmark icon** appears on the component in the tree view, indicating it is checked out. Other users can see that the component is checked out and by whom, but they cannot edit it.

## Checking In a Design Component

When editing is complete, the Design Component must be checked in to make the changes available. Three check-in options are available:

| Option | Description |
| --- | --- |
| **Check In and Publish Now** | Checks in the component and immediately publishes it as the current active version. This is the most common option. |
| **Check In and Publish On** | Checks in the component and schedules it for publication at a specified future date and time. The component is not available for use until the deferred publication date. |
| **Check In as draft copy** | Checks in the component as a draft version. It is recorded in the version history but is not published or available for use. A **pencil icon** appears on draft versions in the version list. |

During check-in, a **Version Comment** field is available. Enter a comment describing the changes made in this version. Version comments appear in the version history and are valuable for tracking the purpose of each revision.

> **NOTE:** If Design Component Approval is enabled on the folder, the check-in process routes the component for approval. The component is not published until it is approved. See the Design Approval section for details.

## Discarding a Checked Out Design Component

A checked-out component can be discarded to abandon all changes made since the check-out. The component reverts to the last checked-in version.

The following users can discard a checked-out component:

- The user who checked it out.
- An administrator with appropriate permissions.

A confirmation dialog is presented before the discard operation is executed.

## Checking Out a Previous Version

To check out a previous version of a Design Component:

1. Open the **Version History** for the component.
2. Select the previous version from the list.
3. Click **Check Out**.

The selected version becomes the new working version. When it is subsequently checked in, it is recorded as a new version in the history (not as a replacement of the original version entry).

## Copying a Previous Version

A previous version can be copied to create a new, standalone Design Component.

To copy a previous version:

1. Open the **Version History** for the component.
2. Select the version to copy.
3. Click **Copy**.

The copy is created as a new Design Component with the prefix "Copy of" prepended to the original name. The copied component has **Draft** status and must be checked in and published independently.

## Versions Tab Options

The Versions tab in the Version History dialog provides the following actions for each version:

| Action | Description |
| --- | --- |
| **Publish** | Publish the selected version, making it the current active version. |
| **Run** | Run the selected version to generate a document using that version's configuration. |
| **View** | Open the selected version in read-only mode for inspection. |
| **Delete** | Delete the selected version from the version history. The currently published version cannot be deleted. |
| **Relationships** | View the relationship information for the selected version. |
| **Approvals** | View the approval history for the selected version (available when Approval is enabled). |
| **Compare** | Compare two versions to identify differences. Select two versions using **Ctrl+click**, then click Compare. A comparison report highlights the changes between the selected versions. |
