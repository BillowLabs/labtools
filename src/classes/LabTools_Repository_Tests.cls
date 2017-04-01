@isTest
private class LabTools_Repository_Tests {

	@isTest static void WhenConstructing_ShouldNotFail() {
		Test.startTest();
		LabTools_Repository repo = new LabTools_Repository();
		Test.stopTest();
	}

	@isTest static void WhenReading_ShouldReturnQueryResults() {
		LabTools_Repository repo = new LabTools_Repository();

		List<Account> acc = new List<Account> {
			new Account(Name = 'TestAccount'),
			new Account(Name = 'TestAccountToo')
		};
		insert acc;

		Test.startTest();
		List<LabTools_IEntity> results = repo.Read('SELECT Id, Name FROM Account');
		Test.stopTest();

		System.assertEquals(2, results.size());
		System.assertEquals(acc[0].Name, (String)results[0].Get(Account.Name));
		System.assertEquals(acc[1].Name, (String)results[1].Get(Account.Name));
	}

	@isTest static void WhenEchoing_ShouldReturnQueryResults() {
		LabTools_Repository repo = new LabTools_Repository();

		List<Account> acc = new List<Account> {
			new Account(Name = 'TestAccount'),
			new Account(Name = 'TestAccountToo')
		};
		insert acc;

		Test.startTest();
		List<LabTools_IEntity> results = repo.Echo([SELECT Id, Name FROM Account]);
		Test.stopTest();

		System.assertEquals(2, results.size());
		System.assertEquals(acc[0].Name, (String)results[0].Get(Account.Name));
		System.assertEquals(acc[1].Name, (String)results[1].Get(Account.Name));
	}

	@isTest static void WhenEchoing_ShouldReturnMapOfQueryResults() {
		LabTools_Repository repo = new LabTools_Repository();

		List<Account> acc = new List<Account> {
			new Account(Name = 'TestAccount'),
			new Account(Name = 'TestAccountToo')
		};
		insert acc;

		Test.startTest();
		Map<Id, LabTools_IEntity> results = repo.Echo(new Map<Id, Account>([SELECT Id, Name FROM Account]));
		Test.stopTest();

		System.assertEquals(2, results.size());
		System.assertEquals(acc[0].Name, (String)results.get(acc[0].Id).Get(Account.Name));
		System.assertEquals(acc[1].Name, (String)results.get(acc[1].Id).Get(Account.Name));
	}

	@isTest static void WhenCreating_ShouldReturnEntity() {
		LabTools_Repository repo = new LabTools_Repository();

		Account acc = new Account(Name = 'TestAccount');

		Test.startTest();
		LabTools_IEntity result = repo.Create(acc);
		Test.stopTest();

		System.assertEquals(acc.Name, (String)result.Get(Account.Name));
	}

	@isTest static void WhenCreatingList_ShouldReturnEntityList() {
		LabTools_Repository repo = new LabTools_Repository();

		List<Account> acc = new List<Account> {
			new Account(Name = 'TestAccount'),
			new Account(Name = 'TestAccountToo')
		};

		Test.startTest();
		List<LabTools_IEntity> results = repo.Create(acc);
		Test.stopTest();

		System.assertEquals(2, results.size());
		System.assertEquals(acc[0].Name, (String)results[0].Get(Account.Name));
		System.assertEquals(acc[1].Name, (String)results[1].Get(Account.Name));
	}

	@isTest static void WhenSaving_ShouldInsertItems() {
		LabTools_Repository repo = new LabTools_Repository();

		LabTools_IEntity acc = repo.Create(Account.SObjectType)
			.Set(Account.Name, 'TestAccount')
			.AddChild('Contacts',
				repo.Create(Contact.SObjectType)
				.set(Contact.LastName, 'Test')
			)
			.AddChild('Contacts',
				repo.Create(Contact.SObjectType)
				.set(Contact.LastName, 'Test Too')
			);


		Test.startTest();
		repo.Save();
		Test.stopTest();

		List<Contact> contacts = [SELECT Id, LastName FROM Contact];
		System.assertEquals(2, contacts.size());

		List<Account> inserted = [SELECT Id, Name, (SELECT Id, LastName FROM Contacts) FROM Account];

		System.assertEquals(1, inserted.size());
		System.assertEquals('TestAccount', inserted[0].Name);
		System.assertEquals('Test', inserted[0].Contacts[0].LastName);
		System.assertEquals('Test Too', inserted[0].Contacts[1].LastName);
	}

	@isTest static void WhenSaving_ShouldUpdateItems() {
		LabTools_Repository repo = new LabTools_Repository();

		Account acc = new Account(Name='TestAccount');
		insert acc;

		List<Contact> contacts = new List<Contact> {
			new Contact(LastName = 'Test', AccountId = acc.Id),
			new Contact(LastName = 'TestToo', AccountId = acc.Id)
		};
		insert contacts;

		List<LabTools_IEntity> accounts = repo.Echo([SELECT Id, Name, (SELECT Id, LastName FROM Contacts) FROM Account]);
		accounts[0].set(Account.Name, 'Test Account');
		accounts[0].GetChildren('Contacts')[0].set(Contact.LastName, 'Something Else');
		accounts[0].GetChildren('Contacts')[1].set(Contact.LastName, 'Something Else Too');

		Test.startTest();
		repo.Save();
		Test.stopTest();

		Account updatedAcc = [SELECT Id, Name, (SELECT Id, LastName FROM Contacts) FROM Account];
		System.assertEquals('Test Account', updatedAcc.Name);
		System.assertEquals('Something Else', updatedAcc.Contacts[0].LastName);
		System.assertEquals('Something Else Too', updatedAcc.Contacts[1].LastName);
	}

	@isTest static void WhenSaving_ShouldDeleteItems() {
		LabTools_Repository repo = new LabTools_Repository();

		Account acc = new Account(Name='TestAccount');
		insert acc;

		List<Contact> contacts = new List<Contact> {
			new Contact(LastName = 'Test', AccountId = acc.Id),
			new Contact(LastName = 'TestToo', AccountId = acc.Id)
		};
		insert contacts;

		List<LabTools_IEntity> accounts = repo.Echo([SELECT Id, Name, (SELECT Id, LastName FROM Contacts) FROM Account]);
		repo.Remove(accounts);

		Test.startTest();
		repo.Save();
		Test.stopTest();

		List<Account> remainingAccounts = [SELECT Id, Name FROM Account];
		System.assertEquals(0, remainingAccounts.size());

		List<Contact> remainingContacts = [SELECT Id, Name FROM Contact];
		System.assertEquals(0, remainingContacts.size());
	}

}
