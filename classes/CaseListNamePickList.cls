/* 
** Class: CaseListNamePickList
** Author:  Nicholas Grant - Praxis Solutions
** Date:    ##/##/2018
** Purpose: Gets Listview names for "SingleListView" lightning component
*/
global class CaseListNamePickList extends VisualEditor.DynamicPickList{
    
    global override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('Case: My Open Cases', 'MyOpenCases');
        return defaultValue;
    }
    global override VisualEditor.DynamicPickListRows getValues() {
        List<ListView> listViews=new List<ListView>([SELECT Id,SObjectType,Name,DeveloperName FROM ListView]);
        VisualEditor.DynamicPickListRows  pickLists = new VisualEditor.DynamicPickListRows();
        for(ListView listView:listViews){
            pickLists.addRow(new VisualEditor.DataRow(listView.SObjectType+': '+listView.Name, listView.DeveloperName));
        }
        return pickLists;
    }
}