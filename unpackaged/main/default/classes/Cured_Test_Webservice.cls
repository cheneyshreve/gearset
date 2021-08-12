/* Description: simple webservice to create an sObject
 * Created By: Cured
 * Created On: 27/02/2021
 * Modification History
*/

@RestResource(urlMapping='/Cured_Test_Webservice/*')
global class Cured_Test_Webservice {

    @HttpPost
    global static String manageSObjects(){
        
        String isValidData = 'Success: Data Submitted';
        Map<String, String> jsonMap = (Map<String, String>) JSON.deserialize(RestContext.request.requestBody.tostring(),Map<String, String>.class);
        Cured_Test_Webservice_Handler handler = new Cured_Test_Webservice_Handler(jsonMap);
        
        return isValidData;
    }
}