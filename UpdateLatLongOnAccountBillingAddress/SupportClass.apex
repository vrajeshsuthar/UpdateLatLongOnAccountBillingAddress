public class GetGeoLocationAccount {
    
    public static void getGeoLocationforAccount(Set<Id> AccountIds){
        
        String geocodingKey = 'your key';
        
        List<Account> lstOfAccount = new List<Account>([ SELECT Id,
                                                        
                                                        Name,
                                                        BillingCity,
                                                        BillingCountry,
                                                        BillingPostalCode,
                                                        BillingState,
                                                        BillingStreet,
                                                        BillingLatitude,
                                                        BillingLongitude,
                                                        BillingAddress                                                      
                                                        
                                                        FROM Account Where Id =: AccountIds]);
       
        // create Billing Address string
        List<String> billingAddList = new List<String>();
        
        
        String StrBillingAddress = '';
        
        if (lstOfAccount[0].BillingStreet != null)
            
            StrBillingAddress += lstOfAccount[0].BillingStreet +', ';
        
        if (lstOfAccount[0].BillingCity != null)
            
            StrBillingAddress += lstOfAccount[0].BillingCity +', ';
        
        if (lstOfAccount[0].BillingState != null)
            
            StrBillingAddress += lstOfAccount[0].BillingState +' ';
        
        if (lstOfAccount[0].BillingCountry != null)
            
            StrBillingAddress += lstOfAccount[0].BillingCountry +', ';
        
        if (lstOfAccount[0].BillingPostalCode != null)
            
            StrBillingAddress += lstOfAccount[0].BillingPostalCode;
        
        StrBillingAddress = EncodingUtil.urlEncode(StrBillingAddress, 'UTF-8');
        
        System.debug('StrBillingAddress ::::' + StrBillingAddress);
        
        List<Decimal> BillingAddressCoordinates = new List<Decimal>();
        
        //calling future method
        if(StrBillingAddress.length() > 0 ){
            
            //BillingAddressCoordinates = 
            futureResponse.httpRes(StrBillingAddress,geocodingKey,AccountIds);
            
        }
        
        
        
    }
    
   
    
}