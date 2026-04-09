The Design Items Dialog provides a comprehensive interface for creating, organizing, and managing all Design Items (Groups, Active Fields, Repeating Item Groups, Charts, Snippet Links, and Rules) within a Template or Active Snippet.

To open the Design Items Dialog, click **Design Items** on the ActiveDocs Ribbon, or press the assigned shortcut key.

## Navigation Pane

The left side of the Design Items Dialog displays the Navigation Pane, which shows a tree view of all Design Items in the Template. The tree is organized hierarchically:

- **Groups** appear as top-level nodes.
- **Active Fields** appear under their parent Group.
- **Repeating Item Groups** appear at the group level and contain their own Active Fields.
- **Rules**, **Snippet Links**, and **Charts** appear under the Groups or Repeating Item Groups to which they belong.

Select any Design Item in the Navigation Pane to view and edit its properties in the Properties Pane on the right.

> **TIP:** Use the tree structure in the Navigation Pane to understand the organization of your Template's automation at a glance. The hierarchy reflects how items appear in the Document Wizard.

## Properties Pane

The right side of the Design Items Dialog displays the Properties Pane. When a Design Item is selected in the Navigation Pane, the Properties Pane shows all configurable properties for that item across one or more tabs (e.g., General, Validation, Value List).

Changes made in the Properties Pane are applied when you click **OK** or **Apply**.

## Context-Sensitive Shortcut Menu

Right-clicking a Design Item in the Navigation Pane opens a context-sensitive shortcut menu with the following options:

| Option | Description |
| --- | --- |
| New Group | Creates a new Active Field Group at the selected level. |
| New Active Field | Creates a new Active Field within the selected Group. |
| New Repeating Item Group | Creates a new Repeating Item Group at the selected level. |
| New Rule | Creates a new Rule within the selected Group or Repeating Item Group. |
| New Snippet Link | Creates a new Snippet Link within the selected Group or Repeating Item Group. |
| New Chart | Creates a new Chart within the selected Group or Repeating Item Group. |
| Insert into Template | Inserts the selected Design Item as a marker at the current cursor position in the Template. |
| Delete | Deletes the selected Design Item. If the item has markers in the Template, they are also removed. |
| Rename | Renames the selected Design Item. |
| Move Up | Moves the selected Design Item up in the tree order. This affects the order in the Document Wizard. |
| Move Down | Moves the selected Design Item down in the tree order. |
| Move to Group | Moves the selected Design Item to a different Group. |
| Copy | Copies the selected Design Item. |
| Paste | Pastes a previously copied Design Item. |
| Expand All | Expands all nodes in the Navigation Pane. |
| Collapse All | Collapses all nodes in the Navigation Pane. |

> **NOTE:** The available options in the shortcut menu depend on the type and position of the selected Design Item. Not all options appear for every item type.

## Design Items Dialog Home Ribbon

The Design Items Dialog includes its own Home ribbon with tools for managing Design Items.

| Tool | Definition |
| --- | --- |
| New Group | Creates a new Active Field Group. |
| New Active Field | Creates a new Active Field within the currently selected Group. |
| New Repeating Item Group | Creates a new Repeating Item Group. |
| New Rule | Creates a new Rule within the currently selected Group or Repeating Item Group. |
| New Snippet Link | Creates a new Snippet Link within the currently selected Group or Repeating Item Group. |
| New Chart | Creates a new Chart within the currently selected Group or Repeating Item Group. |
| Delete | Deletes the selected Design Item and any associated markers. |
| Move Up | Moves the selected Design Item up in the display order. |
| Move Down | Moves the selected Design Item down in the display order. |
| Move to Group | Moves the selected Design Item to a different Group. |
| Insert into Template | Inserts the selected Design Item as a marker at the current cursor position. |
| Insert Multiple Times | Inserts the selected Active Field marker multiple times at designated cursor positions. |
| Find and Replace | Searches for and optionally replaces Design Items across the Template. |
| Link Design Item Set | Links an external Design Item Set to the Template, making its items available. |
| Unlink Design Item Set | Removes the link to a Design Item Set. |

> **TIP:** The **Insert into Template** and **Insert Multiple Times** tools are particularly useful when you have already created your Design Items and need to place them throughout the Template body.
