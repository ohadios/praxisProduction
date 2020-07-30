/* 
** Class: ObjectNamePickList_Test
** Author:  Nicholas Grant - Praxis Solutions
** Date:    12/31/2018
** Purpose: Test class for the ObjectNamePickList class
*/
@isTest(seeAllData=true)
public class ObjectNamePickList_Test {
	
    @isTest
    public static void runTest(){
        ObjectNamePickList oNmPickList=new ObjectNamePickList();
        oNmPickList.getDefaultValue();
        oNmPickList.getValues();
    }
}