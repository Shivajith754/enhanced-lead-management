trigger LeadScoringTrigger on Lead (before insert, before update) {
    // Set to store the list of leads that need notifications
    Map<Id, Lead> leadsToNotify = new Map<Id, Lead>();

    for (Lead lead : Trigger.new) {
        Integer score = 0;

        // Lead Scoring Logic
        if (lead.Industry == 'Technology') {
            score += 10;
        } else if (lead.Industry == 'Retail') {
            score += 5;
        } else {
            score += 1;
        }

        if (lead.AnnualRevenue != null) {
            if (lead.AnnualRevenue > 1000000) {
                score += 10;
            } else if (lead.AnnualRevenue > 500000) {
                score += 5;
            } else {
                score += 1;
            }
        }

        if (lead.LeadSource == 'Web') {
            score += 10;
        } else if (lead.LeadSource == 'Referral') {
            score += 5;
        } else {
            score += 2;
        }

        lead.Lead_Score__c = score;

        // Lead Assignment Logic
        if (score >= 25) {
            lead.OwnerId = '005WU000009ETL8'; //  User ID of senior sales rep
        } else if (score >= 15) {
            lead.OwnerId = '005WU000009EVxJ'; //  User ID of junior sales rep
        } else {
            lead.OwnerId = '00GWU000007nmXJ'; //  Queue ID for low-priority leads
        }

        // Add leads to notify if the OwnerId has changed and the new owner is a user (not a queue)
        if (Trigger.isUpdate && lead.OwnerId != Trigger.oldMap.get(lead.Id).OwnerId && String.valueOf(lead.OwnerId).startsWith('005')) {
            leadsToNotify.put(lead.Id, lead);
        } else if (Trigger.isInsert && String.valueOf(lead.OwnerId).startsWith('005')) {
            leadsToNotify.put(lead.Id, lead);
        }
    }

    // Call the notification helper
    if (!leadsToNotify.isEmpty()) {
        LeadNotificationHelper.sendNotifications(leadsToNotify);
    }
}
