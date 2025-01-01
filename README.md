# Enhanced Lead Management

Enhanced Lead Management is a Salesforce application that automates lead scoring, assignment, and notifications. Built with Salesforce Triggers, Apex Classes, and Lightning Web Components (LWC), this project optimizes lead handling to enhance sales productivity.

---

## Features

- **Lead Scoring**: Automatically calculates a lead score based on predefined criteria like industry, annual revenue, and lead source.
- **Automated Lead Assignment**: Assigns leads to the appropriate sales representative or queue based on their score.
- **Email Notifications**: Sends real-time email notifications to sales representatives when leads are assigned.
- **Customizable UI**: Provides a Lightning Web Component for capturing and managing leads with a user-friendly interface.
- **Comprehensive Unit Testing**: Includes robust test classes to ensure functionality and maintain high code coverage.

---

## Components

### **Triggers**
- **`LeadScoringTrigger`**: Handles lead scoring, assignment, and email notifications.

### **Apex Classes**
- **`LeadCaptureFormController`**: Handles backend logic for the Lightning Web Component.
- **`LeadNotificationHelper`**: Manages email notifications for assigned leads.
- **`LeadNotificationHelperTest`**: Unit test class for `LeadNotificationHelper`.
- **`LeadScoringTriggerTest`**: Unit test class for `LeadScoringTrigger`.

### **Lightning Web Component**
- **Lead Capture Form**:
  - Collects lead details (name, company, industry, annual revenue, etc.).
  - Provides a clean and intuitive interface for data entry.

---

## How It Works

### **1. Lead Creation**
- Users can create leads using the Lightning Web Component or directly in Salesforce.

### **2. Lead Scoring**
The trigger calculates a score based on:
- **Industry**:
  - Technology: +10 points
  - Retail: +5 points
  - Others: +1 point
- **Annual Revenue**:
  - >1,000,000: +10 points
  - 500,000 - 1,000,000: +5 points
  - <500,000: +1 point
- **Lead Source**:
  - Web: +10 points
  - Referral: +5 points
  - Others: +2 points

### **3. Lead Assignment**
- **Score ≥ 25**: Assigned to senior sales representatives.
- **Score 15 - 24**: Assigned to junior sales representatives.
- **Score < 15**: Assigned to a low-priority queue.

### **4. Email Notifications**
- When a lead is assigned, email notifications are sent to the appropriate sales representative.

---

## Installation

### **Prerequisites**
- [Salesforce CLI](https://developer.salesforce.com/tools/sfdxcli) installed.
- Access to a Salesforce Developer Org or Sandbox.
- [Git](https://git-scm.com/) installed.

### **Steps**
1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd enhanced-lead-management
2. **Authenticate with your Salesforce org**:
    ```bash
    sf login org
3. **Deploy the code to Salesforce**:
    ```bash
    sf project deploy start --target-org <your-org-alias>
4. **Run unit tests to verify the deployment**:
    ```bash
    sf apex run test --target-org <your-org-alias> --result-format human --code-coverage --synchronous

## Usage

1. **Navigate to the Lead Capture Form** in your Salesforce application.
2. **Enter lead details** such as:
   - Name
   - Company
   - Industry
   - Annual Revenue
   - Priority
3. **Click Submit** to create the lead.
4. The lead's **score and assigned owner** will be displayed on the **Lead Detail page**.
5. Assigned sales representatives will **receive email notifications**.

---

## Testing

### Unit Tests
- **`LeadScoringTriggerTest`**: Covers lead scoring and assignment logic.
- **`LeadNotificationHelperTest`**: Validates email notification functionality.

### Run All Tests
Use the following command:
```bash
sf apex run test --target-org <your-org-alias> --result-format human --code-coverage --synchronous

## Contributing

Contributions are welcome! Follow these steps:

1. **Fork the repository**.
2. **Create a new branch** for your feature:
   ```bash
   git checkout -b feature/your-feature-name
3. **Commit your changes**:
    ```bash
    git commit -m "Add new feature or fix bug"
4. **Push your changes**:
    ```bash
    git push origin feature/your-feature-name
5. **Open a pull request** on GitHub: