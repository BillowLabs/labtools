global class LabTools_Moment implements LabTools_IMoment {
	public Date Today() {
		return Date.today();
	}

	public DateTime Now() {
		return Datetime.now();
	}
}