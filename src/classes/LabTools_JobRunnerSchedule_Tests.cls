@isTest
private class LabTools_JobRunnerSchedule_Tests
{
	@isTest static void WhenConstructing_ShouldNotFail()
	{
		// Because LabTools_JobRunnerSchedule loads the job it runs dynamically,
		// the purpose of this class is to test that the job exists.
		// JobRunner needs to be tested independantly so look to JobRunner_Tests
		// to confirm it is tested correctly.

		Test.startTest();
		LabTools_JobRunnerSchedule schedule = new LabTools_JobRunnerSchedule();
		Test.stopTest();
	}


	@isTest static void WhenExecuting_ShouldExecuteSchedulableOnce()
	{
		TestSchedulable schedulable = new TestSchedulable();
		LabTools_JobRunnerSchedule schedule = new LabTools_JobRunnerSchedule(schedulable);

		Test.startTest();
		schedule.execute(null);
		Test.stopTest();

		System.assertEquals(1, schedulable.ExecuteCount);
	}


	private class TestSchedulable implements LabTools_ISchedulable {
		Integer ExecuteCount = 0;

		public void execute() {
			ExecuteCount++;
		}
	}
}