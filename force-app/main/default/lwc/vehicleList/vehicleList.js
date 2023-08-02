import { LightningElement, track, wire } from "lwc";
import getAssetData from "@salesforce/apex/AssetController.getAssetData";
import { CloseActionScreenEvent } from "lightning/actions";

export default class AssetTable extends LightningElement {
  columns = [
    { label: "Serial Number", fieldName: "SerialNumber", type: "text" },
    {
      label: "Vehicle Inner Color",
      fieldName: "Interior_Color__c",
      type: "text",
    },
    { label: "Vehicle Color", fieldName: "Exterior_Color__c", type: "text" },
    { label: "Product", fieldName: "Name", type: "text" },
  ];

  @track assets = []; // Holds the asset data
  @track selectedAssets = []; // Holds the selected asset data

  // Fetch asset data from Salesforce using Apex
  @wire(getAssetData)
  wiredAssets({ error, data }) {
    if (data) {
      this.assets = data;
      console.log(this.assets);
      console.log(this.selectedAssets);
    } else if (error) {
      // Handle error
      console.error("Error fetching assets:", error);
    }
  }
  get noRecordsFound() {
    return this.assets.length === 0;
  }

  handleAssetSelection(event) {
    this.selectedAssets = event.detail.selectedRows;
  }
  // to close model we use a  built in method to close. we will cal it in the button action
  closeQuickAction() {
    this.dispatchEvent(new CloseActionScreenEvent());
  }
  handleLinkAssetsToOpportunity() {
    console.log("first asset selected", this.selectedAssets);
    this.closeQuickAction();
  }
}
