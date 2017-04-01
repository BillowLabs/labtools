@isTest
private class LabTools_HttpClientMock_Tests
{
	@isTest static void WhenConstructing_ShouldZeroProperties()
	{
		Test.startTest();
		LabTools_HttpClientMock mock = new LabTools_HttpClientMock();
		Test.stopTest();

		System.assertEquals(0, mock.SendCalled);
		System.assertEquals(0, mock.FutureCalled);
		System.assertEquals(0, mock.ResponseMap.size());
		System.assertEquals(0, mock.FutureRequests.size());
	}
}