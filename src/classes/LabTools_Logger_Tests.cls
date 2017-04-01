@isTest
private class LabTools_Logger_Tests {

	@isTest static void WhenLoggingString_ShouldCreateMessageLog() {
		LabTools_RepositoryMock repo = new LabTools_RepositoryMock();
		LabTools_Logger logger = new LabTools_Logger(repo);

		Test.startTest();
		logger.log('Test Message');
		Test.stopTest();

		System.assertEquals('DEBUG', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Level__c));
		System.assertEquals('Test Message', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Value__c));
	}


	@isTest static void WhenLoggingObject_ShouldCreateMessageLog() {
		LabTools_RepositoryMock repo = new LabTools_RepositoryMock();
		LabTools_Logger logger = new LabTools_Logger(repo);

		Test.startTest();
		logger.log(new Log__c(Level__c = 'Test', Value__c = 'Test Message'));
		Test.stopTest();

		System.assertEquals('DEBUG', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Level__c));
		System.assertEquals('Log__c:{Level__c=Test, Value__c=Test Message}', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Value__c));
	}


	@isTest static void WhenLoggingInteger_ShouldCreateMessageLog() {
		LabTools_RepositoryMock repo = new LabTools_RepositoryMock();
		LabTools_Logger logger = new LabTools_Logger(repo);
		Integer value = 10;

		Test.startTest();
		logger.log(value);
		Test.stopTest();

		System.assertEquals('DEBUG', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Level__c));
		System.assertEquals('10', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Value__c));
	}


	@isTest static void WhenLoggingLong_ShouldCreateMessageLog() {
		LabTools_RepositoryMock repo = new LabTools_RepositoryMock();
		LabTools_Logger logger = new LabTools_Logger(repo);
		Long value = 10L;

		Test.startTest();
		logger.log(value);
		Test.stopTest();

		System.assertEquals('DEBUG', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Level__c));
		System.assertEquals('10', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Value__c));
	}


	@isTest static void WhenLoggingDouble_ShouldCreateMessageLog() {
		LabTools_RepositoryMock repo = new LabTools_RepositoryMock();
		LabTools_Logger logger = new LabTools_Logger(repo);
		Double value = 10;

		Test.startTest();
		logger.log(value);
		Test.stopTest();

		System.assertEquals('DEBUG', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Level__c));
		System.assertEquals('10.0', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Value__c));
	}


	@isTest static void WhenLoggingDecimal_ShouldCreateMessageLog() {
		LabTools_RepositoryMock repo = new LabTools_RepositoryMock();
		LabTools_Logger logger = new LabTools_Logger(repo);
		Decimal value = 10.2;

		Test.startTest();
		logger.log(value);
		Test.stopTest();

		System.assertEquals('DEBUG', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Level__c));
		System.assertEquals('10.2', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Value__c));
	}


	@isTest static void WhenLoggingDate_ShouldCreateMessageLog() {
		LabTools_RepositoryMock repo = new LabTools_RepositoryMock();
		LabTools_Logger logger = new LabTools_Logger(repo);
		Date value = Date.newInstance(1990, 11, 21);

		Test.startTest();
		logger.log(value);
		Test.stopTest();

		System.assertEquals('DEBUG', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Level__c));
		System.assertEquals('1990-11-21', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Value__c));
	}


	@isTest static void WhenLoggingDateTime_ShouldCreateMessageLog() {
		LabTools_RepositoryMock repo = new LabTools_RepositoryMock();
		LabTools_Logger logger = new LabTools_Logger(repo);
		Datetime value = DateTime.newInstance(2011, 11, 18, 3, 3, 3);

		Test.startTest();
		logger.log(value);
		Test.stopTest();

		System.assertEquals('DEBUG', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Level__c));
		System.assertEquals('2011-11-18 03:03:03', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Value__c));
	}




	@isTest static void WhenLoggingWithTitleAndString_ShouldCreateMessageWithTitleInLog() {
		LabTools_RepositoryMock repo = new LabTools_RepositoryMock();
		LabTools_Logger logger = new LabTools_Logger(repo);

		Test.startTest();
		logger.log('Title', 'Test Message');
		Test.stopTest();

		System.assertEquals('DEBUG', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Level__c));
		System.assertEquals('Title: Test Message', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Value__c));
	}


	@isTest static void WhenLoggingWithTitleAndObject_ShouldCreateMessageWithTitleInLog() {
		LabTools_RepositoryMock repo = new LabTools_RepositoryMock();
		LabTools_Logger logger = new LabTools_Logger(repo);

		Test.startTest();
		logger.log('Title', new Log__c(Level__c = 'Test', Value__c = 'Test Message'));
		Test.stopTest();

		System.assertEquals('DEBUG', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Level__c));
		System.assertEquals('Title: Log__c:{Level__c=Test, Value__c=Test Message}', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Value__c));
	}


	@isTest static void WhenLoggingWithTitleAndInteger_ShouldCreateMessageWithTitleInLog() {
		LabTools_RepositoryMock repo = new LabTools_RepositoryMock();
		LabTools_Logger logger = new LabTools_Logger(repo);
		Integer value = 10;

		Test.startTest();
		logger.log('Title', value);
		Test.stopTest();

		System.assertEquals('DEBUG', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Level__c));
		System.assertEquals('Title: 10', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Value__c));
	}


	@isTest static void WhenLoggingWithTitleAndLong_ShouldCreateMessageWithTitleInLog() {
		LabTools_RepositoryMock repo = new LabTools_RepositoryMock();
		LabTools_Logger logger = new LabTools_Logger(repo);
		Long value = 10L;

		Test.startTest();
		logger.log('Title', value);
		Test.stopTest();

		System.assertEquals('DEBUG', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Level__c));
		System.assertEquals('Title: 10', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Value__c));
	}


	@isTest static void WhenLoggingWithTitleAndDouble_ShouldCreateMessageWithTitleInLog() {
		LabTools_RepositoryMock repo = new LabTools_RepositoryMock();
		LabTools_Logger logger = new LabTools_Logger(repo);
		Double value = 10;

		Test.startTest();
		logger.log('Title', value);
		Test.stopTest();

		System.assertEquals('DEBUG', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Level__c));
		System.assertEquals('Title: 10.0', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Value__c));
	}


	@isTest static void WhenLoggingWithTitleAndDecimal_ShouldCreateMessageWithTitleInLog() {
		LabTools_RepositoryMock repo = new LabTools_RepositoryMock();
		LabTools_Logger logger = new LabTools_Logger(repo);
		Decimal value = 10.2;

		Test.startTest();
		logger.log('Title', value);
		Test.stopTest();

		System.assertEquals('DEBUG', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Level__c));
		System.assertEquals('Title: 10.2', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Value__c));
	}

	@isTest static void WhenLoggingWithTitleAndDate_ShouldCreateMessageWithTitleInLog() {
		LabTools_RepositoryMock repo = new LabTools_RepositoryMock();
		LabTools_Logger logger = new LabTools_Logger(repo);
		Date value = Date.newInstance(1990, 11, 21);

		Test.startTest();
		logger.log('Title', value);
		Test.stopTest();

		System.assertEquals('DEBUG', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Level__c));
		System.assertEquals('Title: 1990-11-21', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Value__c));
	}


	@isTest static void WhenLoggingWithTitleAndDateTime_ShouldCreateMessageWithTitleInLog() {
		LabTools_RepositoryMock repo = new LabTools_RepositoryMock();
		LabTools_Logger logger = new LabTools_Logger(repo);
		Datetime value = DateTime.newInstance(2011, 11, 18, 3, 3, 3);

		Test.startTest();
		logger.log('Title', value);
		Test.stopTest();

		System.assertEquals('DEBUG', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Level__c));
		System.assertEquals('Title: 2011-11-18 03:03:03', repo.GetCreated(Log__c.SObjectType)[0].get(Log__c.Value__c));
	}




	@isTest static void WhenContstructed_ShouldNotFail() {

		Test.startTest();
		LabTools_Logger logger = new LabTools_Logger();
		Test.stopTest();

	}

}
