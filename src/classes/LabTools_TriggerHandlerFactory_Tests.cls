@isTest
private class LabTools_TriggerHandlerFactory_Tests {

	@isTest static void WhenConstructingWithoutArguments_ShouldNotFail() {
		Test.startTest();
		LabTools_TriggerHandlerFactory factory = new LabTools_TriggerHandlerFactory();
		Test.stopTest();
	}

	@isTest static void WhenConstructingAndNoHandlerExists_ShouldFail() {

		// Unlike typical test methods and costructors, here we are passing true to ignore Test mode
		// so that the factory behaves normally.  This is because we create a test handler
		// whenever a test is running by default.
		// However, to test the create method, we must override that behavior.
		LabTools_TriggerHandlerFactory factory = new LabTools_TriggerHandlerFactory(true);

		Test.startTest();
		LabTools_ApplicationException error;
		try {
			LabTools_ITriggerHandler handler = factory.CreateHandler(Account.SObjectType);
		} catch (LabTools_ApplicationException ex) {
			error = ex;
		}
		Test.stopTest();

		System.assert(error != null);
	}

}
