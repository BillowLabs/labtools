global interface LabTools_IRepository {
	List<SObject> Read(String query);
	List<SObject> Echo(SObject[] query);
	void Create(SObject values);
	void Create(List<SObject> values);
	void Modify(SObject values);
	void Modify(List<SObject> values);
	void Save(SObject values);
	void Save(List<SObject> values);
	void Remove(SObject values);
	void Remove(List<SObject> values);
}