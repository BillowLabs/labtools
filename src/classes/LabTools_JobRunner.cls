global class LabTools_JobRunner implements LabTools_ISchedulable {

	global void execute() {

		if (now == null) now = DateTime.now();
		List<LabTools_Runner__c> runners = repository.Echo([
			SELECT Name, RecurrenceType__c, RecurrenceRate__c, (SELECT Name, Enabled__c FROM Jobs__r)
			FROM LabTools_Runner__c
			WHERE StartOn__c <= :now
				AND (NextRunOn__c = NULL OR NextRunOn__c <= :now)
			ORDER BY NextRunOn__c DESC
			LIMIT 5
		]);

		for(LabTools_Runner__c runner : runners) {

			DateTime next;
			if (runner.RecurrenceType__c == 'Hours') {
				next = now.addHours((Integer)runner.RecurrenceRate__c);
			} else if (runner.RecurrenceType__c == 'Days') {
				next = now.addDays((Integer)runner.RecurrenceRate__c);
			} else if (runner.RecurrenceType__c == 'Months') {
				next = now.addMonths((Integer)runner.RecurrenceRate__c);
			} else if (runner.RecurrenceType__c == 'Years') {
				next = now.addYears((Integer)runner.RecurrenceRate__c);
			}

			runner.LastRunOn__c = now;
			runner.NextRunOn__c = next;

			for(LabTools_Job__c job : runner.Jobs__r) {
				if (job.Enabled__c == false) continue;
				Database.executebatch(new LabTools_JobWrapper(job.Name));
			}

		}

		repository.Modify(runners);
	}



	global LabTools_JobRunner() {
		repository = new LabTools_Repository();
	}

	@TestVisible private LabTools_JobRunner(LabTools_IRepository r, DateTime n)
	{
		repository = r;
		now = n;
	}



	private LabTools_IRepository repository;
	private DateTime now;

}