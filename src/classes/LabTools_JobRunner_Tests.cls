@isTest
private class LabTools_JobRunner_Tests {


	@isTest static void WhenNoJobsExist_ShouldDoNothing() {
		LabTools_RepositoryMock repo = new LabTools_RepositoryMock();
		LabTools_JobRunner jRunner = new LabTools_JobRunner(repo, Datetime.now());

		Test.startTest();
		jRunner.execute();
		Test.stopTest();

		List<LabTools_IEntity> modified = repo.GetModified(LabTools_Runner__c.SObjectType);
		System.assertEquals(0, modified.size());
	}


	@isTest static void WhenHours_ShouldSetNextRunInHours() {
		LabTools_RepositoryMock repo = new LabTools_RepositoryMock();
		repo
			.Create(LabTools_Runner__c.SObjectType)
			.Set(LabTools_Runner__c.RecurrenceType__c, 'Hours')
			.Set(LabTools_Runner__c.RecurrenceRate__c, 2)
			.SetStatus(LabTools_EntityStatus.None)
			.AddChild('Jobs__r',
				repo.Create(LabTools_Job__c.SObjectType)
				.Set(LabTools_Job__c.Enabled__c, true)
				.Set(LabTools_Job__c.Name, 'LabTools_HeartbeatJob')
				.SetStatus(LabTools_EntityStatus.None)
			);

		Datetime now = Datetime.now();
		LabTools_JobRunner jRunner = new LabTools_JobRunner(repo, Datetime.now());

		Test.startTest();
		jRunner.execute();
		Test.stopTest();

		List<LabTools_IEntity> modified = repo.GetModified(LabTools_Runner__c.SObjectType);
		System.assertEquals(1, modified.size());
		System.assertEquals(now.addHours(2), modified[0].get(LabTools_Runner__c.NextRunOn__c));
	}


	@isTest static void WhenDays_ShouldSetNextRunInDays() {
		LabTools_RepositoryMock repo = new LabTools_RepositoryMock();
		repo
			.Load(LabTools_Runner__c.SObjectType)
			.Set(LabTools_Runner__c.RecurrenceType__c, 'Days')
			.Set(LabTools_Runner__c.RecurrenceRate__c, 3)
			.SetStatus(LabTools_EntityStatus.None)
			.AddChild('Jobs__r',
				repo.Load(LabTools_Job__c.SObjectType)
				.Set(LabTools_Job__c.Enabled__c, true)
				.Set(LabTools_Job__c.Name, 'LabTools_HeartbeatJob')
				.SetStatus(LabTools_EntityStatus.None)
			);

		Datetime now = Datetime.now();
		LabTools_JobRunner jRunner = new LabTools_JobRunner(repo, now);

		Test.startTest();
		jRunner.execute();
		Test.stopTest();

		System.assertEquals(1, repo.SaveCalled);

		List<LabTools_IEntity> modified = repo.GetModified(LabTools_Runner__c.SObjectType);
		System.assertEquals(1, modified.size());
		System.assertEquals(now.addDays(3), modified[0].get(LabTools_Runner__c.NextRunOn__c));
	}


	@isTest static void WhenMonths_ShouldSetNextRunInMonths() {
		LabTools_RepositoryMock repo = new LabTools_RepositoryMock();
		repo
			.Load(LabTools_Runner__c.SObjectType)
			.Set(LabTools_Runner__c.RecurrenceType__c, 'Months')
			.Set(LabTools_Runner__c.RecurrenceRate__c, 4)
			.SetStatus(LabTools_EntityStatus.None)
			.AddChild('Jobs__r',
				repo.Load(LabTools_Job__c.SObjectType)
				.Set(LabTools_Job__c.Enabled__c, true)
				.Set(LabTools_Job__c.Name, 'LabTools_HeartbeatJob')
				.SetStatus(LabTools_EntityStatus.None)
			);

		Datetime now = Datetime.now();
		LabTools_JobRunner jRunner = new LabTools_JobRunner(repo, now);

		Test.startTest();
		jRunner.execute();
		Test.stopTest();

		System.assertEquals(1, repo.SaveCalled);

		List<LabTools_IEntity> modified = repo.GetModified(LabTools_Runner__c.SObjectType);
		System.assertEquals(1, modified.size());
		System.assertEquals(now.addMonths(4), modified[0].get(LabTools_Runner__c.NextRunOn__c));
	}


	@isTest static void WhenYears_ShouldSetNextRunInYears() {
		LabTools_RepositoryMock repo = new LabTools_RepositoryMock();
		repo
			.Load(LabTools_Runner__c.SObjectType)
			.Set(LabTools_Runner__c.RecurrenceType__c, 'Years')
			.Set(LabTools_Runner__c.RecurrenceRate__c, 5)
			.SetStatus(LabTools_EntityStatus.None)
			.AddChild('Jobs__r',
				repo.Load(LabTools_Job__c.SObjectType)
				.Set(LabTools_Job__c.Enabled__c, true)
				.Set(LabTools_Job__c.Name, 'LabTools_HeartbeatJob')
				.SetStatus(LabTools_EntityStatus.None)
			);

		Datetime now = Datetime.now();
		LabTools_JobRunner jRunner = new LabTools_JobRunner(repo, now);

		Test.startTest();
		jRunner.execute();
		Test.stopTest();

		System.assertEquals(1, repo.SaveCalled);

		List<LabTools_IEntity> modified = repo.GetModified(LabTools_Runner__c.SObjectType);
		System.assertEquals(1, modified.size());
		System.assertEquals(now.addYears(5), modified[0].get(LabTools_Runner__c.NextRunOn__c));
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

}
