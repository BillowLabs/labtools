public with sharing class LabTools_TriggerHandlerFactory {

	public LabTools_ITriggerHandler CreateHandler(SObjectType sType) {
		if (TestHandler != null) return TestHandler;

		// Find all the registered handlers for the type
		List<LabTools_ITriggerHandler> handlers = new List<LabTools_ITriggerHandler>();
		List<ApexClass> classes = [SELECT name FROM ApexClass];
		for(ApexClass c : classes) {

			Type t = Type.forName(c.Name);
			//For some reason test classes return null here
			if (t == null) continue;

			try {

				Object obj = t.newInstance();
				LabTools_ITriggerHandler handler = (LabTools_ITriggerHandler)obj;
				if (handler.IsForType(sType) == false) continue;

				handlers.add(handler);

			} catch(Exception ex) {
				continue;
			}
		}

		String msg = 'One and only one handler should be registered for: ' + sType +'. Registered handlers: ' + handlers;
		if (handlers.size() != 1) throw new LabTools_ApplicationException(msg);

		return handlers[0];
	}




	public LabTools_TriggerHandlerFactory() {
	}

	@TestVisible LabTools_TriggerHandlerFactory(Boolean ignoreTestMode) {
		// As this class is intended to be called from a trigger,
		// we will set a mock test handler automatically when testing.
		if(Test.isRunningTest() && ignoreTestMode != true) {
			TestHandler = new LabTools_TriggerHandlerMock();
		}
	}


	@TestVisible private LabTools_ITriggerHandler TestHandler { get; set; }
}