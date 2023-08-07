// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

string tempvar = 'Enter_your_name_here sd sd sd aadssda ridvan saman cool';
System.debug('Hello World!');
System.debug('My name is ' + tempvar);

List<Asset> assetList = AssetController.getAssetData();
System.debug(assetList);


OpportunityReminderBatch batchJob = new OpportunityReminderBatch();
Database.executeBatch(batchJob,4);

HttpResponse response = ProductCallouts.getProducts();
