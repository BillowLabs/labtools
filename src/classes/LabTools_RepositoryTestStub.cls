// Marking test stubs as @isTest excludes them from code coverage
// However, in order to do so, the class can not be virtual as we want: #ThankYouSalesforce
global abstract class LabTools_RepositoryTestStub implements LabTools_IRepository
{
	global virtual List<SObject> Read(String query){
		throw new LabTools_NotImplementedException('You must override the Read(SObject values) method when using the RepositoryTestStub');
	}
	global virtual List<SObject> Echo(List<SObject> query){
		throw new LabTools_NotImplementedException('You must override the Echo(List<SObject> values) method when using the RepositoryTestStub');
	}
	global virtual void Create(SObject value){
		throw new LabTools_NotImplementedException('You must override the Create(SObject value) method when using the RepositoryTestStub');
	}
	global virtual void Create(List<SObject> values){
		throw new LabTools_NotImplementedException('You must override the Create(List<SObject> values) method when using the RepositoryTestStub');
	}
	global virtual void Modify(SObject value){
		throw new LabTools_NotImplementedException('You must override the Modify(SObject value) method when using the RepositoryTestStub');
	}
	global virtual void Modify(List<SObject> values){
		throw new LabTools_NotImplementedException('You must override the Modify(List<SObject> values) method when using the RepositoryTestStub');
	}
	global virtual void Save(SObject value){
		throw new LabTools_NotImplementedException('You must override the Save(SObject value) method when using the RepositoryTestStub');
	}
	global virtual void Save(List<SObject> values){
		throw new LabTools_NotImplementedException('You must override the Save(List<SObject> values) method when using the RepositoryTestStub');
	}
	global virtual void Remove(SObject value){
		throw new LabTools_NotImplementedException('You must override the Remove(SObject value) method when using the RepositoryTestStub');
	}
	global virtual void Remove(List<SObject> values){
		throw new LabTools_NotImplementedException('You must override the Remove(List<SObject> values) method when using the RepositoryTestStub');
	}
}