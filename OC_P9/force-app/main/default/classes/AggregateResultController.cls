/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-20-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   04-16-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public with sharing class AggregateResultController {

    public List<AggregateResult> aggregateResultList {get;set;}
    
    public AggregateResultController() {
        aggregateResultList =  new List<AggregateResult>();
        aggregateResultList = [ select SUM(TotalAmount) total FROM Order];
    }
}
