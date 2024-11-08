/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
public class AppointmentTestCreation {

    @isTest
    static void myUnitTest() {
        // TO DO: implement unit test
        Appointment_Action__c appointment	= new Appointment_Action__c	(Name = 'Test', Action_Type__c = 'Appointment Action Created', Action_Date__c = Datetime.now(), Appointment_Id__c = ' a2Ucn00000040W5EAI', User_Id__c = '2F005Hp00000flaWgIAI');
        insert appointment;

        MetricsContract contract = new MetricsContract();
        contract.recordId = appointment.Id;
        contract.action = 'Appointment Action Created';
        contract.userId = UserInfo.getUserId();
        
        MetricsHandler.execute(contract);

        List<Appointment_Action__c> appointmentActionList = [SELECT Id, Name, Action_Type__c, Action_Date__c, Appointment_Id__c, User_Id__c FROM Appointment_Action__c];

        System.assert(action.size() > 0, 'Something went wrong');
        System.assertEquals('Test Action', actions[0].Action_Type__c, 'Something went wrong');
    }
}

