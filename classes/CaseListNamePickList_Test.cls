/* 
** Class: CaseListNamePickList_Test
** Author:  Nicholas Grant - Praxis Solutions
** Date:    12/31/2018
** Purpose: Test class for the CaseListNamePickList class
*/
@isTest(seeAllData=true)
public class CaseListNamePickList_Test {
	
    @isTest
    public static void runTest(){
        CaseListNamePickList cNmPickList=new CaseListNamePickList();
        cNmPickList.getDefaultValue();
        cNmPickList.getValues();
    }
}