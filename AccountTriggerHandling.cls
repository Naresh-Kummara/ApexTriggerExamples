public class AccountTriggerHandling {
    public static void insertBefore(List<Account> accList){
        for(Account acc:accList)
        {
            if(acc.Industry!=null && acc.Industry=='Media')
            {
                acc.Rating='Hot';
            }
        }
    }
    public static void insertAfter(List<Account> newList){
        List<Opportunity> opp=new List<Opportunity>();
        for(Account ac:newList)
        {
            Opportunity o=new Opportunity();
            o.Name=ac.Name;
            o.AccountId=ac.Id;
            o.CloseDate=System.today();
            o.StageName='Qualification';
            opp.add(o);
        }
        if(!opp.isEmpty()){
            insert opp;
        }
    }
    public static void updateBefore(List<Account> uppBeList,Map<Id,Account> oldMap) {
        for(Account a:uppBeList)
        {
            if(oldMap!=null && a.Phone!=oldMap.get(a.Id).Phone){
                a.description='Phone number field is updated by trigger';
            }
        }
        
    }
    public static void updateAfter(List<Account> uppAfList,Map<Id,Account> oldMap)
    {
        List<Opportunity> updatedOopList=new List<Opportunity>();
        Map<Id,Account> updateId=new Map<Id,Account>();
        for(Account accc:uppAfList)
        {
            if(oldMap!=null && accc.Phone!=oldMap.get(accc.Id).Phone){
                updateId.put(accc.id,accc);
            }
        }
        for(Opportunity op:[SELECT Id,Account_Phone__c,AccountId FROM Opportunity WHERE AccountId IN :updateId.keySet()])
        {
            Opportunity o=new Opportunity();
            if(updateId.containsKey(op.AccountId)){
                o.Id=op.Id;
                o.Account_Phone__c=updateId.get(op.AccountId).phone;
                updatedOopList.add(o);
            }
            
        }
        if(!updatedOopList.isEmpty())
        {
            update updatedOopList;
        }
        
    }
    public static void deleteBefore(List<Account> ba){
        for(Account bac: ba)
        {
            if(bac.Active__c=='Yes'){
                bac.addError('you can not delete this account');
            }
        }
    }
    public static void deleteAfter(Map<Id,Account> mapId){
        List<Opportunity> lo=new List<Opportunity>();
        for(Opportunity po:[SELECT Id FROM Opportunity WHERE AccountId In:mapId.keySet()]){
            lo.add(po);
        }
        if(!lo.isEmpty())
        {
            delete lo;
        }
    }

}