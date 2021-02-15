@isTest
public class litmosLearningPathUpdateSingleUseTEST {
	@testSetup
    static void setup() {
        //insert configuration
        insert new Litmos__Configuration__c(
        	Litmos__Api_Key__c = 'abcde',
            Litmos__Api_End_Point__c = 'https://api.litmos.com/v1.svc/',
            Litmos__Sync_Active__c = true
        );
        
        //insert single learning path
        insert new Litmos__LearningPath__c(
        	Name='My Test Learning Path',
            Litmos__LitmosId__c = '123456',
            Litmos__Active__c = false
        );            
    }
    @isTest
    static void testLearningPathUpdates() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('litmosLearningPathFullData');
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mock);
        litmosLearningPathUpdateSingleUse.litmosLPUpdatesSingleUse();
        Test.stopTest();
        System.assertEquals(1, [SELECT count() FROM Litmos__LearningPath__c WHERE Litmos_Full_Id__c = 'aBcDe' AND Litmos__Active__c = true]);
        System.assertEquals('This is a test description',[SELECT Litmos__Description__c FROM Litmos__LearningPath__c].Litmos__Description__c);
    }
}