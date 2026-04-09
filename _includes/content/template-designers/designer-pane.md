The Designer Pane provides a visual overview of all ActiveDocs markers in a Template, along with tools for navigating, inspecting, and managing markers. It operates in three modes and offers several utility functions for working with Template content.

To open the Designer Pane, click **Designer Pane** on the ActiveDocs Ribbon. The pane appears as a side panel in Microsoft Word.

## Marker Icons

The Designer Pane displays markers using distinct icons to identify each type of Design Item.

| Icon | Marker Type | Description |
| --- | --- | --- |
| **G** | Group | An Active Field Group marker. |
| **AF** | Active Field | An Active Field marker. |
| **RS** | Rule Start | The beginning of a Rule-controlled section. |
| **RE** | Rule End | The end of a Rule-controlled section. |
| **RIGS** | Repeating Item Group Start | The beginning of a Repeating Item Group section. |
| **RIGE** | Repeating Item Group End | The end of a Repeating Item Group section. |
| **SL** | Snippet Link | A Snippet Link marker. |
| **CH** | Chart | A Chart marker. |

> **TIP:** Use the marker icons in the Designer Pane to quickly identify the type and location of each Design Item in the Template without scrolling through the document.

## Document Mode

Document Mode is the default mode when the Designer Pane is first opened. In this mode, the Designer Pane displays a read-only list of all markers in the Template in the order they appear in the document.

In Document Mode:

- The list shows the marker type icon, the Design Item name, and its position in the document.
- Clicking a marker in the list navigates to (selects) the corresponding marker in the Template body.
- The list updates automatically when markers are added, removed, or reordered in the Template.

Document Mode is useful for reviewing the overall structure of a Template's automation and for navigating to specific markers.

## Selection Mode

Selection Mode activates when a marker is selected in the Template body (either by clicking on it or by using the **Select Marker** tool on the ActiveDocs Ribbon).

In Selection Mode:

- The Designer Pane highlights the selected marker and displays its properties.
- The properties shown include the marker type, the Design Item name, and key configuration details.
- From Selection Mode, you can access the full properties dialog by double-clicking the marker entry or clicking **Marker Properties**.

Selection Mode provides a quick way to inspect a marker's configuration without opening the full Design Items Dialog.

## Designer Mode

Designer Mode transforms the Designer Pane into an insertion tool. In this mode, the Navigation Pane tree from the Design Items Dialog is displayed directly in the Designer Pane, allowing you to insert markers into the Template without opening the Design Items Dialog.

To activate Designer Mode, click the **Designer Mode** button in the Designer Pane toolbar.

### Inserting from Designer Mode

1. Switch to **Designer Mode** in the Designer Pane.
2. Place the cursor at the desired location in the Template body.
3. Click the Design Item (Active Field, Group, Rule, etc.) in the Designer Pane tree.
4. The marker is inserted at the cursor position.

> **TIP:** Designer Mode is the fastest way to insert multiple different markers in sequence. Keep the Designer Pane in Designer Mode while building out the Template body, clicking each Design Item as you reach its location in the document.

## Go to Marker

The **Go to Marker** function navigates to a specific marker in the Template by name. This is particularly useful in large Templates with many markers.

To use Go to Marker:

1. Click **Go to Marker** on the ActiveDocs Ribbon, or use the Go to Marker tool in the Designer Pane.
2. Select the Design Item from the list or type its name.
3. The cursor moves to the corresponding marker in the Template and selects it.

## Marker Properties

The **Marker Properties** function displays the properties of the currently selected marker. This provides a quick way to review or modify a Design Item's configuration from within the Template.

To view marker properties:

1. Select a marker in the Template (click on it, or use **Select Marker** on the ActiveDocs Ribbon).
2. Click **Marker Properties** on the ActiveDocs Ribbon, or double-click the marker in the Designer Pane.
3. The properties dialog for the selected Design Item opens, showing the relevant tabs (General, Validation, Value List, etc.).

## Convert Marker to Text

The **Convert Marker to Text** function removes the ActiveDocs automation from a selected marker and replaces it with plain text. The text that remains is the Design Item name or the marker's display text.

To convert a marker to text:

1. Select the marker in the Template.
2. Click **Convert Marker to Text** on the ActiveDocs Ribbon.
3. The marker is replaced with its text representation. The associated Design Item remains in the Design Items Dialog but is no longer linked to that location in the Template.

> **NOTE:** Converting a marker to text does not delete the Design Item itself. The Design Item can still be inserted again at the same or a different location. This function only removes the marker (the placeholder) from the Template body.

## Insert Paragraph Before / After

The **Insert Paragraph Before** and **Insert Paragraph After** functions add a new paragraph immediately before or after the selected marker. These are useful when a marker occupies an entire paragraph and you need to add content adjacent to it without disrupting the marker.

To insert a paragraph:

1. Select the marker in the Template.
2. Click **Insert Paragraph Before** or **Insert Paragraph After** on the ActiveDocs Ribbon.
3. A new empty paragraph is created at the specified position.

> **TIP:** Use these functions instead of pressing Enter directly before or after a marker, as pressing Enter may inadvertently split the marker or its associated formatting.

## Search Function

The Designer Pane includes a search function for locating markers by name within the Template.

To search:

1. Enter the search term in the search box at the top of the Designer Pane.
2. The list filters to show only markers whose names match the search term.
3. Click a result to navigate to that marker in the Template.

The search function supports partial matching, so entering part of a Design Item name will return all markers containing that text.

## Refresh Options

The **Refresh** function updates the Designer Pane and the Template to reflect any external changes. This is necessary when:

- A linked Design Item Set has been modified outside of the current Template.
- A linked Snippet has been updated.
- Data View definitions have changed.

To refresh:

1. Click **Refresh** on the ActiveDocs Ribbon.
2. The Template reloads linked resources and the Designer Pane updates its marker list.

> **NOTE:** Refresh does not save the Template. It reloads external dependencies. Save the Template separately after refreshing if you want to retain the updated state.

## General Notes

### Red X Warnings

A red X icon next to a marker in the Designer Pane indicates a problem with that marker. Common causes include:

- The marker references a Design Item that has been deleted from the Design Items Dialog.
- The marker is orphaned (its parent Group or Repeating Item Group has been removed).
- A Rule Start marker exists without a corresponding Rule End marker, or vice versa.

Resolve red X warnings by inspecting the affected marker and either re-creating the missing Design Item, deleting the orphaned marker, or adding the missing paired marker.

### Header and Footer Behavior

ActiveDocs markers can be placed in the header and footer areas of a Word Template. However, the following considerations apply:

- Markers in headers and footers appear in the Designer Pane alongside body markers.
- Group markers should not be placed in headers or footers. Only Active Field, Rule, and Snippet Link markers are appropriate in these areas.
- Changes to header/footer markers require the header/footer area to be active (double-click the header/footer in Word) before selecting or editing the marker.

### Nested Repeating Item Group Options

Repeating Item Groups can be nested to represent hierarchical data. When working with nested Repeating Item Groups:

- The inner Repeating Item Group's Start and End markers must be entirely contained within the outer Repeating Item Group's Start and End markers.
- Active Fields in the inner group can reference Active Fields in the outer group for calculations and rules.
- The Designer Pane displays nested groups with indentation to reflect the hierarchy.
- Take care when reordering or moving nested groups to maintain the correct containment structure.

> **NOTE:** Deeply nested Repeating Item Groups increase the complexity of both the Template design and the Document Wizard experience. Limit nesting depth where possible to maintain usability.
