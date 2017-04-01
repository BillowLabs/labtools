global class LabTools_Entity implements LabTools_IEntity {

	public SObject GetSObject() {
		return obj;
	}

	public SObjectType GetSObjectType() {
		return obj.getSObjectType();
	}


	public LabTools_EntityStatus GetStatus() {
		return status;
	}

	public LabTools_IEntity SetStatus(LabTools_EntityStatus s) {
		status = s;
		return this;
	}


	public Id GetId() {
		return obj.Id;
	}

	public LabTools_IEntity SetId(Id i) {
		if (obj.Id == i) return this;

		obj.Id = i;
		if (status == LabTools_EntityStatus.NONE) {
			status = LabTools_EntityStatus.MODIFIED;
		}

		return this;
	}




	public Object Get(Schema.SObjectField field) {
		return obj.get(field);
	}

	public LabTools_IEntity Set(Schema.SObjectField field, Object value) {
		if (Get(field) === value) return this;

		obj.put(field, value);
		if (status == LabTools_EntityStatus.NONE) {
			status = LabTools_EntityStatus.MODIFIED;
		}
		return this;
	}




	public List<LabTools_IEntity> GetChildren(String field)  {
		return children.get(ToRelationship(field));
	}

	public LabTools_IEntity AddChild(String relationship, SObject value) {
		return AddChild(relationship, new LabTools_Entity(value));
	}

	public LabTools_IEntity AddChild(String relationship, LabTools_IEntity value) {
		return AddChildren(relationship, new List<LabTools_IEntity> { value });
	}

	public LabTools_IEntity AddChildren(String relationship, SObject[] values) {
		List<LabTools_IEntity> entities = new List<LabTools_IEntity>();
		for(SObject child : values) {
			entities.add(new LabTools_Entity(child));
		}
		return AddChildren(relationship, entities);
	}

	public LabTools_IEntity AddChildren(String relationship, LabTools_IEntity[] values) {

		ChildRelationship rel = ToRelationship(relationship);
		List<LabTools_IEntity>relatedChildren = children.get(rel);

		for (LabTools_IEntity value : values) {
			value.AddParent(rel.getChildSObject() + '.' + rel.getField(), this);
			relatedChildren.add(value);
		}

		children.put(rel, relatedChildren);
		return this;
	}



	public  LabTools_IEntity GetParent(String relationship) {
		return parents.get(relationship);
	}
	public LabTools_IEntity AddParent(String relationship, SObject value) {
		return AddParent(relationship, new LabTools_Entity(value));
	}
	public LabTools_IEntity AddParent(String relationship, LabTools_IEntity value){
		parents.put(relationship, value);
		return this;
	}



	public Boolean HasUnsavedParents() {
		// TODO: expose all parents and move this into repository
		// TODO: this object should be as dumb as possible
		for(LabTools_IEntity parent : parents.values()){
			if (parent.GetStatus() == LabTools_EntityStatus.NONE) continue;
			return true;
		}
		return false;
	}

	public void UpdateRelationships() {
		// TODO: expose all parents and move this into repository
		// TODO: this object should be as dumb as possible
		for(String relationship : parents.keySet()){
			String field = relationship.split('\\.')[1];
			this.obj.put(field, parents.get(relationship).GetId());
		}
	}


	private ChildRelationship ToRelationship(String field) {
		for(ChildRelationship r : children.keySet()) {
			if (r.getRelationshipName().equalsIgnoreCase(field) == false) continue;
			return r;
		}
		throw new LabTools_ApplicationException('No relationship found for: ' + field);
	}

	public LabTools_Entity(SObject o) {
		obj = o;
		children = new Map<ChildRelationship,  List<LabTools_IEntity>>();
		parents = new Map<String,  LabTools_IEntity>();
		status = LabTools_EntityStatus.NONE;

		for(ChildRelationship r : o.getSObjectType().getDescribe().getChildRelationships()) {
			if (r == null || r.getRelationshipName() == null) continue;
			children.put(r, new List<LabTools_IEntity>());
		}
	}

	private Map<ChildRelationship, List<LabTools_IEntity>> children;
	private Map<String, LabTools_IEntity> parents;
	private SObject obj;
	private LabTools_EntityStatus status;

}
