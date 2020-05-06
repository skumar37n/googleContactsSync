public class GoogleAuthorizationController {

public static String createEndpoint(String httpAction) {
    String endPoint;
    if(httpAction == 'GET') endPoint = 'callout:Google_People_API/people/me/connections?personFields=emailAddresses,genders,names,occupations,organizations,phoneNumbers,photos';
    else if(httpAction == 'POST') endPoint = 'callout:Google_People_API/people:createContact';
    return endPoint;
}


//Utility Method Naive Approach
public static List<GoogleContactGetWrapper> createContact(String jsonResponse) {
    List<GoogleContactGetWrapper> googleContacts = new List<GoogleContactGetWrapper>();
    Integer contactsCount = getContactsCount(jsonResponse);
    List<String> gcNames = new List<String>();
    List<String> gcEmails = new List<String>();
    List<String> gcPhones = new List<String>();
    List<String> gcCompanies = new List<String>();
    List<String> gcPositions = new List<String>();
    List<String> gcIds = new List<String>();
    List<String> gcPhotoUrls = new List<String>();
    //GoogleContactWrapper googleContact = new GoogleContactWrapper();
    JSONParser parser = JSON.createParser(jsonResponse);
    while (parser.nextToken() != null) {
        if ((parser.getCurrentToken() == JSONToken.FIELD_NAME))  {
            if(parser.getText() == 'displayName') { 
                parser.nextToken(); 
                gcNames.add(parser.getText());
            }
            else if(parser.getText() == 'value') { 
                parser.nextToken();
                if(parser.getText().contains('@')) {
                    gcEmails.add(parser.getText());
                }
            }
            else if(parser.getText() == 'canonicalForm') { 
                parser.nextToken();
                gcPhones.add(parser.getText());
            }
            else if(parser.getText() == 'name') { 
                parser.nextToken(); 
                gcCompanies.add(parser.getText());
            }
            else if(parser.getText() == 'title') {
                parser.nextToken(); 
                gcPositions.add(parser.getText());
            }
            else if(parser.getText() == 'url') {
                parser.nextToken(); 
                gcPhotoUrls.add(parser.getText());
            }
            
        }
    }
    googleContacts = createGCList(contactsCount, gcNames, gcEmails, gcPhones, gcCompanies, gcPositions, gcPhotoUrls);
    //System.debug(googleContacts);
    return googleContacts;
    /*System.debug(gcIds);
System.debug(gcNames);
System.debug(gcEmails);
System.debug(gcPhones);
System.debug(gcCompanies);
System.debug(gcPositions);*/
}

//to get count of google contacts returned in json
public static Integer getContactsCount(String jsonResponse) {
    Integer totalCount;
    JSONParser parser = JSON.createParser(jsonResponse);
    while (parser.nextToken() != null) {
        if ((parser.getCurrentToken() == JSONToken.FIELD_NAME))  {
            if(parser.getText() == 'totalItems') { 
                parser.nextToken(); 
                totalCount = Integer.valueOf(parser.getText());
            }
        }
    }
    return totalCount;
}

//to turn passed lists into List<GoogleContactWrapper>
public static List<GoogleContactGetWrapper> createGCList(Integer contactsCount, List<String> gcNames, List<String> gcEmails, List<String> gcPhones, 
                                                        List<String> gcCompanies,List<String> gcPositions, List<String> gcPhotoUrls) {
                                                            List<GoogleContactGetWrapper> googleContacts = new List<GoogleContactGetWrapper>();
                                                            for(Integer i = 0; i < contactsCount; i++) {
                                                                GoogleContactGetWrapper googleContact = new GoogleContactGetWrapper();
                                                                googleContact.contactId = String.valueOf(i+1);
                                                                if(gcNames[i] != '') googleContact.name = gcNames[i];
                                                                else googleContact.name = '-';
                                                                if(gcEmails[i] != '') googleContact.email = gcEmails[i];
                                                                else googleContact.email = '-';
                                                                if(gcPhones[i] != '') googleContact.phone = gcPhones[i];
                                                                else googleContact.phone = '-';
                                                                if(gcCompanies[i] != '') googleContact.company = gcCompanies[i];
                                                                else googleContact.company = '-';
                                                                if(gcPositions[i] != '') googleContact.position = gcPositions[i];
                                                                else googleContact.position = '-';
                                                                googleContacts.add(googleContact);
                                                                /*if(gcPhotoUrls[i] != '') googleContact.contactPhoto = gcPhotoUrls[i];
else googleContact.contactPhoto = '-';
googleContacts.add(googleContact);*/
                                                            }
                                                            
                                                            return googleContacts;
                                                        }

}

























