public class LeadTriggerHandler {
  public static void updateStateFromStateC(List<Lead> leadRecords) {
    for (Lead leadRecord : leadRecords) {
      if (leadRecord.State__c != null) {
        string customState = leadRecord.State__c.subString(3);
        leadRecord.State = customState;
      }
    }
  }
  
}
