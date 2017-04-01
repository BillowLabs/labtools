public with sharing class LabTools_Repository implements LabTools_IRepository {

	public List<LabTools_IEntity> Read(String query) {
		List<SObject> objs = Database.query(query);
		return Convert(objs, LabTools_EntityStatus.NONE);
	}

	public List<LabTools_IEntity> Echo(SObject[] objs) {
		 return Convert(objs, LabTools_EntityStatus.NONE);
	}

	public Map<Id, LabTools_IEntity> Echo(Map<Id, SObject> objMap) {
		List<LabTools_IEntity> converted = Convert(objMap.values(), LabTools_EntityStatus.NONE);

		Map<Id, LabTools_IEntity> result = new Map<Id, LabTools_IEntity>();
		for(LabTools_IEntity entity : converted) {
			result.put(entity.GetId(), entity);
		}
		return result;
	}

	public LabTools_IEntity Create(SObjectType sType) {
		return Convert(new List<SObject> { sType.newSObject() }, LabTools_EntityStatus.CREATED)[0];
	}

	public LabTools_IEntity Create(SObject value) {
		return Convert(new List<SObject> { value }, LabTools_EntityStatus.CREATED)[0];
	}

	public List<LabTools_IEntity> Create(SObject[] values) {
		return Convert(values, LabTools_EntityStatus.CREATED);
	}



	public void Remove(LabTools_IEntity value) {
		Remove(new List<LabTools_IEntity> { value });
	}

	public void Remove(LabTools_IEntity[] values) {
		for(LabTools_IEntity entity : values) {
			entity.SetStatus(LabTools_EntityStatus.REMOVED);
		}
	}


	public void Save(){
		Save(myEntities);
		myEntities.clear();
	}

	private void Save(Set<LabTools_IEntity> entities) {
		List<LabTools_IEntity> createdEntities = new List<LabTools_IEntity>();
		List<LabTools_IEntity> modifiedEntities = new List<LabTools_IEntity>();
		List<LabTools_IEntity> deletedEntities = new List<LabTools_IEntity>();

		for (LabTools_IEntity entity : entities) {
			if (entity.GetStatus() == LabTools_EntityStatus.NONE) {
				entities.Remove(entity);
			}

			if (entity.GetStatus() == LabTools_EntityStatus.CREATED) {
				if (entity.HasUnsavedParents()) continue;
				entity.UpdateRelationships();
				createdEntities.add(entity);
			}

			if (entity.GetStatus() == LabTools_EntityStatus.MODIFIED) {
				if (entity.HasUnsavedParents()) continue;
				entity.UpdateRelationships();
				modifiedEntities.add(entity);
			}

			if (entity.GetStatus() == LabTools_EntityStatus.REMOVED) {
				deletedEntities.add(entity);
			}
		}

		if (createdEntities.isEmpty() == false) {
			insert ToObjectList(createdEntities);
			ResetStatus(createdEntities);
			entities.RemoveAll(createdEntities);
		}

		if (modifiedEntities.isEmpty() == false){
			update ToObjectList(modifiedEntities);
			ResetStatus(modifiedEntities);
			entities.RemoveAll(modifiedEntities);
		}

		if (deletedEntities.isEmpty() == false){
			delete ToObjectList(deletedEntities);
			ResetStatus(deletedEntities);
			entities.RemoveAll(deletedEntities);
		}

		if (entities.isEmpty()) return;

		Save(entities);
	}

	private List<SObject> ToObjectList(List<LabTools_IEntity> entities) {
		List<SObject> result = new List<SObject>();
		for(LabTools_IEntity entity : entities) {
			result.add(entity.GetSObject());
		}
		return result;
	}

	private void ResetStatus(List<LabTools_IEntity> entities) {
		for(LabTools_IEntity entity : entities) {
			entity.SetStatus(LabTools_EntityStatus.None);
		}
	}

	private List<LabTools_IEntity> Convert(SObject[] objs, LabTools_EntityStatus status) {
		List<LabTools_IEntity> result = new List<LabTools_IEntity>();
		for(SObject obj : objs) {
			LabTools_IEntity newEntity = new LabTools_Entity(obj);
			newEntity.SetStatus(status);
			result.add(newEntity);
			myEntities.add(newEntity);

			for(ChildRelationship r : obj.getSObjectType().getDescribe().getChildRelationships()) {
				String name = r.getRelationshipName();
				if (name == null) continue;

				SObject[] rChildren;
				try {
					rChildren = obj.getSObjects(name);
				} catch(System.SObjectException ex) {
					// Do nothing as getSObjects throws an exception when the relationship is empty.
					// i.e. SObject row was retrieved via SOQL without querying the requested field
					// System.debug(ex);
				}
				if (rChildren == null) continue;

				newEntity.AddChildren(name, Convert(rChildren, status));
			}

		}
		return result;
	}


	public LabTools_Repository() {
		myEntities = new Set<LabTools_IEntity>();
	}

	private Set<LabTools_IEntity> myEntities;

}
