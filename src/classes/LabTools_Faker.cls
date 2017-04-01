global class LabTools_Faker {

	static Integer fakeIdCount = 1;
	global static String GetId(Schema.SObjectType sType)
	{
		 String count = String.valueOf(fakeIdCount++);
		 return  sType.getDescribe().getKeyPrefix() + '0'.repeat(12-count.length()) + count;
	}

	// global static String Guid() {
	// 	// See: https://developer.salesforce.com/forums/?id=906F000000092N0IAI
	// 	Blob b = Crypto.GenerateAESKey(128);
	// 	String h = EncodingUtil.ConvertTohex(b);
	// 	String guid = h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.substring(20);
	// 	return guid;
	// }
}
