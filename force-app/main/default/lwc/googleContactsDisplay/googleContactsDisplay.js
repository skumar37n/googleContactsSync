import { LightningElement, track } from 'lwc';
import getGoogleContacts from '@salesforce/apex/GoogleAuthorizationHandler.getGoogleContacts';


export default class GoogleContactsDisplay extends LightningElement {
@track googleContacts;
@track error;
showButton = true;

fetchGoogleContacts() {
    console.log('fetching...');
    getGoogleContacts()
        .then(result => {
            console.log(result);
            this.showButton = false;
            this.googleContacts = result;
        })
        .catch(error => {
            this.error = error;
        });
}
}

