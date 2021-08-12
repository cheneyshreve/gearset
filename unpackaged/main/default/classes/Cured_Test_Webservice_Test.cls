@isTest
private class Cured_Test_Webservice_Test {

  @isTest static void testPost(){
        String jsonData = generateJSON();
        RestRequest request = new RestRequest();
        RestResponse result = new RestResponse();
        request.addHeader('Content-Type', 'application/json');
        request.requestUri =
            'https://curedtest.my.salesforce.com/services/apexrest/Cured_Test_Webservice';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueof(jsonData);
         RestContext.request = request; 
         RestContext.response= result;
         Test.startTest();
        	Cured_Test_Webservice.manageSObjects();
         Test.stopTest();
    }   
    public static String generateJSON(){
    	JSONGenerator jsonGen = JSON.createGenerator(true);
        jsonGen.writeStartObject();
        jsonGen.writeStringField('ObjectName','Account');
        jsonGen.writeStringField('FirstName','Jane');
        jsonGen.writeStringField('LastName','Tester');
        jsonGen.writeStringField('PersonBirthdate','1980-04-08');
        jsonGen.writeStringField('PersonEmail','jane@test.com');
        jsonGen.writeStringField('Phone','202-867-5309');
        jsonGen.writeEndObject();
        String jsonData = jsonGen.getAsString();
        return jsonData;
    }
}