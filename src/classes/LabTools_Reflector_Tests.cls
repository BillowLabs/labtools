@isTest
private class LabTools_Reflector_Tests
{
	@isTest static void WhenTypeInfoOfBoolean_ShouldReturnBooleanType()
	{
		Object testMe = false;
		LabTools_Reflector reflector = new LabTools_Reflector();

		Test.startTest();
		List<Type> types = reflector.GetTypes(testMe);
		Test.stopTest();

		System.assertEquals('Boolean', types[0].getName());
	}


	@isTest static void WhenTypeInfoOfId_ShouldReturnIdType()
	{
		Object testMe = LabTools_Faker.GetId(Account.SObjectType);
		LabTools_Reflector reflector = new LabTools_Reflector();

		Test.startTest();
		List<Type> types = reflector.GetTypes(testMe);
		Test.stopTest();

		System.assertEquals('Id', types[0].getName());
	}

	@isTest static void WhenTypeInfoOfString_ShouldReturnStringType()
	{
		Object testMe = 'Test Me';
		LabTools_Reflector reflector = new LabTools_Reflector();

		Test.startTest();
		List<Type> types = reflector.GetTypes(testMe);
		Test.stopTest();

		System.assertEquals('String', types[0].getName());
	}

	@isTest static void WhenTypeInfoOfBlob_ShouldReturnBlobType()
	{
		Object testMe = Blob.valueOf('Test Me');
		LabTools_Reflector reflector = new LabTools_Reflector();

		Test.startTest();
		List<Type> types = reflector.GetTypes(testMe);
		Test.stopTest();

		System.assertEquals('Blob', types[0].getName());
	}

	@isTest static void WhenTypeInfoOfDate_ShouldReturnDateType()
	{
		Object testMe = Date.today();
		LabTools_Reflector reflector = new LabTools_Reflector();

		Test.startTest();
		List<Type> types = reflector.GetTypes(testMe);
		Test.stopTest();

		System.assertEquals('Date', types[0].getName());
	}

	@isTest static void WhenTypeInfoOfDatetime_ShouldReturnDatetimeType()
	{
		Object testMe = Datetime.now();
		LabTools_Reflector reflector = new LabTools_Reflector();

		Test.startTest();
		List<Type> types = reflector.GetTypes(testMe);
		Test.stopTest();

		System.assertEquals('Datetime', types[0].getName());
	}

	@isTest static void WhenTypeInfoOfTime_ShouldReturnTimeType()
	{
		Object testMe = Time.newInstance(0,0,0,0);
		LabTools_Reflector reflector = new LabTools_Reflector();

		Test.startTest();
		List<Type> types = reflector.GetTypes(testMe);
		Test.stopTest();

		System.assertEquals('Time', types[0].getName());
	}

	@isTest static void WhenTypeInfoOfLong_ShouldReturnLongType()
	{
		Object testMe = 0L;
		LabTools_Reflector reflector = new LabTools_Reflector();

		Test.startTest();
		List<Type> types = reflector.GetTypes(testMe);
		Test.stopTest();

		System.assertEquals('Long', types[0].getName());
	}

	@isTest static void WhenTypeInfoOfDouble_ShouldReturnDoubleType()
	{
		Object testMe = Double.valueOf('10.10');
		LabTools_Reflector reflector = new LabTools_Reflector();

		Test.startTest();
		List<Type> types = reflector.GetTypes(testMe);
		Test.stopTest();

		System.assertEquals('Double', types[0].getName());
	}

	@isTest static void WhenTypeInfoOfInteger_ShouldReturnIntegerType()
	{
		Object testMe = Integer.valueOf('10');
		LabTools_Reflector reflector = new LabTools_Reflector();

		Test.startTest();
		List<Type> types = reflector.GetTypes(testMe);
		Test.stopTest();

		System.assertEquals('Integer', types[0].getName());
	}

	@isTest static void WhenTypeInfoOfAccount_ShouldReturnAccountType()
	{
		Object testMe = new Account();
		LabTools_Reflector reflector = new LabTools_Reflector();

		Test.startTest();
		List<Type> types = reflector.GetTypes(testMe);
		Test.stopTest();

		System.assertEquals('Account', types[0].getName());
	}

	@isTest static void WhenTypeInfoOfLogger_ShouldReturnLoggerType()
	{
		Object testMe = new LabTools_Logger();
		LabTools_Reflector reflector = new LabTools_Reflector();

		Test.startTest();
		List<Type> types = reflector.GetTypes(testMe);
		Test.stopTest();

		System.assertEquals('LabTools_Logger', types[0].getName());
	}

	@isTest static void WhenTypeInfoOfIntegerList_ShouldReturnListType()
	{
		Object testMe = new List<Integer>();
		LabTools_Reflector reflector = new LabTools_Reflector();

		Test.startTest();
		List<Type> types = reflector.GetTypes(testMe);
		Test.stopTest();

		System.assertEquals('List<Integer>', types[0].getName());
	}

	@isTest static void WhenTypeInfoOfSObjectList_ShouldReturnListType()
	{
		Object testMe = new List<Account>();
		LabTools_Reflector reflector = new LabTools_Reflector();

		Test.startTest();
		List<Type> types = reflector.GetTypes(testMe);
		Test.stopTest();

		System.assertEquals('List<Account>', types[0].getName());
	}


	@isTest static void WhenTypeInfoOfInterfaceList_ShouldReturnListType()
	{
		Object testMe = new List<LabTools_IRepository>();
		LabTools_Reflector reflector = new LabTools_Reflector();

		Test.startTest();
		List<Type> types = reflector.GetTypes(testMe);
		Test.stopTest();

		Set<Type> result = new Set<Type>(types);
		System.assert(result.contains(Type.forName('List<LabTools_IRepository>')));
	}

}
