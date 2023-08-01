import { LightningElement, track, wire } from 'lwc';
import getAssetData from '@salesforce/apex/AssetController.getAssetData';

export default class AssetTable extends LightningElement {
    columns = [
        { label: 'Serial Number', fieldName: 'SerialNumber', type: 'text' },
        { label: 'Vehicle Inner Color', fieldName: 'Interior_Color__c', type: 'text' },
        { label: 'Vehicle Color', fieldName: 'Exterior_Color__c', type: 'text' },
        { label: 'Product', fieldName: 'Name', type: 'text' },
    ];

    @track assets = []; // Holds the asset data
    @track selectedAssets = []; // Holds the selected asset data

    // Fetch asset data from Salesforce using Apex
    @wire(getAssetData)
    wiredAssets({ error, data }) {
        if (data) {
            this.assets = data;
        } else if (error) {
            // Handle error
            console.error('Error fetching assets:', error);
        }
    }

    handleAssetSelection(event) {
        this.selectedAssets = event.detail.selectedRows;
    }

    handleLinkAssetsToOpportunity() {
        // Logic to link selected assets to the opportunity goes here
        // You can use Apex or any other method to perform the linking
        // For the sake of simplicity, we'll just log the selected assets
        console.log('Selected Assets:', this.selectedAssets);
    }
}
