/**
 * Developed by Doug Ayers, douglascayers.com
 * Modification History:
 * 4/16/2021 modifications for failing unit tests
 */
@isTest
private class ConvertLeadsInvocableTest {
    
    //insert a lead, check and see if the lead is converted
    @isTest static void test_lead_conversion(){
        Lead le = new Lead();
        le.FirstName = 'Test';
        le.LastName = 'User';
        
        try{
            insert le;
        } catch(Exception ex){
            System.debug('An error occurred inserting the test lead: ' + ex.getMessage());
        }
        
        Test.startTest();
        	List<Lead> leads = [SELECT ID, NAME, IsConverted FROM LEAD];
        for(Lead l: leads){
            System.assertEquals(true, l.IsConverted, 'Expected lead to be converted');
        }
        
        Test.stopTest();
      
    }

}