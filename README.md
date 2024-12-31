Enhanced Lead Management Project

Overview

This project is an Enhanced Lead Management Application built on Salesforce. It includes functionality for capturing, scoring, assigning, and notifying sales representatives about new leads. The project is implemented using Apex, Lightning Web Components (LWC), and declarative Salesforce features.

Features

Lead Capture Form (LWC):

Allows users to submit new leads via a user-friendly form.

Validates required fields such as Last Name, Company, and Priority.

Submits lead data to Salesforce using Apex.

Lead Scoring and Assignment:

Automatically scores leads based on Industry, Annual Revenue, and Lead Source.

Assigns leads to appropriate sales reps or queues based on their scores.

Notifications:

Sends email notifications to lead owners when leads are assigned to them.

Apex Unit Tests:

Ensures the functionality of lead scoring, assignment, and notifications with over 75% code coverage.

Components

Apex Classes

LeadCaptureFormController: Handles lead creation from the Lead Capture Form.

LeadNotificationHelper: Sends email notifications to lead owners when leads are assigned.

LeadNotificationHelperTest: Unit test for LeadNotificationHelper to validate email notification logic.

LeadScoringTriggerTest: Unit test for the LeadScoringTrigger to validate lead scoring and assignment.

Apex Trigger

LeadScoringTrigger:

Automatically scores leads based on predefined rules.

Assigns leads to appropriate owners based on their scores.

Integrates with LeadNotificationHelper to notify users of new assignments.

Lightning Web Component (LWC)

LeadCaptureForm:

Captures lead details such as Name, Company, Industry, Revenue, and Priority.

Validates required fields and handles user input dynamically.

Submits data to Salesforce using Apex.

Installation

Clone the Repository:

git clone <REPOSITORY_URL>
cd Enhanced-Lead-Management

Authorize a Salesforce Org:

sf org login web --alias MyOrgAlias

Deploy Metadata to the Org:

sf deploy metadata --source-dir force-app --target-org MyOrgAlias

Run Apex Tests:

sf apex run test --target-org MyOrgAlias --result-format human --code-coverage

Usage

Navigate to the Salesforce app where the Lead Capture Form is deployed.

Fill in the form fields (Last Name, Company, and Priority are required).

Submit the form to create a new lead.

Leads are automatically scored and assigned to sales reps or queues.

Assigned sales reps receive email notifications about their new leads.