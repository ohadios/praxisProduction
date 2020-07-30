/* 
** Class: ObjectNamePickList
** Author:  Nicholas Grant - Praxis Solutions
** Date:    ##/##/2018
** Purpose: Gets Object names for "SingleListView" lightning component
*/
global class ObjectNamePickList extends VisualEditor.DynamicPickList {
	global override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('Case (Case)', 'Case');
        return defaultValue;
    }
    global override VisualEditor.DynamicPickListRows getValues() {
        VisualEditor.DynamicPickListRows  sobjects = new VisualEditor.DynamicPickListRows();
        for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
            String apiname = objTyp.getDescribe().getName();
            String label = objTyp.getDescribe().getLabel();
            sobjects.addRow(new VisualEditor.DataRow(label+' ('+apiname+')', apiname));
        }
        return sobjects;
    }
}