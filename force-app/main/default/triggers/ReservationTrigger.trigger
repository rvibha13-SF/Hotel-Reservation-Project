trigger ReservationTrigger on Reservation__c (before insert, after insert, before update, after update) {


  if (Trigger.isBefore && Trigger.isInsert) {
            ReservationHandler.validateDates(Trigger.new);

  }





if(trigger.isBefore && trigger.isInsert){
      for(Reservation__c r : Trigger.new){

              if(r.Actual_Check_out__c <= r.Actual_Check_in__c )
              {
                r.addError('Check out date cannot be less than check in date');
              }
      }
    }


    if(Trigger.isBefore && Trigger.isUpdate){

    for ( Reservation__c r : Trigger.new )
    {
       
         Reservation__c oldRes = Trigger.oldMap.get(r.Id); 

        if( oldRes.Actual_Check_in__c != r.Actual_Check_in__c  && r.Actual_Check_in__c != null){

            r.Status__c = 'Checked In';


        } else if ( oldRes.Actual_Check_out__c != r.Actual_Check_out__c  &&  r.Actual_Check_out__c != null){

            r.Status__c = 'Checked Out';
        }

    }
    }



/*Requirement — Rate Lock 

When a Reservation is created, copy the Room's nightly rate onto the Reservation.
Room rates change seasonally, and the business needs the rate in effect at booking time frozen on the record so revenue reports stay accurate after the Room's rate is later updated.

*/
      if(Trigger.isBefore && Trigger.isInsert) {

/*Set — collect the Room Ids the 250 reservations point at, deduped down to one.

Query — make a single trip to the database to fetch those Rooms and their nightly rates.

Map — hold that result keyed by Id so the second loop can grab the rate without querying again  

Loop again for assigning the value

*/


        Set<Id> rooms = new Set<Id>(); 
        for (Reservation__c res: Trigger.new) {
              rooms.add(res.Room__c);
        }
        
        
        Map<Id,Room__c> roomsById = new Map<Id,Room__c>([SELECT Id, Nightly_Rate__c FROM Room__c WHERE Id IN :rooms]);
        

        for(Reservation__c res1 : Trigger.new){

               if(res1.Room__c != null ) {
                 res1.Rate_At_Booking__c = roomsById.get(res1.Room__c).Nightly_Rate__c;
        }

         /* Without bulkification
            for( Reservation__c r : Trigger.new)
            {
              Room__c room = [SELECT Id,Name,Nightly_Rate__c FROM Room__c WHERE Id = :r.Room__c];
               r.Rate_At_Booking__c = room.Nightly_Rate__c;
            } */
            
    }
}

}