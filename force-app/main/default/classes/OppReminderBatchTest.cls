@isTest
private class OppReminderBatchTest {
  @isTest
  static void OppReminderBatchTest() {
    // Create test opportunities
    List<Opportunity> testOpportunities = new List<Opportunity>();
    for (Integer i = 0; i < 5; i++) {
      Opportunity opp = new Opportunity(
        Name = 'Test Opportunity ' + i,
        CloseDate = Date.today().addDays(3),
        OwnerId = UserInfo.getUserId(),
        StageName = 'Prospecting'
      );
      testOpportunities.add(opp);
    }
    insert testOpportunities;

    Test.startTest();

    // Schedule the batch job
    String jobId = System.schedule(
      'Test Opp Reminder Batch',
      '0 0 0 1 1 ?',
      new OppReminderBatch()
    );

    Test.stopTest();
  }
}
