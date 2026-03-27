---
title: "Design Components"
permalink: /template-designers/design-components/
layout: single
toc: true
toc_sticky: true
---

Design Components are the building blocks for document creation and document automation in ActiveDocs. They include Templates, Template Sets, Snippets, Data Views, Design Item Sets, and Workflows.

## Templates

Templates determine the basic structure of documents. They contain the automation and logic that control how documents are generated.

**Examples:** Insurance Letter, Application Form, Direct Debits Form.

## Template Sets

Template Sets join two or more Templates to generate a single merged document or multiple documents. They can include definitions for static "attachment" documents. The Document Wizard optimizes common questions across the Templates in the set.

**Example:** The insurance letter, application form, and direct debits form can be grouped together in a set to create one document. The Template Set can control whether the direct debits form needs to be included.

## Snippets

Snippets contain reusable text, tables, graphics, and other content for use in document generation. There are two types:

- **Static Snippets** — Contain no automation. They provide fixed, reusable content.
- **Active Snippets** — Contain automation elements (Design Items) that allow dynamic content.

**Examples:** A Confidentiality Statement appearing at the bottom of all company documents; a Company Logo.

## Design Item Sets

Design Item Sets contain reusable collections of Groups, Active Fields, Repeating Item Groups, Charts, Snippet Links, and Rules. They reduce maintenance and promote consistency across your Templates and Snippets.

**Example:** Create a Design Item Set to store all Groups, Active Fields, and Rules used across the insurance letter, application form, and direct debits form.

## Data Views

Data Views link Templates and Active Snippets to data in structured sources like spreadsheets, databases, and web services.

**Example:** A Data View can link any of the Templates to Customer details stored in the company database.

## Workflows

Workflows control the processing of documents through drafting, approval, and finalization. They may define:

- Draft and final watermarks
- Document properties
- Document file formats
- Storage locations
- Delivery methods
- Retention policies

**Example:** Set a Workflow to approve a draft document, and on finalize convert to PDF and send to a SharePoint library.
