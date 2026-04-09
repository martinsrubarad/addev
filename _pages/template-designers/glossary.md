---
title: "Glossary of Terms"
permalink: /template-designers/glossary/
layout: single
sidebar:
  nav: "template-designers"
toc: true
toc_sticky: true
---

When using ActiveDocs software, it is important to become familiar with several common terms. This glossary will help you to get to know them, and allow you to refer back to them throughout the Designer training.

## Design Components and Design Items

| Term | Definition | Example |
| --- | --- | --- |
| Design Components | Design Components are the building blocks for document creation and document automation. | Templates and Template Sets used to produce documents; Data Views and Snippets that provide content; and Design Item Sets for sharing Design Item automation across Templates and Snippets. Workflows also qualify as Design Components. |
| Design Items | Design Items are the automation elements in Templates and Snippets. | Groups, Active Fields, Repeating Item Groups, Charts, Snippet Links, and Rules. |

## Design Components

| Term | Definition | Example |
| --- | --- | --- |
| Template | Templates determine the basic structure of documents. Templates contain automation and logic. | Insurance Letter, Application Form, Direct Debits Form. |
| Template Set | Template Sets join two or more Templates to generate a single merged document or multiple documents, and can include definitions for static 'attachment' documents. The Document Wizard optimizes common questions. | The insurance letter, application form, and direct debits form can be grouped together in a set to create one document; the Template Set can control if the direct debits form needs to be included. |
| Snippet | Snippets contain reusable text, tables, graphics, and other content for use in document generation. Snippets without automation are "Static". Snippets containing automation are "Active". | A Confidentiality Statement appearing at the bottom of all company documents; Company Logo. |
| Design Item Set | Design Item Sets contain reusable collections of Groups, Active Fields, Repeating Item Groups, Charts, Snippet Links, and Rules. Design Item Sets reduce maintenance and promote consistency. | Create a Design Item Set to store all Groups, Active Fields, and Rules used across the insurance letter, application form, and direct debits form. |
| Data View | Data Views link Templates and Active Snippets to data in structured sources like spreadsheets, databases, and web services. | A Data View can link any of the Templates to Customer details stored in the company database. |
| Workflow | Workflows control processing of documents through drafting, approval, and finalization. They may define draft and final watermarks / properties / document file formats / storage locations / delivery / retention. | Set a Workflow to approve a draft document, and on finalize convert to PDF and send to a SharePoint library. |

## Design Items

| Term | Definition | Example |
| --- | --- | --- |
| Active Field | Active Fields contain calculated, prompted-for, or sourced, data. Can perform validation at several levels. They may appear in the Document Wizard and/or as placeholders in the Template or Active Snippet. | Name, Address, "Is there a separate postal address?" |
| Group | Active Fields may belong to Groups for presentation and control purposes. | Customer Details Group would contain the Active Fields for Name and Address. |
| Repeating Item Group | Active Fields may belong to Repeating Item Groups to represent multiple instances of similar data. | List multiple items purchased, at what price for each, to give a grand total. |
| Chart | Charts graphically represent data from Repeating Item Groups. | Chart items purchased. |
| Snippet Link | Snippet Links provide the connection between the Template and the Snippet to facilitate the use of Snippets in document generation. | Uses a Snippet in ActiveDocs WorkCenter Client to include the most up-to-date Confidentiality Statement in the document. |
| Rule | Rules use Active Field values to dynamically control the use of Active Fields, Groups, Repeating Item Groups, Snippet Links, and the content of Templates or Active Snippets. | "Is there a separate postal address?" may determine what the Document Wizard prompts for, and will determine the content of the document. |

## ActiveDocs WorkCenter Client and Design Items Dialog

| Term | Definition | Example |
| --- | --- | --- |
| ActiveDocs WorkCenter Client | The desktop interface for creation, access, inspection, management, modification and deletion of Design Components. | Work with Templates, Template Sets, Snippets, Data Views, Design Item Sets, and Workflows. |
| Design Items | The add-in to Microsoft Word that provides an interface to manage Design Items in Templates and Active Snippets. | Create, organize, inspect, modify, and delete Groups, Active Fields, Repeating Item Groups, Snippet Links, and Rules. |

Refer to the Glossary of Terms in the product's Help files for further information.
