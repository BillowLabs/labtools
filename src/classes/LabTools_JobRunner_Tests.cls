@isTest
private class LabTools_JobRunner_Tests {

	@isTest static void WhenHours_ShouldSetNextRunInHours() {
		TestRepo repo = new TestRepo('Hours', 2);
		Datetime now = Datetime.now();
		LabTools_JobRunner jRunner = new LabTools_JobRunner(repo, now);

		Test.startTest();
		jRunner.execute();
		Test.stopTest();

		System.assertEquals(1, repo.EchoCalled);
		System.assertEquals(1, repo.ModifyCalled);
		System.assertEquals(1, repo.Modified.size());
		System.assertEquals(now.addHours(2), ((LabTools_Runner__c)repo.Modified[0]).NextRunOn__c);
	}


	@isTest static void WhenDays_ShouldSetNextRunInDays() {
		TestRepo repo = new TestRepo('Days', 3);
		Datetime now = Datetime.now();
		LabTools_JobRunner jRunner = new LabTools_JobRunner(repo, now);

		Test.startTest();
		jRunner.execute();
		Test.stopTest();

		System.assertEquals(1, repo.EchoCalled);
		System.assertEquals(1, repo.ModifyCalled);
		System.assertEquals(1, repo.Modified.size());
		System.assertEquals(now.addDays(3), ((LabTools_Runner__c)repo.Modified[0]).NextRunOn__c);
	}


	@isTest static void WhenMonths_ShouldSetNextRunInMonths() {
		TestRepo repo = new TestRepo('Months', 4);
		Datetime now = Datetime.now();
		LabTools_JobRunner jRunner = new LabTools_JobRunner(repo, now);

		Test.startTest();
		jRunner.execute();
		Test.stopTest();

		System.assertEquals(1, repo.EchoCalled);
		System.assertEquals(1, repo.ModifyCalled);
		System.assertEquals(1, repo.Modified.size());
		System.assertEquals(now.addMonths(4), ((LabTools_Runner__c)repo.Modified[0]).NextRunOn__c);
	}


	@isTest static void WhenYears_ShouldSetNextRunInYears() {
		TestRepo repo = new TestRepo('Years', 5);
		Datetime now = Datetime.now();
		LabTools_JobRunner jRunner = new LabTools_JobRunner(repo, now);

		Test.startTest();
		jRunner.execute();
		Test.stopTest();

		System.assertEquals(1, repo.EchoCalled);
		System.assertEquals(1, repo.ModifyCalled);
		System.assertEquals(1, repo.Modified.size());
		System.assertEquals(now.addYears(5), ((LabTools_Runner__c)repo.Modified[0]).NextRunOn__c);
	}


	@isTest static void WhenIntegrating_ShouldNotFailRun() {
		LabTools_Runner__c runner = new LabTools_Runner__c(
			Name = 'Test',
			RecurrenceRate__c = 1,
			RecurrenceType__c = 'Hours',
			StartOn__c = Datetime.now()
		);
		insert runner;

		List<LabTools_Job__c> testJobs = new List<LabTools_Job__c>();
		testJobs.add(new LabTools_Job__c(
			Name = LabTools_HeartbeatJob.class.getName(),
			Runner__c = runner.Id
		));
		insert testJobs;

		LabTools_JobRunner jRunner = new LabTools_JobRunner();

		Test.startTest();
		jRunner.execute();
		Test.stopTest();
	}




	private class TestRepo extends LabTools_RepositoryTestStub {

		public Integer EchoCalled = 0;
		public override List<SObject> Echo(List<SObject> values) {
			EchoCalled++;
			return new List<LabTools_Runner__c> {
				new LabTools_Runner__c(
					RecurrenceType__c = recurrenceType,
					RecurrenceRate__c = recurrenceRate
				)
			};
		}

		public Integer ModifyCalled = 0;
		public List<SObject> Modified;
		public override void Modify(List<SObject> values) {
			ModifyCalled++;
			Modified = values;
		}


		public TestRepo(String t, Decimal r) {
			recurrenceType = t;
			recurrenceRate = r;
		}

		private String recurrenceType;
		private Decimal recurrenceRate;
	}

}