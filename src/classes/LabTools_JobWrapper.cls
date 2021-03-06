global class LabTools_JobWrapper implements Database.Batchable<sObject> {

	global Database.QueryLocator start(Database.BatchableContext BC) {
		return job.Query();
	}

	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		job.Process(scope);
	}

	global void finish(Database.BatchableContext BC) {
		// TODO: Record errors, record start time, record last error, etc.
		// job.LabTools__LastRunOn__c = now;
		// job.LabTools__LastError__c = '';
		// job.LabTools__LastError__c = ex.getMessage();
	}



	global LabTools_JobWrapper(String name) {
		job = (LabTools_IJob)Type.forName(name).NewInstance();
	}
	@TestVisible private LabTools_JobWrapper(LabTools_IJob j)
	{
		job = j;
	}

	private LabTools_IJob job;
}