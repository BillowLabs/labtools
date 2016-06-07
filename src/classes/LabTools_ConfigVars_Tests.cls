@isTest
private class LabTools_ConfigVars_Tests
{
	@isTest
	static void WhenIntegrating_ShouldReturnValue()
	{
		LabTools_ConfigVar__c var = new LabTools_ConfigVar__c(
			Name = 'Test Setting',
			Value__c = 'Test!'
		);
		insert var;

		LabTools_ConfigVars vars = new LabTools_ConfigVars();


		Test.startTest();
		String value = vars.Read('Test Setting');
		Test.stopTest();

		System.assertEquals('Test!', value);
	}


	@isTest
	static void WhenIntegrating_ShouldReturnValues()
	{
		LabTools_ConfigVar__c varOne = new LabTools_ConfigVar__c(
			Name = 'Test One',
			Value__c = 'Test 1'
		);

		LabTools_ConfigVar__c varTwo = new LabTools_ConfigVar__c(
			Name = 'Test Two',
			Value__c = 'Test 2'
		);

		insert new List<LabTools_ConfigVar__c> {varOne, varTwo};


		List<String> keys = new List<String> {varOne.Name, varTwo.Name};

		LabTools_ConfigVars vars = new LabTools_ConfigVars();

		Test.startTest();
		Map<String, String> values = vars.ReadAll(keys);
		Test.stopTest();

		System.assertEquals(2, values.size());
		System.assertEquals('Test 1', values.get('Test One'));
		System.assertEquals('Test 2', values.get('Test Two'));
	}

}