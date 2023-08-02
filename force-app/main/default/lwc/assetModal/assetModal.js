// AssetModal.js
import { LightningElement } from "lwc";

export default class AssetModal extends LightningElement {
  handleModalClose() {
    // Handle the logic to close the modal.
    // You can hide the modal or destroy it, depending on your implementation.
  }

  handleLinkAssetsToOpportunity() {
    // Handle the logic to link selected assets to opportunity.
    // ...
    // Then close the modal
    this.handleModalClose();
  }
}
