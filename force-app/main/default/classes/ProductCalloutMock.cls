public with sharing class ProductCalloutMock implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest request) {
      if (
        request.getEndpoint() ==
        'https://wisequarter1--erp.sandbox.my.salesforce.com/services/apexrest/ProductWebService' &&
        request.getMethod() == 'GET'
      ) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(200);
        response.setBody(
          '{"prodList": [{"wheelDrive": "Front-Wheel Drive","unitPrice": 100.00,"productName": "Test Product1","productERPId": "01t78000000eME6AAM","productCode": "112233","isActive": true,"gear": "Manual","fuelType": "Diesel","engineCapacity": "1000 to 1500","description": "TESTTT","bodyType": "Sedan"}]}'
        );
        response.setStatus('OK');
        return response;
      } 
      return null;
    }
  }
  