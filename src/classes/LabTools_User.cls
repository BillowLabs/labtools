global class LabTools_User implements LabTools_IUser {
	public Boolean IsSystemAdmin() {
		// Determine if the user is a System Administrator
		Id pId = UserInfo.GetProfileId();
		return [
			SELECT Name
			FROM Profile
			WHERE Id = :pId AND Name = 'System Administrator'
		].size() > 0;
	}
}