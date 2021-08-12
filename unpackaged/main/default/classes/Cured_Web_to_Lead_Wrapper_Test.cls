/* Description: test class for Cured_Web_to_Lead_Wrapper. Logic for lead workflow
 * is managed in Cured_Web_to_Lead_Utility class. 
 * Created By: Cured
 * Created Date: 2/24/2021
 * Modification History
 * 4/3/2021 added comments
 * 15/3/2021 commenting out tests for field encryption/refactor to flow
*/

@isTest
private class Cured_Web_to_Lead_Wrapper_Test {
       
    //define variables to manage lead workflow
    public static String FirstName;
    public static String LastName;
    public static String Email; 
    public static String Phone; 
    public static Date Birthdate;
    public static String PostalCode; 
    public static String campaignID;
    
    //helper to initialize variables
    public static void init(){
        Campaign c = new Campaign();
        c.Name = 'Welcome Campaign';
        insert c;
        campaign ca = [SELECT ID FROM CAMPAIGN LIMIT 1];
        campaignId = ca.Id;
        FirstName = 'Jena';
        LastName = 'Smith';
        Email = 'jenarocks@test.email.com';
        Phone = '202-867-5309';
        PostalCode = '80304'; 
        Birthdate = date.newInstance(1988, 12, 17);
    }
   //helper method to generate test JSONMap 
    public static Map<String, String> generateJson(){
        Map<String, String> scenario1 = new Map<String, String>();
        scenario1.put('FirstName', FirstName);
        scenario1.put('LastName', LastName);
        scenario1.put('Email', Email);
        scenario1.put('Phone', Phone);
        scenario1.put('PostalCode', PostalCode);
        scenario1.put('Birthdate__c', String.valueOf(Birthdate));
        scenario1.put('Last_Form_Submitted_Campaign_ID__c', campaignId);
        return scenario1;
    }
    //test the wrapper calls the handler class, which invokes the lead workflow and creates sObjects
    /*@isTest static void testWrapper(){
        init();
        Map<String, String> jsonMap = generateJson();
        Test.startTest();
        	Cured_Web_to_Lead_Wrapper.setJSONData(jsonMap);
            List<Lead> leads = [SELECT ID, FirstName, LastName, Email, RecordTypeId, Phone, PostalCode, IsConverted
                                FROM Lead];
            System.assertEquals('Jena', leads[0].FirstName, 'Expected first name to be Jena');
            System.assertEquals('Smith', leads[0].LastName, 'Expected last name to be Smith');
            System.assertEquals('jenarocks@test.email.com', leads[0].Email, 'Email');
            System.assertEquals('202-867-5309', leads[0].Phone, 'Expected Phone to be 202-867-5309');
            System.assertEquals('80304', leads[0].PostalCode, 'Expected PostalCode to be 80304');
            System.assertEquals(true,leads[0].isConverted, 'Expected lead to be converted.');
            List<Account> accounts = [SELECT ID, FirstName, LastName, PersonEmail  FROM ACCOUNT];
            System.assertEquals('Jena', accounts[0].FirstName, 'Expected first name to be Jena');
            System.assertEquals('Smith', accounts[0].LastName, 'Expected last name to be Smith');
            System.assertEquals('jenarocks@test.email.com', accounts[0].PersonEmail, 'Email');
            List<CampaignMember> members = [SELECT ID FROM CAMPAIGNMEMBER];
            System.assertEquals(1, members.size(), 'Expected one campaign members to be created.');
        Test.stopTest();
    }*/
}