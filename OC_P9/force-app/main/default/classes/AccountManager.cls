/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-22-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   04-20-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public with sharing class AccountManager {
    
    public static void calulationAccountCA(Set<Id> sAccId) {
        
        Map<Id, Account> mAccs = new Map<Id, Account>([SELECT Id, Chiffre_d_affaire__c, (SELECT Id, TotalAmount FROM Orders WHERE Status = 'Ordered') FROM Account WHERE id in: sAccID]);
        
        for(Account acc : mAccs.values()){
            Decimal ta = 0;
            for(Order o : acc.Orders){
                ta += o.totalAmount;
            } 
            acc.Chiffre_d_affaire__c = ta;
            mAccs.put(acc.Id, acc);
        }    
        update mAccs.values();
    }    
}