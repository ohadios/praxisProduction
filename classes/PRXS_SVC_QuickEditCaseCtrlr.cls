/* 
** Class: PRXS_SVC_QuickEditCaseCtrlr
** Author:  Nicholas Grant - Praxis Solutions
** Date:    1/12/2019 
** Purpose: Aura service for the QuickEditCase Lightning Component
*/
global class PRXS_SVC_QuickEditCaseCtrlr {
    /*
    ** Query an object given its Id and additional fields
    ** @param(s):   String sObjectId - The id of the that you want to query
    **              String additionalFields - Any Additional fields to query
    ** @return:     sObject contextObject - the queried sObject 
    */
    @AuraEnabled  
    global static sObject getContextObjectById(String sObjectId,String additionalFields){
        System.debug('sObjectId: '+sObjectId);
        String sObjectType=Id.valueOf(sObjectId).getSobjectType().getDescribe().getName();
        System.debug('sObjectType: '+sObjectType);
        String query='SELECT Id'+additionalFields+' FROM '+sObjectType+' WHERE Id=\''+sObjectId+'\'';
        System.debug('query: '+query);
        sObject contextObject=Database.query(query);
        System.debug('contextObject: '+contextObject);
        return contextObject;
    }
    
    @AuraEnabled  
    global static sObject updateCase(sObject objectToUpdate){
        Case caseToUpdate=(Case) objectToUpdate;
        update caseToUpdate;
        return caseToUpdate;
    }
    
    @AuraEnabled
    global static List<String> getPicklistFieldValues(String objectName, String pickListFieldName){
        List<String> picklistValues = new List<String>();
        SObjectType objectType = Schema.getGlobalDescribe().get(objectName);
        List<Schema.PicklistEntry> pick_list_values = objectType.getDescribe()
                                                       .fields.getMap()
                                                       .get(pickListFieldName)
                                                       .getDescribe().getPickListValues();
        for (Schema.PicklistEntry aPickListValue : pick_list_values) {                   
            picklistValues.add(aPickListValue.getValue()); 
        }
        return picklistValues;
    }
}