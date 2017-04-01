global class LabTools_RepositoryMock implements LabTools_IRepository
{

	public Integer SaveCalled { get; set; }

	global List<LabTools_IEntity> Read(String query) {
		List<sObject> results = Database.query(query);
		return Echo(results);
	}

	global List<LabTools_IEntity> Echo(SObject[] query) {
		SObjectType sType;
		for (SObjectType t : Entities.keySet()) {
			try {
				query.add(t.newSObject());
				sType = t;
				break;
			} catch (TypeException ex) {
				// We are intentionally assigining bad values to the array,
				// to filter types that don't match.  If we dont find a Type
				// we will throw an exception later
				continue;
			}
		}
		if (sType == null) throw new LabTools_ApplicationException('SObjectType not found for query');

		List<LabTools_IEntity> results = GetUnchanged(sType);
		if (results == null) return new List<LabTools_IEntity>();

		return results;
	}

	global Map<Id, LabTools_IEntity> Echo(Map<Id, SObject> query) {
		List<LabTools_IEntity> values = Echo(query.values());

		Map<Id, LabTools_IEntity> result = new Map<Id, LabTools_IEntity>();
		for(LabTools_IEntity entity : values) {
			result.put(entity.GetId(), entity);
		}

		return result;
	}



	global LabTools_IEntity Create(SObjectType sType) {
		return Create(sType.newSObject());
	}

	global LabTools_IEntity Create(SObject value){
		return Create(new List<SObject>{ value })[0];
	}

	global List<LabTools_IEntity> Create(List<SObject> values){
		if (values.isEmpty()) return new List<LabTools_IEntity>();

		List<LabTools_IEntity> newEntities = new List<LabTools_IEntity>();
		for (SObject value : values) {
			LabTools_IEntity entity = new LabTools_Entity(value);
			entity.SetStatus(LabTools_EntityStatus.CREATED);
			newEntities.add(entity);
		}

		SObjectType sType = values[0].getSObjectType();
		Entities.get(sType).addAll(newEntities);
		return newEntities;
	}



	global void Remove(LabTools_IEntity value){
		value.SetStatus(LabTools_EntityStatus.REMOVED);
	}

	global void Remove(List<LabTools_IEntity> values){
		for(LabTools_IEntity entity : values) {
			entity.SetStatus(LabTools_EntityStatus.REMOVED);
		}
	}



	global void Save() {
		SaveCalled++;
	}



	global LabTools_IEntity Load(SObjectType sType) {
		LabTools_IEntity result = Load(sType.newSObject());
		System.debug('Loaded: ' + sType + ' Status: ' + result.GetStatus());
		return result;
	}

	global LabTools_IEntity Load(SObject value){
		return Load(new List<SObject>{ value })[0];
	}

	global List<LabTools_IEntity> Load(List<SObject> values){
		List<LabTools_IEntity> newEntities = Create(values);
		for(LabTools_IEntity entity : newEntities) {
			entity.SetStatus(LabTools_EntityStatus.NONE);
		}
		return newEntities;
	}


	public List<LabTools_IEntity> GetUnchanged(SObjectType type) {
		return GetWithStatus(type, LabTools_EntityStatus.NONE);
	}

	public List<LabTools_IEntity> GetCreated(SObjectType type) {
		return GetWithStatus(type, LabTools_EntityStatus.CREATED);
	}

	public List<LabTools_IEntity> GetModified(SObjectType type) {
		return GetWithStatus(type, LabTools_EntityStatus.MODIFIED);
	}

	public List<LabTools_IEntity> GetRemoved(SObjectType type) {
		return GetWithStatus(type, LabTools_EntityStatus.REMOVED);
	}








	private List<LabTools_IEntity> GetWithStatus(SObjectType type, LabTools_EntityStatus status) {
		// System.debug('Current Mock Entites: ' + Entities);
		List<LabTools_IEntity> results = new List<LabTools_IEntity>();
		List<LabTools_IEntity> found = Entities.get(type);
		if (found == null) return results;

		for(LabTools_IEntity entity : found) {
			if (entity.GetStatus() != status) continue;
			results.add(entity);
		}

		if (type === Contact.SObjectType) {
			System.debug('Found: ' +  results.size());
		}

		return results;
	}



	global LabTools_RepositoryMock() {
		SaveCalled = 0;

		Entities = new Map<SObjectType, List<LabTools_IEntity>>();
		for(SObjectType sType : Schema.getGlobalDescribe().values()) {
			Entities.put(sType, new List<LabTools_IEntity>());
		}
	}


	private Map<SObjectType, List<LabTools_IEntity>> Entities;
}
