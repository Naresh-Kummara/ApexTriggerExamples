trigger AccountTrigger on Account (before insert,after insert,before update,after update,before delete,after delete) {
    if(Trigger.isInsert)
    {
        if(Trigger.isBefore){
            AccountTriggerHandling.insertBefore(Trigger.New);
        }else if(Trigger.isAfter){
           AccountTriggerHandling.insertAfter(Trigger.New);
        }
        
    }
    if(Trigger.isUpdate)
    {
        if(Trigger.isBefore)
        {
            AccountTriggerHandling.updateBefore(Trigger.New,Trigger.oldMap);
        }
       else if(Trigger.isAfter)
       {
           AccountTriggerHandling.updateAfter(Trigger.New,Trigger.oldMap);
       }
    }
    if(Trigger.isDelete)
    {
        if(Trigger.isBefore)
        {
             AccountTriggerHandling.deleteBefore(Trigger.old);
        }
        else if(Trigger.isAfter)
        {
            AccountTriggerHandling.deleteAfter(Trigger.oldMap);
        }
    }

}