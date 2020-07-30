/* 
** Class: PRXS_SVC_QuickEditCaseCtrlr
** Author:  Nicholas Grant - Praxis Solutions
** Date:    1/12/2019 
** Purpose: Aura service for the QuickEditCase Lightning Component
*/
@isTest
public class PRXS_SVC_QuickEditCaseCtrlr_Test {
    static void makeData(){
        Case cs=new Case(Subject='Test Case');
        insert cs;
    }
    
    @isTest
    static void runTest(){
        makeData();
        
        Case csBefore=[SELECT Id,Subject FROM Case LIMIT 1];
        Case csAfter=(Case)PRXS_SVC_QuickEditCaseCtrlr.getContextObjectById(String.valueOf(csBefore.Id),',Subject');
        
        System.assertEquals(csBefore, csAfter);
        
        csAfter=(Case)PRXS_SVC_QuickEditCaseCtrlr.updateCase((sObject)csAfter);
        
        List<String> picklistValues=PRXS_SVC_QuickEditCaseCtrlr.getPicklistFieldValues('Case','Close_Reason__c');
    }
}