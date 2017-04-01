global class LabTools_Logger implements LabTools_ILogger {

	public void Log(String value) {
		Log(LoggingLevel.DEBUG, null, value);
	}

	public void Log(Date value) {
		Log(LoggingLevel.DEBUG, null, string.valueOf(value));
	}

	public void Log(Datetime value) {
		Log(LoggingLevel.DEBUG, null, string.valueOf(value));
	}

	public void Log(Object value) {
		Log(LoggingLevel.DEBUG, null, String.valueOf(value));
	}




	public void Log(String title, String value) {
		Log(LoggingLevel.DEBUG, title, value);
	}

	public void Log(String title, Date value) {
		Log(LoggingLevel.DEBUG, title, string.valueOf(value));
	}

	public void Log(String title, Datetime value) {
		Log(LoggingLevel.DEBUG, title, string.valueOf(value));
	}

	public void Log(String title, Object value) {
		Log(LoggingLevel.DEBUG, title, String.valueOf(value));
	}



	public void Log(LoggingLevel level, String title, String msg) {
		String value = msg;
		if (title != null && title != '') value = title + ': ' + msg;

		System.debug(value);
		AsyncLog(level.name(), value);
	}

	@future private static void AsyncLog(String level, String value) {
		Log__c log = new Log__c(
			Level__c = level,
			Value__c = value
		);
		repository.Create(log);
	}




	global LabTools_Logger() {
		if (repository != null) return;
		repository = new LabTools_Repository();
	}

	@TestVisible private LabTools_Logger(LabTools_IRepository r)
	{
		repository = r;
	}

	private static LabTools_IRepository repository;

}
