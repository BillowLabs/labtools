// To Run Every Hour: System.schedule('JobRunnerSchedule', '0 0 * * * ?', new JobRunnerSchedule());
// SEE: http://salesforce.stackexchange.com/questions/16337/schedule-hourly-batch-using-cron-expression-start-on-abritrary-day-of-month

global class LabTools_JobRunnerSchedule implements Schedulable {

	global void execute(SchedulableContext sc) {
		schedulable.execute();
	}

	global LabTools_JobRunnerSchedule() {
		schedulable = (LabTools_ISchedulable)Type.forName('LabTools_JobRunner').NewInstance();
	}

	@TestVisible private LabTools_JobRunnerSchedule(LabTools_ISchedulable s)
	{
		schedulable = s;
	}

	private LabTools_ISchedulable schedulable;
}