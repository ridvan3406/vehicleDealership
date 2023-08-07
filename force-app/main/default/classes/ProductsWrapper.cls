public with sharing class ProductsWrapper {
  public List<tempProduct> prodList;
  public class TempProduct {
    public string productName;
    public string productERPId;
    public string productCode;
    public string wheelDrive;
    public string gear;
    public string bodyType;
    public string engineCapacity;
    public string fuelType;
    public decimal unitPrice;
    public boolean isActive;
    public string description;
  }
}
