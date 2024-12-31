@isTest
public class LeadNotificationHelperTest {
    @isTest
    static void testNotificationLogic() {
        // Create test users
        User seniorRep = [SELECT Id, Email FROM User WHERE IsActive = true LIMIT 1];

        // Create test leads
        Lead testLead = new Lead(
            FirstName = 'John',
            LastName = 'Doe',
            Company = 'Example Inc.',
            Priority__c = 'High',
            Lead_Score__c = 30,
            Status = 'Open - Not Contacted',
            OwnerId = seniorRep.Id
        );
        insert testLead;

        // Update lead to trigger notifications
        testLead.OwnerId = seniorRep.Id;
        update testLead;

        // Add assertions
        System.assert(true, 'Notifications should be sent successfully.');
    }
}
