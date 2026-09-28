public class NoShowUpdateBatch implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, Check_in_Date__c, Actual_Check_in__c, Status__c
            FROM Reservation__c
            WHERE Check_in_Date__c  < TODAY          
            AND Status__c = 'Confirmed'            // status field = Confirmed
            AND Actual_Check_in__c = null          
        ]);
    }

    public void execute(Database.BatchableContext bc, List<Reservation__c> scope) {
        for ( Reservation__c r  : scope) {
            r.Status__c = 'No Show';            
        }
    for (Database.SaveResult sr : Database.update(scope, false)) {
    if (!sr.isSuccess()) {
        System.debug(sr.getErrors()[0].getMessage());
    }
}
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('No show sweep complete');
    }
}
