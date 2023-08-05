@isTest
private class TestLeadTriggerHandler {
    @isTest
    static void testUpdateStateFromStateC() {
        // Create test leads
        List<Lead> testLeads = new List<Lead>();
        
        Lead lead1 = new Lead(
            FirstName = 'Test',
            LastName = 'Lead 1',
            State__c = 'TX: Texas' // Using a valid State picklist value
        );
        testLeads.add(lead1);
        
        Lead lead2 = new Lead(
            FirstName = 'Test',
            LastName = 'Lead 2',
            State__c = 'AL: Alabama' // Using another valid State picklist value
        );
        testLeads.add(lead2);

        insert testLeads;

        Test.startTest();

        // Call the handler method
        LeadTriggerHandler.updateStateFromStateC(testLeads);

        Test.stopTest();

        // Verify that State field is updated correctly for Lead 1
        String expectedState1 = lead1.State__c.substring(3);
        System.assertEquals(expectedState1, lead1.State);

        // Verify that State field is updated correctly for Lead 2
        String expectedState2 = lead2.State__c.substring(3);
        System.assertEquals(expectedState2, lead2.State);
    }
}
