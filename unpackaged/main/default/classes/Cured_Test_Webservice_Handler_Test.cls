/* Description: test class for webservice handler
 * Created By: Cured
 * Created On: 27/02/2021
 * Modification History
*/
@isTest
private class Cured_Test_Webservice_Handler_Test {
    public static String FirstName;
    public static String LastName;
    public static String PersonEmail; 
    public static String Phone; 
    public static String PersonBirthdate;
   
    public static void init(){
        FirstName = 'Jena';
        LastName = 'Smith';        
        PersonEmail = 'jenarocks@test.email.com';
        Phone = '202-867-5309';
        PersonBirthdate = '1988-02-03';
    }

    @isTest static void testCreateAccount(){
        init();
        Map<String, String> scenario1 = new Map<String, String>();
        scenario1.put('ObjectName', 'Account');
        scenario1.put('FirstName', FirstName);
        scenario1.put('LastName', LastName);
        scenario1.put('PersonEmail', PersonEmail);
        scenario1.put('PersonBirthdate', PersonBirthdate);
        scenario1.put('Phone', Phone);
        
        Test.startTest();
        	Cured_Test_Webservice_Handler handler = new Cured_Test_Webservice_Handler(scenario1);
        	List<Account> accounts = [SELECT Id, FirstName, LastName, PersonEmail, PersonBirthdate, Phone 
                                     FROM Account];
            system.assertEquals(1, accounts.size(), 'Expected 1 account to be created');
        Test.stopTest();
    }

}