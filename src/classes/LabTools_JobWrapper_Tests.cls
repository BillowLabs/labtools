@isTest
private class LabTools_JobWrapper_Tests
{
	@isTest static void WhenConstructingIJob_ShouldNotFail()
	{
		Test.startTest();
		LabTools_JobWrapper wrapper = new LabTools_JobWrapper('LabTools_HeartbeatJob');
		Test.stopTest();
	}

	@isTest static void WhenNotConstructingIJob_ShouldFail()
	{
		Exception error;
		Test.startTest();
		try {
			LabTools_JobWrapper wrapper = new LabTools_JobWrapper('Account');
		} catch(Exception ex) {
			error = ex;
		}
		Test.stopTest();

		System.assert(error != null);
	}

	@isTest static void WhenStarting_ShouldCallJobQuery()
	{
		TestJob job = new TestJob();
		LabTools_JobWrapper wrapper = new LabTools_JobWrapper(job);

		Test.startTest();
		wrapper.start(null);
		Test.stopTest();

		System.assertEquals(1, job.QueryCalled);
		System.assertEquals(0, job.ProcessCalled);
	}

	@isTest static void WhenProcessing_ShouldCallJobProcess()
	{
		TestJob job = new TestJob();
		LabTools_JobWrapper wrapper = new LabTools_JobWrapper(job);
		List<Account> accounts = new List<Account>();

		Test.startTest();
		wrapper.execute(null, accounts);
		Test.stopTest();

		System.assertEquals(0, job.QueryCalled);
		System.assertEquals(1, job.ProcessCalled);
		System.assertEquals(accounts, job.ProcessSelected);
	}




	private class TestJob implements LabTools_IJob {
		public Integer QueryCalled {get; set;}
		public Integer ProcessCalled {get; set;}
		public List<Object> ProcessSelected {get; set;}

		public Database.QueryLocator Query() {
			QueryCalled++;
			return null;
		}

		public void Process(List<sObject> selected) {
			ProcessSelected = selected;
			ProcessCalled++;
		}

		public TestJob() {
			QueryCalled = 0;
			ProcessCalled = 0;
		}
	}

}
