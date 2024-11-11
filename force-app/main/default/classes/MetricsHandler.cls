public with sharing class MetricsHandler {
    public static void execute(MetricsContract contract) {
        try {
            String objectName = getObjectApiName(contract.recordId);
            if(objectName == 'Appointment__c'){
            MetricsHandler.createAppointmentMetricRecord(contract);
                
            }else if(objectName == 'Case'){
                MetricsHandler.createCaseMetricRecord(contract);
            }else if(objectName == 'Claim__c'){
                MetricsHandler.createClaimMetricRecord(contract);
            }else{
               // throw new Exception('Invlid object type');
               System.debug('Invalid object type');
            }
            
        } catch (Exception ex) {
            CaughtException.logException(ex);
            
        }
        

    }

    private static String getObjectApiName(Id recordId){
        return recordId.getSObjectType().getDescribe().getName();
    }
    
    private static void createAppointmentMetricRecord(MetricsContract contract ){
        List<Appointment__c> appointmentId= [SELECT Id, Status__c, Prison_Account__c, Priority__c, Type__c, Provider_Account__c,Specialty_Detail__c FROM Appointment__c WHERE Id = : contract.recordId LIMIT 1];
 
            appointment_Action__c appointmentAction = new appointment_Action__c();
            appointmentAction.Appointment_Id__c = contract.recordId;
            appointmentAction.Name = 'Appointment Action  ' + ' -  ' + contract.action;
            appointmentAction.Action_Type__c = contract.action;
            appointmentAction.Team_Member__c = contract.userId;
            appointmentAction.Date__c = System.today();
            appointmentAction.Appointment_Status__c	= appointmentId[0].Status__c;
            appointmentAction.Appointment_Priority__c = appointmentId[0].Priority__c;
            appointmentAction.Appointment_Type__c = appointmentId[0].Type__c;
            appointmentAction.Prison__c	 = appointmentId[0].Prison_Account__c;
            appointmentAction.Provider_Id__c = appointmentId[0].Provider_Account__c;
            appointmentAction.Specialty_Detail__c = appointmentId[0].Specialty_Detail__c;
        

            insert appointmentAction;
       
   }
   private static void createCaseMetricRecord(MetricsContract contract){
    List<Case> caseId= [SELECT Id, Status, RecordTypeId, Correctional_Facility__c  FROM Case WHERE Id = : contract.recordId LIMIT 1];
    List<RecordType> RecordType = [SELECT Id,Name,SobjectType,DeveloperName FROM RecordType WHERE Id = : caseId[0].RecordTypeId LIMIT 1];

     
            case_Action__c caseAction = new case_Action__c();
            caseAction.Case_Id__c = contract.recordId;
            caseAction.Name = 'Case Action' + ' - ' + contract.action;
            caseAction.Action_Type__c = contract.action;
            caseAction.Team_Member__c = contract.userId;
            caseAction.Date__c = System.today();
            caseAction.Prison__c = caseId[0].Correctional_Facility__c;
            caseAction.Record_Type__c = RecordType[0].DeveloperName;
            caseAction.Case_Status__c = caseId[0].Status;

            insert caseAction;
       
   }
   private static void createClaimMetricRecord(MetricsContract contract){
    List<Claim__c> claimId= [SELECT Id, Status__c, RecordTypeId, Facility_Name__c  FROM Claim__c WHERE Id = : contract.recordId LIMIT 1];
   // List<Account> accountId = [SELECT Id FROM Account WHERE Name = : claimId[0].Facility_Name__c LIMIT 1];
    List<RecordType> RecordType = [SELECT Id,Name,SobjectType,DeveloperName FROM RecordType WHERE Id = : claimId[0].RecordTypeId LIMIT 1];
    System.Assert(claimId.size() > 0, 'no record found');


       
            claim_Action__c claimAction = new claim_Action__c();
            claimAction.Claim_Id__c = contract.recordId;
            claimAction.Name = 'Claim Action ' + ' - ' + contract.action;
            claimAction.Action_Type__c = contract.action;
            claimAction.Team_Member__c = contract.userId;
            claimAction.Date__c = System.today();
            claimAction.Claim_Status__c = claimId[0].Status__c;
          //  claimAction.Prison__c = accountId[0].Id;
            claimAction.Record_Type__c = RecordType[0].DeveloperName;


            insert claimAction;
            
       
   }
}
    