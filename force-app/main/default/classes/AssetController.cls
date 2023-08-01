
public with sharing class AssetController {
    @AuraEnabled(cacheable=true)
    public static List<Asset> getAssetData() {
        // Replace this with your own query to fetch the required asset fields
        return [SELECT Id, SerialNumber, Interior_Color__c, Exterior_Color__c, Name FROM Asset];
    }

    @AuraEnabled
    public static void linkAssetsToOpportunity(Id opportunityId, List<Id> assetIds) {
        List<Asset> assetsToUpdate = new List<Asset>();
        for (Id assetId : assetIds) {
            Asset asset = new Asset(Id = assetId, Opportunity__c = opportunityId);
            assetsToUpdate.add(asset);
        }
        update assetsToUpdate;
    }
}
