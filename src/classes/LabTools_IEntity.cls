global interface LabTools_IEntity {

	SObject GetSObject();
	SObjectType GetSObjectType();

	LabTools_EntityStatus GetStatus();
	LabTools_IEntity SetStatus(LabTools_EntityStatus status);

	Id GetId();
	LabTools_IEntity SetId(Id i);

	Object Get(Schema.SObjectField field);
	LabTools_IEntity Set(Schema.SObjectField field, Object value);

	List<LabTools_IEntity> GetChildren(String relationship);
	LabTools_IEntity AddChild(String relationship, SObject value);
	LabTools_IEntity AddChild(String relationship, LabTools_IEntity value);
	LabTools_IEntity AddChildren(String relationship, SObject[] values);
	LabTools_IEntity AddChildren(String relationship, LabTools_IEntity[] values);

	LabTools_IEntity GetParent(String relationship);
	LabTools_IEntity AddParent(String relationship, SObject value);
	LabTools_IEntity AddParent(String relationship, LabTools_IEntity value);

	Boolean HasUnsavedParents();
	void UpdateRelationships();

}