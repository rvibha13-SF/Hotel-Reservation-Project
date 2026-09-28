// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents


Reservation__c  res = new Reservation__c(
                
             Room__c = 'a08Hr00000WYWsaIAH',
              Check_in_Date__c = Date.today().addDays(-1),
    Actual_Check_in__c  = Date.today(),
    Actual_Check_out__c = Date.today().addDays(3)

);

try {
    insert res;
    System.debug('INSERT SUCCEEDED');
} catch (DmlException e) {
    System.debug('INSERT FAILED: ' + e.getMessage());
}