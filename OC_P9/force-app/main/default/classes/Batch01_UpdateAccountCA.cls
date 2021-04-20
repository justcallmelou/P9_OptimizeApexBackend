/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-16-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   04-15-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
global class Batch01_UpdateAccountCA implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        return Database.getQueryLocator(
            [SELECT Name, Id, (SELECT Id, TotalAmount, Status FROM Orders WHERE Status = 'Ordered') FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status= 'Ordered')]

        );
    }
    
    global void execute(Database.BatchableContext info, List<Account> scope){   
        List<Account> lAccToUpdate = new List<Account>();
        
        for(Account acc : scope){
            acc.Chiffre_d_affaire__c = 0;
            for(Order o : acc.Orders){
                acc.Chiffre_d_affaire__c += o.TotalAmount;
            }
            lAccToUpdate.add(acc);
        }
        update lAccToUpdate;
        
    }    
    
    global void finish(Database.BatchableContext info){     
        
    } 
}

