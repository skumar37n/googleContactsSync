public with sharing class GoogleAuthorizationHandler {
//get google contacts
@AuraEnabled
public static List<GoogleContactGetWrapper> getGoogleContacts() {
    String endPoint = GoogleAuthorizationController.createEndpoint('GET');
    Http http = new Http();
    HttpRequest req = new HttpRequest();
    req.setEndpoint(endpoint);
    req.setMethod('GET');
    HTTPResponse res = http.send(req);
    List<GoogleContactGetWrapper> googleContacts = GoogleAuthorizationController.createContact(res.getBody());
    for(GoogleContactGetWrapper gc : googleContacts) {
        System.debug(gc);
    } 
    return googleContacts;
}


@AuraEnabled
public static void createGoogleContact(){
    String endPoint = GoogleAuthorizationController.createEndpoint('POST');
    Http http = new Http();
    HttpRequest req = new HttpRequest();
    req.setEndpoint(endpoint);
    req.setMethod('POST');
    HTTPResponse res = http.send(req);
}
}