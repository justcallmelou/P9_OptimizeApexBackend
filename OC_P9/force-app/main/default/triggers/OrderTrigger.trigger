/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-22-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   04-19-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
trigger OrderTrigger on Order (after insert ,after update) {
    
    Set <Id> sAccID = new Set <Id> ();
    
    for (Order o: Trigger.new) { 
        if(o.Status == 'Ordered' && o.Status != Trigger.oldMap.get(o.Id).Status){
			sAccID.add (o.AccountId); 
            System.debug(sAccID);
        }
    } 
    
    if(sAccID.size() > 0)  AccountManager.calulationAccountCA(sAccID);
}