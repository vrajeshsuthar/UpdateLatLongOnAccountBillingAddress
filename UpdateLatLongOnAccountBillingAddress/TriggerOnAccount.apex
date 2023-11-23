trigger UpdateLatLong on Account (after insert) {
     if (Trigger.isInsert && Trigger.isAfter) {
        Set<Id> accountIds = new Set<Id>();
        
        for (Account acc : Trigger.new) {
            accountIds.add(acc.Id);
        }
        
        GetGeoLocationAccount.getGeoLocationforAccount(accountIds);
    }
}