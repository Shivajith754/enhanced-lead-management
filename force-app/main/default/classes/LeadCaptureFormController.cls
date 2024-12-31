public with sharing class LeadCaptureFormController {
    @AuraEnabled
    public static void createLead(Map<String, Object> leadData) {
        System.debug('Lead Data Received: ' + leadData); // Log the input data

        Lead newLead = new Lead();

        for (String field : leadData.keySet()) {
            if (Schema.SObjectType.Lead.fields.getMap().containsKey(field)) {
                newLead.put(field, leadData.get(field));
            }
        }

        System.debug('Constructed Lead: ' + newLead); // Log the Lead record before insertion

        insert newLead; // Attempt to insert the Lead
    }
}
