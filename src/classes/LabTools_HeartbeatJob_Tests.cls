@isTest
private class LabTools_HeartbeatJob_Tests
{


	@isTest static void WhenStarts_ShouldReturnLocator()
	{
		LabTools_HeartbeatJob job = new LabTools_HeartbeatJob();

		Test.startTest();
		Database.QueryLocator locator = job.Query();
		Test.stopTest();

		System.assert(locator != null);
	}


	@isTest static void WhenProcesses_ShouldNotFail()
	{
		LabTools_HeartbeatJob job = new LabTools_HeartbeatJob();

		Test.startTest();
		job.Process(new List<LabTools_Job__c>());
		Test.stopTest();

		System.assert(true);
	}

}