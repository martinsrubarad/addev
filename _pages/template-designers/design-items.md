---
title: "Design Items"
permalink: /template-designers/design-items/
layout: single
toc: true
toc_sticky: true
---

Design Items are the automation elements within Templates and Snippets. They control how data is collected, validated, repeated, visualized, and conditionally applied during document generation.

## Active Fields

Active Fields contain calculated, prompted-for, or sourced data. They can perform validation at several levels and may appear in the Document Wizard and/or as placeholders in the Template or Active Snippet.

**Examples:** Name, Address, "Is there a separate postal address?"

## Groups

Active Fields may belong to Groups for presentation and control purposes. Groups organize related Active Fields together in the Document Wizard.

**Example:** A "Customer Details" Group would contain the Active Fields for Name and Address.

## Repeating Item Groups

Active Fields may belong to Repeating Item Groups to represent multiple instances of similar data. This allows users to enter a variable number of related records during document generation.

**Example:** List multiple items purchased, at what price for each, to give a grand total.

## Charts

Charts graphically represent data from Repeating Item Groups, providing visual summaries within generated documents.

**Example:** Chart items purchased.

## Snippet Links

Snippet Links provide the connection between the Template and the Snippet to facilitate the use of Snippets in document generation. They allow Templates to pull in reusable content at the point of document creation.

**Example:** Use a Snippet Link in ActiveDocs WorkCenter Client to include the most up-to-date Confidentiality Statement in the document.

## Rules

Rules use Active Field values to dynamically control the use of Active Fields, Groups, Repeating Item Groups, Snippet Links, and the content of Templates or Active Snippets.

Rules are a powerful mechanism for conditional logic — they determine what appears in the Document Wizard, which content is included in the document, and how data flows through the template.

**Example:** "Is there a separate postal address?" may determine what the Document Wizard prompts for, and will determine the content of the document.
