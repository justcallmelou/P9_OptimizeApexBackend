/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-22-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   04-15-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
global class Batch01_UpdateAccountCA implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        return Database.getQueryLocator(
            [SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Ordered')]

        );
    }
    
    global void execute(Database.BatchableContext info, List<Account> scope){   
        Set<Id> sAccountIdToUpdate = new Set<Id>();
        
        for(Account acc : scope){
           sAccountIdToUpdate.add(acc.Id);
        }
        
        AccountManager.calulationAccountCA(sAccountIdToUpdate);
    }    
    
    global void finish(Database.BatchableContext info){     
        
    } 
}
