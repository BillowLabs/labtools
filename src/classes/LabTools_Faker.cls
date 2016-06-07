global class LabTools_Faker {

	static Integer fakeIdCount = 1;
	global static String GetId(Schema.SObjectType sot)
	{
		 String count = String.valueOf(fakeIdCount++);
		 return sot.getDescribe().getKeyPrefix() + '0'.repeat(12-count.length()) + count;
	}
}