@isTest
private class LabTools_User_Tests
{
	@isTest static void WhenCheckingIfAdmin_ShouldNotFail()
	{
		LabTools_User user = new LabTools_User();
		Test.startTest();
		user.IsSystemAdmin();
		Test.stopTest();
	}
}