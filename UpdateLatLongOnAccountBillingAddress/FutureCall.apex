public class futureResponse {
    @future(callout=true)
    public static void httpRes(string strBody,string geokey,Set<Id> CurrentIds) {
        
        /*build callout
system.debug('strbody'+strBody);
system.debug('geokey'+geokey);
system.debug('CurrentId'+CurrentId);*/
        List<Account> listToUpdate = new List<Account>();
        List<Account> listOfAccount = new List<Account>([ SELECT Id,
                                                         Name,
                                                         BillingCity,
                                                         BillingCountry,
                                                         BillingPostalCode,
                                                         BillingState,
                                                         BillingStreet,
                                                         BillingLatitude,
                                                         BillingLongitude,
                                                         BillingAddress
                                                         
                                                         FROM Account Where Id In :CurrentIds]);
        
        
        for(Account accL: listOfAccount){
            
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setMethod('GET');
            req.setEndpoint('your url'+strBody + '&apiKey='+geokey);
            req.setTimeout(60000);
            
            try{
                
                HttpResponse res = h.send(req);
                
                String resStr = res.getBody();
                
                system.debug('res::'+res);
                
                system.debug('resStr::'+resStr);
                
                list<Decimal> Coord = new list<Decimal>();
                
                if(res.getStatusCode() == 200) {
                    
                    JSONParser parser = JSON.createParser(res.getBody());
                    Double latitude;
                    Double longitude;
                    
                    while (parser.nextToken() != null) {
                        if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'lat')) {
                            parser.nextToken();
                            latitude = parser.getDoubleValue();
                        } else if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'lon')) {
                            parser.nextToken();
                            longitude = parser.getDoubleValue();
                        }
                    }
                    
                    if(latitude != null && longitude != null) {
                    Account accToUpdate = new Account(
                        Id = accL.Id,
                        BillingLatitude = latitude,
                        BillingLongitude = longitude
                    );
                    listToUpdate.add(accToUpdate);
                }
                    
                }
            }
            
            catch( Exception e) {
                
                system.debug('== Exception Occured ====' + e.getMessage()); 
                
            } 
            
        }
        
        if(listToUpdate.size()>0){
            update listToUpdate;
        }
    }
}