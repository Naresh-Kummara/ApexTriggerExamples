trigger OpportunityTask on Opportunity (after insert,before update) 
    {
        if(Trigger.isInsert)
        {
            OpportunityTaskOnAccount.afterInsertionOfOpportunity(Trigger.new);
        }
       else if(Trigger.isUpdate)
        {
            OpportunityTaskOnAccount.afterUpdatingField(Trigger.new);
        }
    }