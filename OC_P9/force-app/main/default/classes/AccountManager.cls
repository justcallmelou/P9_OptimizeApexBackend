/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-20-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   04-20-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public with sharing class AccountManager {
    
    public static Map<Id, Account> calulationAccountCA(Map<Id, Account> mAccts) {
        
        for(Account acc : mAccts.values()){
            Decimal ta = 0;
            for(Order o : acc.Orders){
                ta += o.totalAmount;
            } 
            acc.Chiffre_d_affaire__c = ta;
            mAccts.put(acc.Id, acc);
        }     
        return mAccts;
    }    
}