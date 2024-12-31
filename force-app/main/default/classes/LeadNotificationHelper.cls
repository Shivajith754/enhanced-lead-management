public class LeadNotificationHelper {
    public static void sendNotifications(Map<Id, Lead> leadsToNotify) {
        // Fetch the email addresses of the owners for the leads
        Set<Id> ownerIds = new Set<Id>();
        for (Lead lead : leadsToNotify.values()) {
            ownerIds.add(lead.OwnerId);
        }

        Map<Id, User> owners = new Map<Id, User>([SELECT Id, Email, FirstName FROM User WHERE Id IN :ownerIds]);

        // Prepare email messages
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for (Lead lead : leadsToNotify.values()) {
            if (owners.containsKey(lead.OwnerId)) {
                User owner = owners.get(lead.OwnerId);
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new String[] { owner.Email });
                email.setSubject('New Lead Assigned to You');
                email.setPlainTextBody('Hello ' + owner.FirstName + ',\n\n' +
                    'A new lead has been assigned to you:\n\n' +
                    'Name: ' + lead.FirstName + ' ' + lead.LastName + '\n' +
                    'Company: ' + lead.Company + '\n' +
                    'Priority: ' + lead.Priority__c + '\n' +
                    'Lead Score: ' + lead.Lead_Score__c + '\n\n' +
                    'Please follow up with the lead as soon as possible.\n\n' +
                    'Best regards,\nSalesforce');
                emails.add(email);
            }
        }

        // Send all emails
        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);
        }
    }
}
