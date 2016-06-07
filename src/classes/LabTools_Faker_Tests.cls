@isTest
private class LabTools_Faker_Tests
{
	@isTest
	static void WhenGettingFakeId_ShouldMatchSalesforcePattern()
	{
		Test.startTest();
		Id fakeAccountId = LabTools_Faker.GetId(Account.SObjectType);
		Test.stopTest();

		System.assertEquals('001000000000001AAA', fakeAccountId);
	}
}