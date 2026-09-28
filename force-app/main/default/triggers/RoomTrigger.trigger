trigger RoomTrigger on Room__c (before insert,before update,after insert, after update,before delete, after delete, after undelete) {


System.debug( 'Event: ' + Trigger.operationType);

if(Trigger.new != null){
System.debug( 'Trigger.new Size: ' + Trigger.new.size());
}  

if(Trigger.old != null){
System.debug( 'Trigger.old Size: ' + Trigger.old.size());
}

if(trigger.isBefore && trigger.isInsert){
      for(Room__c r : Trigger.new){
              r.Nightly_Rate__c = 100;

      }   
}


if (trigger.isbefore && trigger.isUpdate) {

    for (Room__c r : Trigger.new){
            Room__c oldRoom = Trigger.oldMap.get(r.Id);

          if ( r.Nightly_Rate__c != oldRoom.Nightly_Rate__c ) {
                  System.debug('The nightly rate for this record has been changed');
          }
        

    }    
}


if (trigger.isAfter && trigger.isUpdate) {

List<Room__c> roomToUpdate = new List<Room__c>();


for( Room__c r : Trigger.new){



        if (RoomHandlerClass.processedIds.contains(r.Id)) {
            continue;
        }
        RoomHandlerClass.processedIds.add(r.Id);
        
                Decimal current = (r.Change_Count__c == null) ? 0 : r.Change_Count__c;
               roomToUpdate.add( 
                      new Room__c (
                           Id = r.Id,
                           Change_Count__c = current + 1)
                      
               );

}
        
         
           
           if( !roomToUpdate.isEmpty()){
           update roomToUpdate;
           }
        }
}