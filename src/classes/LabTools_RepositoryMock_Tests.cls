@isTest
private class LabTools_RepositoryMock_Tests
{
	@isTest static void WhenConstructing_ShouldReset() {
		Test.startTest();
		LabTools_RepositoryMock mockRepo = new LabTools_RepositoryMock();
		Test.stopTest();

		System.assertEquals(0, mockRepo.SaveCalled);
		System.assertEquals(0, mockRepo.GetUnchanged(Account.SObjectType).size());
		System.assertEquals(0, mockRepo.GetCreated(Account.SObjectType).size());
		System.assertEquals(0, mockRepo.GetModified(Account.SObjectType).size());
		System.assertEquals(0, mockRepo.GetRemoved(Account.SObjectType).size());
	}

	@isTest static void WhenLoadingValues_ShouldAddAsUnchanged() {
		LabTools_RepositoryMock mockRepo = new LabTools_RepositoryMock();

		Test.startTest();
		mockRepo.Load(Account.SObjectType)
			.AddChild('Contacts',
				mockRepo.Load(Contact.SObjectType)
			)
			.AddChild('Contacts',
				mockRepo.Load(Contact.SObjectType)
			);
		Test.stopTest();


		System.assertEquals(1, mockRepo.GetUnchanged(Account.SObjectType).size());
		System.assertEquals(2, mockRepo.GetUnchanged(Contact.SObjectType).size());
	}

	@isTest static void WhenEchoingValues_ShouldReturnUnchanged() {
		LabTools_RepositoryMock mockRepo = new LabTools_RepositoryMock();
		Id accId = LabTools_Faker.GetId(Account.SObjectType);
		mockRepo.Load(new Account(Id = accId));


		Test.startTest();
		List<LabTools_IEntity> accounts = mockRepo.Echo([SELECT Id FROM Account]);
		Test.stopTest();


		System.assertEquals(1, accounts.size());
	}

	@isTest static void WhenEchoingMap_ShouldReturnUnchanged() {
		LabTools_RepositoryMock mockRepo = new LabTools_RepositoryMock();
		Id accId = LabTools_Faker.GetId(Account.SObjectType);
		mockRepo.Load(new Account(Id = accId));


		Test.startTest();
		Map<Id, LabTools_IEntity> accounts = mockRepo.Echo(new Map<Id, Account>([SELECT Id FROM Account]));
		Test.stopTest();


		System.assert(accounts.Get(accId) != null);
	}

	@isTest static void WhenReading_ShouldReturnUnchanged() {
		LabTools_RepositoryMock mockRepo = new LabTools_RepositoryMock();
		Id accId = LabTools_Faker.GetId(Account.SObjectType);
		mockRepo.Load(new Account(Id = accId));


		Test.startTest();
		List<LabTools_IEntity> accounts = mockRepo.Read('SELECT Id FROM Account');
		Test.stopTest();


		System.assert(accounts.isEmpty() == false);
	}

	@isTest static void WhenCreating_ShouldMarkAsCreated() {
		LabTools_RepositoryMock mockRepo = new LabTools_RepositoryMock();


		Test.startTest();
		mockRepo.Create(Account.SObjectType);
		Test.stopTest();


		System.assertEquals(1, mockRepo.GetCreated(Account.SObjectType).size());
	}

	@isTest static void WhenRemoving_ShouldMarkAsRemoved() {
		LabTools_RepositoryMock mockRepo = new LabTools_RepositoryMock();
		LabTools_IEntity acc = mockRepo.Load(Account.SObjectType);


		Test.startTest();
		mockRepo.Remove(acc);
		Test.stopTest();


		System.assertEquals(1, mockRepo.GetRemoved(Account.SObjectType).size());
	}

	@isTest static void WhenSaving_ShouldIncrementSaveCount() {
		LabTools_RepositoryMock mockRepo = new LabTools_RepositoryMock();


		Test.startTest();
		mockRepo.Save();
		Test.stopTest();


		System.assertEquals(1, mockRepo.SaveCalled);
	}
}
