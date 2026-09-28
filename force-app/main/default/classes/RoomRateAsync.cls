public class RoomRateAsync {

    @future
    public static void applyIncrease (List<Id> roomIds, Decimal pct) {
        List<Room__c> rooms = [SELECT Id, Nightly_Rate__c FROM Room__c WHERE Id IN :roomIds];

        for( Room__c r : rooms ) {
            if( r.Nightly_Rate__c != null){
                r.Nightly_Rate__c = r.Nightly_Rate__c * ( 1 + (pct/100));
        }
       
    }
        update rooms;
    }

    @future
    public static void secondFuture() {
        System.debug('second future ran');
    }


}