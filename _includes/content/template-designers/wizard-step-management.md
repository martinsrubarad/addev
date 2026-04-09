Wizard Step Management controls the order and grouping of Design Items as they appear to the user in the Document Wizard. By default, Design Items appear in the Document Wizard in the order they are listed in the Design Items dialog. Wizard Step Management provides tools to reorder steps, create sub-groups, and control how grouped items are displayed.

## Ordering in Wizard Step Management

By default, the Document Wizard presents Groups, Snippet Links, and Repeating Item Groups in the order they appear in the Design Items dialog Navigation Pane. Wizard Step Management allows this order to be customized without rearranging the Design Items dialog itself.

To customize the wizard step order:

1. Open the **Design Items** dialog from the ActiveDocs Ribbon.
2. Click **Wizard Step Management** on the Home ribbon.
3. Enable **Use custom step order** to override the default ordering.
4. Select a step in the list and use **Move Up** or **Move Down** to reposition it.
5. Repeat for all steps that require reordering.
6. Click **Save** to apply the custom order.

When **Use custom step order** is disabled, the Document Wizard reverts to the default order defined by the Design Items dialog.

> **TIP:** Custom step ordering is useful when the logical flow for the end user differs from the organizational structure of the Design Items. For example, a Template may group related fields together for design purposes, but the Document Wizard may need to present them in a different sequence to match the user's workflow.

## Sub-grouping in Wizard Step Management

Wizard Step Management supports sub-grouping, which nests related wizard steps under a parent step. Sub-grouping organizes complex Document Wizards into a hierarchical structure, making them easier for the user to navigate.

To create a sub-group:

1. In the Wizard Step Management dialog, select the step to be made into a child.
2. Click **Make Child** to indent the selected step under the step above it, creating a parent-child relationship.
3. To move a child step further into the hierarchy, click **Indent Child Group**.
4. To reverse the nesting and return a child step to the parent level, click **Make Parent**.
5. To remove all custom ordering and sub-grouping, click **Reset Steps**.

### Display Options

The **Display Options** dropdown controls how child steps within a sub-group are presented in the Document Wizard. The following options are available:

| Display Option | Description |
| --- | --- |
| **Show all items** | All child steps in the sub-group are displayed simultaneously on the same wizard page. |
| **Show one item at a time** | Only one child step is displayed at a time. The user navigates between child steps using Next and Back within the sub-group. |
| **Show as tabs** | Each child step appears as a separate tab within the parent step's wizard page. The user clicks tabs to switch between child steps. |
| **Show as accordion** | Child steps are displayed as expandable/collapsible accordion sections. The user expands a section to view and complete its fields. |
| **Show as a drop down** | Child steps are listed in a dropdown. The user selects a child step from the dropdown to display its fields. |

> **TIP:** When a Document Wizard contains many steps, sub-grouping with appropriate Display Options reduces the perceived complexity. For example, grouping address-related steps under a parent "Address Details" step with tab display keeps the wizard organized without requiring the user to navigate through many individual pages.

## Considerations for Wizard Step Management

The following considerations apply when configuring Wizard Step Management:

- **Dependent items** — When Design Items depend on each other (for example, a Rule that references an Active Field), ensure the step containing the referenced item appears before the step containing the dependent item in the wizard order. If the referenced item has not been presented to the user, the dependent item may not behave as expected.
- **Enable if not in Template for Snippet Links** — Snippet Links with the **Enable if not in Template** option enabled appear in the Document Wizard even if their markers are not inserted into the Template body. These Snippet Links are included in Wizard Step Management and can be reordered and sub-grouped like any other step. This is useful for Snippet Links that participate in Rules or conditional logic without having a fixed location in the Template content.
