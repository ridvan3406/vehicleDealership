@isTest
private class ProductCalloutTest {
  @IsTest
  private static void getProductsTest() {
    // Set up mock
    ProductCalloutMock mock = new ProductCalloutMock();
    Test.setMock(HttpCalloutMock.class, mock);

    // Call the method to be tested
    HttpResponse response = ProductCallouts.getProducts();

    // Assert the response
    System.assertEquals(response.getStatus(), 'OK');
    System.assertEquals(response.getStatusCode(), 200);
  }
}
