public with sharing class CreateMetric {
    @InvocableMethod
    public static void execute(List<Requests> requests) {
        for (Requests request : requests) {
            MetricsHandler.execute(request.contract);
        }
}
public class Requests {
    @InvocableVariable
    public MetricsContract contract;


}} 