public with sharing class AssetController {
    @AuraEnabled(cacheable=true)
    public static List<Asset> getAssetData() {
        // Replace this with your own query to fetch the required asset fields
        return [SELECT Id, SerialNumber, Interior_Color__c, Exterior_Color__c, Name FROM Asset];
    }
  
   
}
