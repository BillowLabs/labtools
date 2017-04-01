@isTest
private class LabTools_Entity_Tests
{
	@isTest static void WhenConstructing_ShouldSetObject()
	{
		Account acc = new Account();

		Test.startTest();
		LabTools_Entity entity = new LabTools_Entity(acc);
		Test.stopTest();

		System.assertEquals(acc, entity.GetSObject());
	}

	@isTest static void WhenGettingSObjecType_ShouldReturnType()
	{
		Account acc = new Account();
		LabTools_Entity entity = new LabTools_Entity(acc);

		Test.startTest();
		SObjectType type = entity.GetSObjectType();
		Test.stopTest();

		System.assertEquals(type, Account.SObjectType);
	}

	@isTest static void WhenGettingId_ShouldReturnId()
	{
		Id aId = LabTools_Faker.GetId(Account.SObjectType);
		Account acc = new Account(Id = aId);
		LabTools_Entity entity = new LabTools_Entity(acc);

		Test.startTest();
		Id newId = entity.GetId();
		Test.stopTest();

		System.assertEquals(aId, newId);
	}

	@isTest static void WhenSettingId_ShouldUpdateId()
	{
		Id aId = LabTools_Faker.GetId(Account.SObjectType);
		Account acc = new Account(Id = aId);
		LabTools_Entity entity = new LabTools_Entity(acc);

		Test.startTest();
		entity.SetId(LabTools_Faker.GetId(Account.SObjectType));
		Test.stopTest();

		System.assert(aId != entity.GetId());
	}

	@isTest static void WhenUsingProperty_ShouldSetValue()
	{
		Account acc = new Account(Name = 'Test Name');
		LabTools_Entity entity = new LabTools_Entity(acc);

		Test.startTest();
		entity.set(Account.Name, 'New Name');
		String testName = (String)entity.get(Account.Name);
		Test.stopTest();

		System.assertEquals('New Name', testName);
	}

	@isTest static void WhenLinkingChildren_ShouldAddNewChildren()
	{
		Account obj = new Account(Name = 'Test Name');
		LabTools_Entity acc = new LabTools_Entity(obj);

		List<Contact> contacts = new List<Contact> {
			new Contact(LastName = 'Last One'),
			new Contact(LastName = 'Last Two')
		};

		List<Case> cases = new List<Case> {
			new Case()
		};

		Test.startTest();
		acc.AddChildren('Contacts', contacts);
		acc.AddChildren('Cases', cases);
		List<LabTools_IEntity> contactEntities = acc.GetChildren('Contacts');
		List<LabTools_IEntity> caseEntities = acc.GetChildren('Cases');
		Test.stopTest();

		System.assertEquals(1, caseEntities.size());
		System.assertEquals(2, contactEntities.size());
		System.AssertEquals('Last One', contactEntities[0].get(Contact.LastName));
		System.AssertEquals('Last Two', contactEntities[1].get(Contact.LastName));

	}

}