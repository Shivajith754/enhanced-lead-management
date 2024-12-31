@isTest
public class LeadScoringTriggerTest {
    @isTest
    static void testLeadScoringAndAssignment() {
        // Mock owner and queue IDs to match org-specific data
        String seniorRepId = '005WU000009ETL8'; // Replace with valid User ID in your org
        String juniorRepId = '005WU000009EVxJ'; // Replace with valid User ID in your org
        String lowPriorityQueueId = '00GWU000007nmXJ'; // Replace with valid Queue ID in your org

        // Step 1: Test with a high-priority lead (Technology, high revenue, Web)
        Lead highPriorityLead = new Lead(
            FirstName = 'High',
            LastName = 'Priority',
            Company = 'Test Company',
            Industry = 'Technology',
            AnnualRevenue = 1500000,
            LeadSource = 'Web',
            Status = 'Open - Not Contacted',
            Priority__c = 'High'
        );
        insert highPriorityLead;

        Lead retrievedHighPriorityLead = [SELECT Lead_Score__c, OwnerId FROM Lead WHERE Id = :highPriorityLead.Id];
        System.assertEquals(30, retrievedHighPriorityLead.Lead_Score__c, 'Score should be 30 for high-priority lead.');
        System.assertEquals(seniorRepId, retrievedHighPriorityLead.OwnerId, 'Owner should be senior sales rep.');

        // Step 2: Test with medium-priority lead (Retail, mid revenue, Referral)
        Lead mediumPriorityLead = new Lead(
            FirstName = 'Medium',
            LastName = 'Priority',
            Company = 'Test Company',
            Industry = 'Retail',
            AnnualRevenue = 600000,
            LeadSource = 'Referral',
            Status = 'Open - Not Contacted',
            Priority__c = 'Medium'
        );
        insert mediumPriorityLead;

        Lead retrievedMediumPriorityLead = [SELECT Lead_Score__c, OwnerId FROM Lead WHERE Id = :mediumPriorityLead.Id];
        System.assertEquals(15, retrievedMediumPriorityLead.Lead_Score__c, 'Score should be 15 for medium-priority lead.');
        System.assertEquals(juniorRepId, retrievedMediumPriorityLead.OwnerId, 'Owner should be junior sales rep.');

        // Step 3: Test with low-priority lead (Other industry, low revenue, unknown LeadSource)
        Lead lowPriorityLead = new Lead(
            FirstName = 'Low',
            LastName = 'Priority',
            Company = 'Test Company',
            Industry = 'Other',
            AnnualRevenue = 10000,
            LeadSource = 'Unknown',
            Status = 'Open - Not Contacted',
            Priority__c = 'Low'
        );
        insert lowPriorityLead;

        Lead retrievedLowPriorityLead = [SELECT Lead_Score__c, OwnerId FROM Lead WHERE Id = :lowPriorityLead.Id];
        System.assertEquals(4, retrievedLowPriorityLead.Lead_Score__c, 'Score should be 4 for low-priority lead.');
        System.assertEquals(lowPriorityQueueId, retrievedLowPriorityLead.OwnerId, 'Owner should be low-priority queue.');

        // Step 4: Test notification logic on update
        Lead notificationLead = new Lead(
            FirstName = 'Notify',
            LastName = 'User',
            Company = 'Notification Co.',
            Industry = 'Technology',
            AnnualRevenue = 2000000,
            LeadSource = 'Web',
            Status = 'Open - Not Contacted',
            Priority__c = 'High',
            OwnerId = lowPriorityQueueId
        );
        insert notificationLead;

        // Update OwnerId to trigger notification
        notificationLead.OwnerId = seniorRepId; // Assign to senior sales rep
        update notificationLead;

        Lead updatedNotificationLead = [SELECT OwnerId FROM Lead WHERE Id = :notificationLead.Id];
        System.assertEquals(seniorRepId, updatedNotificationLead.OwnerId, 'Owner should update to senior sales rep.');
    }
}
