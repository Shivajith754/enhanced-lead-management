import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createLead from '@salesforce/apex/LeadCaptureFormController.createLead';

export default class LeadCaptureForm extends LightningElement {
    @track firstName = '';
    @track lastName = '';
    @track company = '';
    @track industry = '';
    @track annualRevenue = '';
    @track leadSource = '';
    @track priority = '';

    // Options for comboboxes
    get industryOptions() {
        return [
            { label: 'Technology', value: 'Technology' },
            { label: 'Retail', value: 'Retail' },
            { label: 'Other', value: 'Other' },
        ];
    }

    get leadSourceOptions() {
        return [
            { label: 'Web', value: 'Web' },
            { label: 'Referral', value: 'Referral' },
            { label: 'Other', value: 'Other' },
        ];
    }

    get priorityOptions() {
        return [
            { label: 'High', value: 'High' },
            { label: 'Medium', value: 'Medium' },
            { label: 'Low', value: 'Low' },
        ];
    }

    // Handle field changes
    handleChange(event) {
        const fieldName = event.target.name; // Get the field name
        const fieldValue = event.target.value; // Get the field value
        this[fieldName] = fieldValue; // Dynamically update the correct variable
        console.log(`Field Updated: ${fieldName} = ${fieldValue}`); // Log updates for debugging
    }

    @track isLoading = false;

    handleSubmit() {
        // Validation for required fields
        if (!this.lastName || !this.company || !this.priority) { 
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Validation Error',
                    message: 'Last Name, Company, and Priority are required fields.',
                    variant: 'error',
                })
            );
            console.error('Validation failed: LastName, Company, or Priority is missing.');
            return;
        }
    
        this.isLoading = true; // Show spinner
    
        const fields = {
            FirstName: this.firstName,
            LastName: this.lastName,
            Company: this.company,
            Industry: this.industry,
            AnnualRevenue: this.annualRevenue
                ? parseFloat(this.annualRevenue.replace(/,/g, ''))
                : null,
            LeadSource: this.leadSource,
            Priority__c: this.priority, 
        };
    
        console.log('Submitting Lead with fields:', JSON.stringify(fields));
    
        createLead({ leadData: fields })
            .then(() => {
                this.isLoading = false; // Hide spinner
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Lead created successfully!',
                        variant: 'success',
                    })
                );
                console.log('Lead created successfully.');
                this.resetForm();
            })
            .catch((error) => {
                this.isLoading = false; // Hide spinner
                const errorMessage = error.body ? error.body.message : error.message;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating lead',
                        message: errorMessage,
                        variant: 'error',
                    })
                );
                console.error('Error creating lead:', error);
            });
    }

    resetForm() {
        this.firstName = '';
        this.lastName = '';
        this.company = '';
        this.industry = '';
        this.annualRevenue = '';
        this.leadSource = '';
        this.priority = '';
    }
}
