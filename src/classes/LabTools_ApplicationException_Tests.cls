@isTest
private class LabTools_ApplicationException_Tests
{
	@isTest static void WhenConstructing_ShouldNotFail()
	{
		Test.startTest();
		LabTools_ApplicationException ex = new LabTools_ApplicationException();
		Test.stopTest();
	}
}