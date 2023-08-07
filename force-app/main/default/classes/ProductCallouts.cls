public with sharing class ProductCallouts {
  public static HttpResponse getProducts() {
    //1. Prepare HTTPRequest and wrap the necessary information in it
    HttpRequest request = new HttpRequest();
    request.setEndpoint(
      'https://wisequarter1--erp.sandbox.my.salesforce.com/services/apexrest/ProductWebService'
    );
    request.setMethod('GET');
    request.setHeader('Content-Type','application/json;charset=UTF-8');
    request.setHeader('Authorization','Bearer 00D780000008gDM!AQcAQCOJ2eoNkup8EzmudOt_mWzsgFNkmqQWbd54ykLgP2FZyjKIPQ.coY1iwE55EHMI80N.Sh6gE9AcrBvnU1uV4raWtDvY');


    //2. Preapare internet
    Http http = new Http();
    //3. Send the HTTPRequest over the internet to recieve HttpResponse back
    HttpResponse response = http.send(request);

    //4. Process the HttpResponse
    if (response.getStatusCode() == 200) {
      String jsonString = response.getBody();
      //getJsonProduct productsList = (getJsonProduct) JSON.deserialize(response.getBody(), getJsonProduct.class);
      ProductsWrapper wrapper = (ProductsWrapper) JSON.deserialize(
        jsonString,
        ProductsWrapper.class
      );
      //   List<ProductsWrapper> productsList = (List<ProductsWrapper>) JSON.deserialize(
      //     jsonString,
      //     List<ProductsWrapper>.class
      //   );
      List<Product2> products = new List<Product2>();
      for (ProductsWrapper.TempProduct pw : wrapper.prodList) {
        Product2 prod = new Product2();
        prod.Name = pw.productName;
        prod.ExternalId = pw.productERPId;
        prod.ProductCode = pw.productCode;
        prod.Wheel_Drive__c = pw.wheelDrive;
        prod.Gear__c = pw.gear;
        prod.Body_Type__c = pw.bodyType;
        prod.Engine_Capacity__c = pw.engineCapacity;
        prod.Fuel_Type__c = pw.fuelType;
        prod.Unit_Price__c = pw.unitPrice;
        prod.IsActive = pw.isActive;
        prod.Description = pw.description;
        products.add(prod);
      }
      try {
        if (!products.isEmpty()) {
          insert products;
        }
      } catch (Exception ex) {
        System.debug('error : ' + ex);
      }
    }
    return response;
  }
}

