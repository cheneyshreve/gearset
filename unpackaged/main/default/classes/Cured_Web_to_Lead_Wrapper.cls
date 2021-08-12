/* Description: wrapper class that passes JSON data to Cured_Web_to_Lead_Utility for processing
 * Developed by: Cured
 * Modification History
*/

public class Cured_Web_to_Lead_Wrapper {

    @AuraEnabled
    public static void setJSONData(Map<String, String> jsonData){
        Cured_Web_to_Lead_Utility util = new Cured_Web_to_Lead_Utility(jsonData);
    }
}