@isTest
private class AptActionTestCreate {  
    @isTest static void ShouldCreateAptAction() {
        // TO DO: implement unit test
        //List<Appointment__c > appointmentId= [SELECT Id FROM Appointment__c];
        List<User> userId= [SELECT Id FROM User WHERE Alias = 'jblak' LIMIT 1];
        //System.assert(appointmentId.size() > 0, 'No Appointment records found.');
        System.assert(userId.size() > 0, 'User with alias "jblak" not found.');
        //Arrange
        Case newcase = new Case();
        insert newcase;
        Appointment__c newapt = new Appointment__c();
        newapt.Consult_Case__c = newcase.Id;
        insert newapt;
        MetricsContract contract = new MetricsContract();
        contract.recordId = newapt.Id;
        contract.action = 'Rescheduled';
        contract.userId = userId[0].Id;

      
        //Action
        MetricsHandler.execute(contract);
        //Assert
        List<Appointment_Action__c> aptAction = [SELECT Id, Name, Action_Type__c, Appointment_Id__c FROM Appointment_Action__c];
        System.Assert.isTrue(aptAction.size() > 0, 'No Appointment Action records found.');


        
    }

@isTest static void ShouldCreateCaseAction() {
    List<User> userId= [SELECT Id FROM User WHERE Alias = 'jblak' LIMIT 1];
    System.assert(userId.size() > 0, 'User with alias "jblak" not found.');

    //Arrange
    Case newcase = new Case();
    insert newcase;
    MetricsContract Contract = new MetricsContract();
    contract.recordId = newcase.Id;
    contract.action = 'Case Assignment';
    contract.userId = userId[0].Id;

    //Action
    MetricsHandler.execute(contract);
    //Assert
    List<Case_Action__c> caseAction = [SELECT Id, Name, Action_Type__c FROM Case_Action__c];
    System.Assert.isTrue(caseAction.size() > 0, 'No Case  Action records found.');



}

@isTest static void ShouldCreateClaimAction() {
    List<User> userId= [SELECT Id FROM User WHERE Alias = 'jblak' LIMIT 1];
    System.assert(userId.size() > 0, 'User with alias "jblak" not found.');

    //Arrange
    Claim__c newclaim = new Claim__c();
    insert newclaim;
    MetricsContract Contract = new MetricsContract();
    contract.recordId = newclaim.Id;
    contract.action = 'Adjudication';
    contract.userId = userId[0].Id;

    //Action
    MetricsHandler.execute(contract);
    //Assert
    List<Claim_Action__c> claimAction = [SELECT Id, Name, Action_Type__c FROM Claim_Action__c];
    System.Assert.isTrue(claimAction.size() > 0, 'No Claim Action records found.');


}
@isTest static void ShouldNotCreateAnyRecords(){
    Contact newcontact = new Contact();
    newcontact.LastName = 'Justin';
    newcontact.FirstName = 'Blakey';
    insert newcontact;

    MetricsContract Contract = new MetricsContract();
    Contract.recordId = newcontact.Id;


    MetricsHandler.execute(Contract);


}
}