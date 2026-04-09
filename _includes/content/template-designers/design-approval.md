Design Component Approval provides a review and authorization process for Templates, Template Sets, and Snippets before they are published and made available for use. Approval is configured per folder and operates at the top level of the folder hierarchy.

## Understanding Design Component Approval

Design Component Approval ensures that changes to critical Design Components are reviewed and authorized before publication. Key characteristics of the approval system:

- Approval is configured **per folder**. Each folder can independently enable or disable the approval requirement.
- Approval applies to **top-level folders only**. Subfolders inherit the approval setting from their parent folder.
- Approval is limited to **Templates**, **Template Sets**, and **Snippets**. Other Design Component types (Design Item Sets, Data Views, Workflows) do not participate in the approval process.
- When approval is enabled on a folder, any component checked into that folder enters a **Pending Approval** state rather than being published immediately.
- Approval interacts with **Version Control**. A component must be checked in before it can be submitted for approval. Once approved, the component is published. If declined, the component remains in its pre-check-in state and can be edited and resubmitted.

## The Approval Group in the Home Ribbon

The Home Ribbon in ActiveDocs WorkCenter Client includes an Approval group with tools for managing the approval process. The available items depend on the user's role:

**Designer ribbon items:**
- Submit components for approval
- View the status of submitted components
- View approval history

**Approver ribbon items:**
- View components pending approval
- Approve or decline components
- View approval history
- Clear approval notifications

Additional ribbon items:

| Item | Description |
| --- | --- |
| **View Approval History** | Opens the Approvals History dialog, displaying the complete approval history for the current folder or selected component. |
| **Clear Approval Notification** | Clears the approval notification flag from the ribbon, indicating that pending approvals have been acknowledged. |

## Approval Notification Flag

ActiveDocs checks for pending approval items approximately every **5 minutes**. When items are pending approval, a notification flag appears on the Approval group in the Home Ribbon.

The flag indicates that one or more Design Components are awaiting approval action. The notification persists until all pending items are processed or the flag is manually cleared using the **Clear Approval Notification** button.

## Approving Design Components

When Design Components are submitted for approval, approvers review and authorize or decline them through the approval workflow.

To approve or decline a component:

1. Click the **Approval** notification in the Home Ribbon, or navigate to the Approval group and click the pending approvals button.
2. The **Pending Approval** dialog opens, listing all components awaiting approval.
3. Select a component and click **Approve** or **Decline**.
4. The **Edit Approval** dialog opens with the following options:

| Option | Description |
| --- | --- |
| **Approved** | Marks the component as approved. The component is published and becomes available for use. |
| **Declined** | Marks the component as declined. The component is not published and returns to the designer for revision. |
| **Pending** | Retains the component in its pending state without making a decision. |

5. Enter a **Comment** describing the reason for the decision. A comment is required when declining a component.
6. Click **OK** to apply the decision.

### Right-Click Menu Options

Right-clicking a component in the Pending Approval dialog provides the following options:

| Option | Description |
| --- | --- |
| **Review Approvals** | Opens the approval details for the selected component, showing the current approval status and history. |
| **Reassign Approver** | Reassigns the approval responsibility to a different approver. |
| **Approve/Decline** | Opens the Edit Approval dialog to approve or decline the component. |
| **Properties** | Opens the component's properties dialog. |
| **Compare** | Compares the pending version with a previous version to identify changes. Select two versions using **Ctrl+click**. |
| **Open Containing Folder** | Navigates to the folder where the component is stored in the WorkCenter Client tree. |
| **Run** | Runs the pending version of the component to preview the generated output. |

## Approval History

The Approvals History dialog provides a comprehensive record of all approval actions taken on Design Components.

To open the Approvals History:

1. Click **View Approval History** in the Approval group on the Home Ribbon.
2. The **Approvals History** dialog opens, displaying approval records.

### Approvals Ribbon

The Approvals History dialog includes a ribbon with the following tools:

| Tool | Description |
| --- | --- |
| **View Approvals** | Displays the approval details for the selected record. |
| **Properties** | Opens the properties of the Design Component associated with the selected approval record. |
| **Approval Status Filter** | Filters the displayed records by approval status (Approved, Declined, Pending, or All). |
| **Show Approvals From** | Filters the displayed records by date range (e.g., Today, This Week, This Month, All). |
| **Show Only My Approvals** | When enabled, displays only approval records associated with the current user (as approver or submitter). |

## Templates and Snippets Sent for Approval

Designers can track the status of components they have submitted for approval.

The **For Review** dialog displays components that have been submitted and are awaiting or have received approval decisions. This dialog provides:

- **Approval Details column** — Shows the current approval status (Pending, Approved, or Declined) and any comments from the approver.

### Right-Click Menu Options

Right-clicking a component in the For Review dialog provides the following options:

| Option | Description |
| --- | --- |
| **Review Approvals** | Opens the approval details for the selected component. |
| **Properties** | Opens the component's properties dialog. |
| **Compare** | Compares the submitted version with a previous version. |
| **Open Containing Folder** | Navigates to the folder where the component is stored. |
| **Run** | Runs the submitted version to preview the generated output. |
