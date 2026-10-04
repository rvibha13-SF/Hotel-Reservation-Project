public with sharing class ReservationHandler {
  
        public static void validateDates(List<Reservation__c> records){
                for( Reservation__c r : records) {
                      if ( r.Actual_Check_out__c <= r.Actual_Check_in__c) {
                         r.addError ('Check out date cannot be less than check in date');
                      }
                }

        }
}