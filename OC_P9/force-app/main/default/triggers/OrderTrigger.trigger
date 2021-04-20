/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-20-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   04-19-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
trigger OrderTrigger on Order (after insert ,after update ,after delete,after undelete) {
    
    Set <Id> accID = new Set <Id> ();
    if (trigger.isafter && trigger.isinsert || trigger.isupdate) {
        for (Order o: Trigger.new) { 
            if(o.Status == 'Ordered' && o.Status != Trigger.oldMap.get(o.Id).Status){
                accID.add (o.AccountId); 
                System.debug(accID);
            }
        } 
    }
    if(accID.size() > 0){
        Map<Id, Account> mAccs = new Map<Id, Account>([SELECT Id, Chiffre_d_affaire__c, (SELECT Id, TotalAmount FROM Orders WHERE Status = 'Ordered') FROM Account WHERE id in: accID]);
        
        AccountManager.calulationAccountCA(mAccs);
        
        update mAccs.values();
    }
}