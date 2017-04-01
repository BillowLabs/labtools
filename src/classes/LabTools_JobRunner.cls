global class LabTools_JobRunner implements LabTools_ISchedulable {

	global void execute() {

		if (now == null) now = DateTime.now();
		List<LabTools_IEntity> runners = repository.Echo([
			SELECT Name, RecurrenceType__c, RecurrenceRate__c, LastRunOn__c, (SELECT Name, Enabled__c FROM Jobs__r)
			FROM LabTools_Runner__c
			WHERE StartOn__c <= :now
				AND (NextRunOn__c = NULL OR NextRunOn__c <= :now)
			ORDER BY NextRunOn__c DESC
			LIMIT 5
		]);

		for(LabTools_IEntity runner : runners) {

			DateTime next;
			String type = (String)runner.get(LabTools_Runner__c.RecurrenceType__c);
			Integer rate = ((Decimal)runner.get(LabTools_Runner__c.RecurrenceRate__c)).IntValue();

			if (type == 'Hours') {
				next = now.addHours(rate);
			} else if (type == 'Days') {
				next = now.addDays(rate);
			} else if (type == 'Months') {
				next = now.addMonths(rate);
			} else if (type == 'Years') {
				next = now.addYears(rate);
			}

			runner.set(LabTools_Runner__c.LastRunOn__c, now);
			runner.set(LabTools_Runner__c.NextRunOn__c, next);

			List<LabTools_IEntity> jobs = runner.getChildren('Jobs__r');

			for(LabTools_IEntity job : jobs) {
				Boolean isEnabled = (Boolean)job.get(LabTools_Job__c.Enabled__c);
				if (isEnabled == false) continue;

				String name = (String)job.get(LabTools_Job__c.Name);
				Database.executebatch(new LabTools_JobWrapper(name));
			}

		}

		repository.save();
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
