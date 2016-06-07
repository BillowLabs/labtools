global interface LabTools_IJob {
	Database.QueryLocator Query();
	void Process(List<sObject> selected);
}