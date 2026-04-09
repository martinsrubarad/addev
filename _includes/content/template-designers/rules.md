Rules provide conditional logic within Templates and Active Snippets. They evaluate conditions based on Active Field values and control both the behavior of Design Items in the Document Wizard and the inclusion or formatting of content in the generated document.

## What Are Rules?

A Rule is a Design Item that defines one or more conditions. When conditions are evaluated, the Rule's result (true or false) determines what happens. Rules operate at two levels:

- **Design Item level** — A Rule can control whether an Active Field, Group, Repeating Item Group, Snippet Link, or Chart appears in the Document Wizard. When a Rule's conditions are not met, the associated Design Items can be hidden from the user.
- **Content level** — A Rule can control whether a section of Template or Active Snippet content is included in the generated document. Rule Start and Rule End markers in the Template body define the content region governed by the Rule.

Rules enable dynamic documents that adapt to user input. For example, a Rule can show additional address fields only when the user indicates a separate postal address is required, or include a confidentiality clause only when a document is marked as sensitive.

## Creating a Rule

Rules are created in the Design Items dialog using the Build Rule dialog.

To create a Rule:

1. Open the **Design Items** dialog.
2. In the Navigation Pane, select the Group or Repeating Item Group where the Rule should reside.
3. Right-click and select **New Rule**, or click **New Rule** on the Home ribbon.
4. Enter a name for the Rule and press **Enter**.
5. The **Build Rule** dialog opens, where conditions are defined.

### Defining Conditions

Each condition in a Rule compares a Design Item's value against a specified value using an operator.

To add a condition:

1. Click **Add** in the Build Rule dialog to insert a new condition row.
2. Click the **Design Item** link in the condition row to select the Active Field whose value is evaluated.
3. Click the **Value** link to specify the comparison value. The value can be:
   - A fixed literal value (typed directly).
   - A value selected from the Active Field's value list (if one is defined).
4. Select the comparison operator. Available operators depend on the field type and include: Equals, Not Equals, Greater Than, Less Than, Greater Than or Equal, Less Than or Equal, Contains, Starts With, Ends With, Is Blank, Is Not Blank.

### Multiple Conditions with And/Or

Rules can contain multiple conditions combined with logical joiners:

- **And** — All conditions must be true for the Rule to evaluate as true.
- **Or** — At least one condition must be true for the Rule to evaluate as true.

To add multiple conditions:

1. Click **Add** to insert additional condition rows.
2. Set the **Joiner** for each row to **And** or **Or** as needed.

### Parentheses for Grouping

When a Rule combines both **And** and **Or** joiners, parentheses control the evaluation order. Without parentheses, conditions are evaluated strictly left to right, which may not produce the intended logic.

To add parentheses:

1. Click the parentheses controls in the Build Rule dialog to open or close a grouping bracket before or after a condition row.
2. Grouped conditions are evaluated together first, and their combined result is then joined with the remaining conditions.

**Example:** To express "Field A equals X, and either Field B equals Y or Field C equals Z":

- Row 1: Field A Equals X — Joiner: And
- Row 2: ( Field B Equals Y — Joiner: Or
- Row 3: Field C Equals Z )

The parentheses ensure that B or C is evaluated as a group before being combined with the A condition.

### Nested Rule Conditions

A Rule can reference the result of another Rule as a condition. This allows complex logic to be broken into smaller, reusable Rules.

To nest a Rule:

1. Click **Add** in the Build Rule dialog.
2. In the condition row, instead of selecting an Active Field, select a Rule from the Design Item list.
3. Set the condition to **Conditions of Rule are met** or **Conditions of Rule are not met**.

This evaluates the referenced Rule's conditions and uses that result as part of the current Rule's logic.

> **TIP:** Nesting Rules keeps individual Rules simple and readable. Rather than building one Rule with many conditions, create smaller Rules for distinct logical checks and combine them with nested references.

### Removing Conditions

To remove a condition from the Rule:

1. Select the condition row in the Build Rule dialog.
2. Click **Remove** to delete the selected condition.

Multiple condition rows can be selected simultaneously (using Ctrl+click or Shift+click) and removed in one operation.

## Testing a Rule

Rules can be tested from within the Design Items dialog to verify their logic before deploying the Template.

To test a Rule:

1. Select the Rule in the Design Items Navigation Pane.
2. Click **Test** to open the Test dialog.
3. The Test dialog displays all Active Fields referenced by the Rule's conditions, along with their current test values.
4. Click **Edit Value** next to any Active Field to change its test value.
5. Set the test values to simulate different user inputs.
6. The **Result** section displays whether the Rule evaluates to **True** or **False** based on the current test values.
7. Adjust test values and observe the result to verify the Rule behaves as expected under various scenarios.

> **TIP:** Test Rules systematically by checking boundary cases — for example, test with blank values, values that match exactly, and values that should not match. This helps catch logic errors before deployment.

## Applying a Rule

After creating a Rule, it must be applied to control specific behavior. The Apply Rule dialog provides three options for how the Rule's result is used.

To apply a Rule:

1. Insert **Rule Start** and **Rule End** markers in the Template body to define the content region governed by the Rule, or associate the Rule with a Design Item in the Design Items dialog.
2. Select the Rule and open the **Apply Rule** dialog (accessible from the Rule's properties or the context menu).
3. Choose one of the following application options:

| Option | Description |
| --- | --- |
| **Include** | When the Rule's conditions are met, the controlled content or Design Item is included in the document or shown in the Document Wizard. When conditions are not met, the content is excluded or the Design Item is hidden. |
| **Exclude** | When the Rule's conditions are met, the controlled content or Design Item is excluded from the document or hidden in the Document Wizard. When conditions are not met, the content is included or the Design Item is shown. This is the inverse of Include. |
| **Apply Formatting** | When the Rule's conditions are met, specific formatting is applied to the controlled content region. |

### Apply Formatting Sub-Options

When **Apply Formatting** is selected, additional options become available:

| Sub-Option | Description |
| --- | --- |
| **Remove blank paragraphs** | Removes any empty paragraphs within the ruled content region. This prevents blank lines from appearing in the document when conditional content is excluded or when Active Fields resolve to empty values. |
| **Merge table rows** | When the ruled content spans table rows, this option merges adjacent rows to eliminate empty rows that would otherwise remain when conditional content is excluded. |

> **NOTE:** The Apply Formatting option with Remove blank paragraphs is particularly useful in Templates that contain many conditional sections. It produces clean output without manual adjustment of spacing.

4. Click **OK** to apply the Rule configuration.

## Tips for Troubleshooting

### Miscellaneous Questions Appearing in the Document Wizard

If a "Miscellaneous Questions" section appears in the Document Wizard, it typically indicates one of the following:

- An Active Field is not assigned to any Group. Ungrouped Active Fields are collected into the Miscellaneous Questions section by default.
- A Group has been deleted but its Active Fields were not reassigned.
- An Active Field was imported without its parent Group.

To resolve this, open the Design Items dialog, locate the ungrouped Active Fields, and move them into the appropriate Group using the **Move to Group** option.

### Rule Not Working as Expected

If a Rule does not produce the expected result, check the following:

1. **Verify the condition values.** Ensure that the comparison value in the Rule condition matches the actual value of the Active Field exactly, including case, whitespace, and data type.
2. **Check the joiner logic.** Confirm that And/Or joiners are set correctly. A common mistake is using And when Or is intended, or vice versa.
3. **Check parentheses.** If the Rule uses both And and Or joiners, ensure parentheses are placed correctly to group conditions as intended.
4. **Test the Rule.** Use the Test dialog to simulate values and observe the result. This isolates whether the issue is in the Rule logic or in the marker placement.
5. **Verify marker placement.** Ensure that Rule Start and Rule End markers are positioned correctly around the intended content. Misplaced markers can cause unexpected content to be included or excluded.
6. **Check for nested Rule dependencies.** If the Rule references another Rule, verify that the referenced Rule evaluates correctly on its own.
7. **Confirm the application option.** Verify whether the Rule is set to Include, Exclude, or Apply Formatting. An Include Rule hides content when conditions are not met; an Exclude Rule hides content when conditions are met.
8. **Check Active Field values.** Ensure the Active Fields referenced in the Rule are receiving the expected values in the Document Wizard. An Active Field with a blank value or an unexpected default can cause the Rule to evaluate incorrectly.

## Best Practices

The following best practices help maintain reliable, maintainable Rules across Templates and Design Item Sets.

- **Name Rules descriptively.** Use names that describe the condition being checked, not just the outcome. For example, "Customer has separate postal address" is clearer than "Rule 1" or "Show address fields."
- **Keep Rules simple.** Prefer multiple simple Rules over one complex Rule with many conditions. Use nested Rule references to combine simple Rules when needed.
- **Use parentheses explicitly.** When combining And and Or joiners, always use parentheses to make the evaluation order clear, even when the default order would produce the correct result. This prevents errors when conditions are added or reordered later.
- **Test Rules thoroughly.** Use the Test dialog to verify Rule behavior with a range of input values, including edge cases such as blank fields, minimum/maximum values, and unexpected inputs.
- **Document Rule intent.** Use the Rule's description field (if available) or naming conventions to record what the Rule is designed to do. This helps other designers understand and maintain the Template.
- **Avoid circular references.** Do not create Rules that reference each other in a loop (Rule A references Rule B, which references Rule A). Circular references produce unpredictable behavior.
- **Place markers carefully.** Ensure Rule Start and Rule End markers encompass exactly the content that should be controlled. Avoid placing markers inside table cells if the intent is to control entire rows, and vice versa.
- **Use Exclude sparingly.** Include is generally easier to understand and troubleshoot than Exclude. Prefer Include rules unless the Exclude logic is clearly simpler for the scenario.
- **Centralize shared Rules in Design Item Sets.** When the same Rule logic applies across multiple Templates, define the Rule in a Design Item Set and link it rather than duplicating the Rule in each Template.
- **Review Rules after importing Design Items.** When Design Items are imported from another component, verify that any Rules referencing those items still have valid condition references and expected values.
