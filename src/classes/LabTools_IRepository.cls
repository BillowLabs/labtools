global interface LabTools_IRepository {

	List<LabTools_IEntity> Read(String query);
	List<LabTools_IEntity> Echo(SObject[] objs);
	Map<Id, LabTools_IEntity> Echo(Map<Id, SObject> objMap);

	LabTools_IEntity Create(SObjectType sType);
	LabTools_IEntity Create(SObject value);
	List<LabTools_IEntity> Create(SObject[] values);

	void Remove(LabTools_IEntity value);
	void Remove(LabTools_IEntity[] values);

	void Save();

}
