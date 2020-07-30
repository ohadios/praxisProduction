@isTest
private class PRXS_SVC_RegHandler_Test {
    static void makeData(){
        Account a=new Account(Name='Test Account');
        insert a;
        //Create contact that's allowed to register to community
        Contact cAllowedToRegister=new Contact(AccountId=a.Id,
                                               FirstName='Test',
                                               LastName='Contact',
                                               Email='testuser1@example.org',
                                               Allow_Community_Self_Registration__c=true);
        //Create contact that' not allowed to register to community
        Contact cNotAllowedToRegister=new Contact(AccountId=a.Id,
                                                  FirstName='Test',
                                                  LastName='Contact',
                                                  Email='testuser2@example.org',
                                                  Allow_Community_Self_Registration__c=false);
        Insert new List<Contact>{cAllowedToRegister,cNotAllowedToRegister};
            }
    
    @isTest
    static void testCreateAndUpdateUserPass() {
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        //Use System.runAs blocks to avoid the mixed DML error
        System.runAs (thisUser) {
            
            makeData();
            PRXS_SVC_CommunityRegHandler handler = new PRXS_SVC_CommunityRegHandler();
            Auth.UserData sampleData = new Auth.UserData('testId', 'testFirst', 'testLast',
                                                         'testFirst testLast', 'testuser1@example.org', null, 'testuserlong@salesforce.com', 'en_US', 'salesforce',
                                                         null, new Map<String, String>{'language' => 'en_US','sfdc_networkid'=>''});
            User u = handler.createUser(null, sampleData);
            System.assertEquals('testuserlong@salesforce.com', u.userName);
            System.assertEquals('testuser1@example.org', u.email);
            System.assertEquals('testLast', u.lastName);
            System.assertEquals('testFirst', u.firstName);
            System.assertEquals('testuser', u.alias);
            
            insert(u);
            String uid = u.id;
            
            sampleData = new Auth.UserData('testNewId', 'testNewFirst', 'testNewLast',
                                           'testNewFirst testNewLast', 'testnewuser@example.org', null, 'testnewuserlong@salesforce.com', 'en_US', 'salesforce',
                                           null, new Map<String, String>{});
            handler.updateUser(uid, null, sampleData);
            
            User updatedUser = [SELECT userName, email, firstName, lastName, alias FROM user WHERE id=:uid];
            //System.assertEquals('testnewuserlong@salesforce.com', updatedUser.userName);
            System.assertEquals('testnewuser@example.org', updatedUser.email);
            System.assertEquals('testNewLast', updatedUser.lastName);
            System.assertEquals('testNewFirst', updatedUser.firstName);
            System.assertEquals('testnewu', updatedUser.alias);
        }
    }
}