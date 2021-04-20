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
@isTest
private class Batch01_UpdateAccountCATest {
    
    @testSetup
    static void setup() {
        
        List<Account> accounts = new List<Account>();
        List<Order> orders = new List<Order>();
        List<OrderItem> ordItem1 = new List<OrderItem>();
        List<OrderItem> ordItem2 = new List<OrderItem>();
        
        //Create Product
        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        insert pd1;
        
        //Instantiate the Pricebook2 record with StandardPricebookId
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        update standardPricebook;
        
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = pd1.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        insert pbe;
        
        // insert 105 accounts
        for(Integer i=0;i<105;i++) {
            accounts.add(new Account(name='AccountTest' +i, Chiffre_d_affaire__c=0));
        }
        insert accounts;
        
        // find the account just inserted, add order for each
        for (Account account : accounts) {
            orders.add(new Order( AccountId=account.id, Status='Draft', EffectiveDate=Date.Today(),Pricebook2Id= standardPricebook.Id ));
        }
        insert orders;
        
         // find the order just inserted, add orderItem for each
        for (Order order : orders) {
            ordItem1.add(new OrderItem( OrderId=order.id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150));
            ordItem2.add(new OrderItem( OrderId=order.id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000));
        }
        insert ordItem1;
        insert ordItem2;
        
        // switch the order status to "ordered" and update each order
        for(Order o : orders){
            o.Status = 'Ordered';
        }
        update orders;
        
    }
    
    @isTest static void test() {
        Test.startTest();
        Batch01_UpdateAccountCA batch01 = new Batch01_UpdateAccountCA();
        Id batchId = Database.executeBatch(batch01);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        Account acc = [select Chiffre_d_affaire__c from account LIMIT 1];
        System.assertEquals(21500, acc.Chiffre_d_affaire__c);
    }
    
}