global class LabTools_Repository implements LabTools_IRepository {
	global List<SObject> Read(String query){
		return Database.query(query);
	}
	global List<SObject> Echo(SObject[] query) {
		return query;
	}
	global void Create(SObject value){
		insert value;
	}
	global void Create(List<SObject> values){
		insert values;
	}
	global void Modify(SObject value){
		update value;
	}
	global void Modify(List<SObject> values){
		update values;
	}
	global void Save(SObject value){
		upsert value;
	}
	global void Save(List<SObject> values){
		upsert values;
	}
	global void Remove(SObject value){
		delete value;
	}
	global void Remove(List<SObject> values){
		delete values;
	}
}