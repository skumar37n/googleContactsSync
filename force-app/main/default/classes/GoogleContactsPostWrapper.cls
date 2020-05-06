public with sharing class GoogleContactsPostWrapper {
    
    @AuraEnabled public List<Name> names;
    @AuraEnabled public List<EmailAddress> emailAddresses;
    @AuraEnabled public List<PhoneNumber> phoneNumbers;
    @AuraEnabled public List<Organization> organizations;

    class Name {
        @AuraEnabled public String givenName;
        @AuraEnabled public String familyName;
    }

    class EmailAddress {
        @AuraEnabled public String value;
    }

    class PhoneNumber {
        @AuraEnabled public String value;
    }

    class Organization {
        @AuraEnabled public String name;
        @AuraEnabled public String title;
    }
}
