public class litmosLearningPathUpdateSingleUse {
    private static final Litmos__Configuration__c config = [SELECT Litmos__Api_Key__c, Litmos__Api_End_Point__c FROM Litmos__Configuration__c WHERE isDeleted = false AND Litmos__Sync_Active__c = true];

    public static void litmosLPUpdatesSingleUse() {
        //get all learning paths
        List<Litmos__LearningPath__c> paths = [SELECT Id,Name,Litmos_Full_Id__c,Litmos__Description__c,Litmos__Active__c FROM Litmos__LearningPath__c];

        //uncomment this section to retrieve info from your org if it's been entered.
        //String apikey = config.Litmos__Api_Key__c;
        //String endpoint = config.Litmos__Api_End_Point__c + 'learningpaths?source=sourceapp&format=json&search=';

        //replace the apikey here with the apikey Litmos org you wish to pull learning path data from. 
        //feel free to add &limit=XX to pull a limited number of learning paths into Salesforce OR prevent limits from being hit from Litmos. See Overview Developer API from Litmos for information.
        String apikey='apikey';
        String endpoint = 'https://api.litmos.com/v1.svc/learningpaths?source=sourceapp&format=json&search=';
        for(Litmos__LearningPath__c path : paths) {
            //external callout
            String pathNoSpaces = path.Name.replace(' ', '_');
            HttpResponse response = litmosConnection.getLitmosExternalService(endpoint + pathNoSpaces, apikey);
            if(response.getStatusCode() == 200) {
                List<Object> results = (List<Object>)JSON.deserializeUntyped(response.getBody());
                for(Object o : results) {
					Map<String,Object> obj = (Map<String,Object>) o;
                    path.Litmos__Active__c = Boolean.valueOf(obj.get('Active'));
                    path.Litmos__Description__c = String.valueOf(obj.get('Description'));
                    path.Litmos_Full_Id__c  = String.valueOf(obj.get('Id'));
                }
            }
        }
        
        //this section logs info about each run into a custom object called Litmos_Sync_Logs__c. It may be uploaded at a later time. Comment out as desired.
        Set<Id> lpSuccess = new Set<Id>();
        Set<Id> lpErrors = new Set<Id>();
        Map<Id,String> errors = new Map<Id,String>();
        List<Database.SaveResult> sr = Database.update(paths, false);
        for(Database.SaveResult r : sr) {
            if(r.isSuccess()) {
             	lpSuccess.add(r.getId());   
            } else {
				lpErrors.add(r.getId());
                errors.put(r.getId(), String.valueOf(r.getErrors()));
            }
		}
        if(lpSuccess.size() > 0) {
			litmosSyncLogs.logPathSucccess(lpSuccess);
        }
        if(lpErrors.size() > 0) {
            litmosSyncLogs.logPathErrors(lpErrors, errors);
        }
    }
}