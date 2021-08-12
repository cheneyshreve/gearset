/* Description: webservice handler class to create an sObject
 * Created By: Cured
 * Created On: 27/02/2021
 * Modification History
*/

public class Cured_Test_Webservice_Handler {
    public static Map<String, Schema.DisplayType> objectData {get; set;}
    public static String objectFields {get; set;}
    
    public Cured_Test_Webservice_Handler(Map<String, String> jsonMap){
       system.debug('constructor called with: ' + jsonMap.keySet());
       fetchObjectFields();
       createSObject(jsonMap);
    }
    
  /* fetch editable fields on sObject */  
  public static Map<String, Schema.DisplayType> fetchObjectFields(){
        system.debug('fetchObjectFields method called');
        objectData  = new Map<String, Schema.DisplayType>();
        objectFields = '';
        Map<String, Schema.SObjectField> fields = Schema.getGlobalDescribe().get('Lead').getDescribe().fields.getMap();
        List<String> editableFields = new List<String>();
        for(Schema.SObjectField fieldRef : fields.values()) {
            Schema.DescribeFieldResult fieldResult = fieldRef.getDescribe();
            if(fieldResult.isUpdateable()) {
                objectFields += fieldResult.getname() + ',';
                objectData.put(fieldResult.getName(), fieldResult.getType());
            }
        }
        return objectData;
    }  
    
  /* create sObject from incoming jsonMap */  
  public static void createSObject(Map<String, String> jsonMap){
        System.debug('createSObject method called with: ' + jsonMap.keySet());
        String ObjectName = jsonMap.get('ObjectName');
        sObject sObj = Schema.getGlobalDescribe().get(ObjectName).newSObject();
        Map<String, Schema.DisplayType> fieldData = new Map<String, Schema.DisplayType>();
        
       for(String param: jsonMap.keySet()){
            if(param.containsIgnoreCase('email') && jsonMap.get('ObjectName') == 'Account'){
                sObj.put('PersonEmail', String.valueOf(jsonMap.get(param)));
            }
            if(param.containsIgnoreCase('birthdate') && jsonMap.get('ObjectName') == 'Account'){
                sObj.put('PersonBirthdate', Date.valueOf(jsonMap.get(param)));
            }
        for(String field: objectData.keySet()){
            if(param.toUpperCase() == field.toUpperCase()){
                String ftype;
                ftype = String.valueOf(objectData.get(field));
                if(ftype == 'STRING' || ftype == 'PHONE'){
                    sObj.put(field, String.valueOf(jsonMap.get(param)));
                } else if(ftype == 'INTEGER'){
                    sObj.put(field, Integer.valueOf(jsonMap.get(param)));
                } else if(ftype == 'DOUBLE'){
                    sObj.put(field, Decimal.valueOf(jsonMap.get(param)));
                } else if(ftype == 'LONG'){
                    sObj.put(field, Long.valueOf(jsonMap.get(param)));
                } else if(ftype == 'DATETIME' || ftype == 'DATE'){
                    sObj.put(field, Date.valueOf(jsonMap.get(param)));
                } else if(ftype == 'BOOLEAN'){
                    sObj.put(field, Boolean.valueOf(jsonMap.get(param)));
                }else {
                    try{
                        sObj.put(field,jsonMap.get(param));
                    } catch(Exception ex){
                        system.debug('An error occurred with field type: ' + ex.getMessage());
                    }
                }
            }
        }
      }  
        try{
            insert sObj;
            system.debug('inserting sObject: ' + sObj);
        } catch(Exception ex){
            System.debug('An error occurred creating the record: ' + ex.getMessage());
        }
        
    }
}