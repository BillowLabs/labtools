global interface LabTools_ILogger {
	// NOTE: Date and Datetime have seperate methods
	// because converting either to object before passing them to String.value
	// produces diffrent results than passing them as Date and Datetime

	void Log(String value);
	void Log(Date value);
	void Log(Datetime value);
	void Log(Object value);

	void Log(String title, String value);
	void Log(String title, Date value);
	void Log(String title, Datetime value);
	void Log(String title, Object value);
}