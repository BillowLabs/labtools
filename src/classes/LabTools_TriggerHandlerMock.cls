global class LabTools_TriggerHandlerMock extends LabTools_TriggerHandler {
	global override Boolean IsForType(SObjectType t) {
		return false;
	}

	global override void OnBeforeInsert(Map<Id, SObject> values) {
		OnBeforeInsertCalled++;
	}

	global override void OnAfterInsert(Map<Id, SObject> values) {
		OnAfterInsertCalled++;
	}

	global override void OnBeforeUpdate(Map<Id, SObject> oldMap, Map<Id, SObject> newMap) {
		OnBeforeUpdateCalled++;
	}

	global override void OnAfterUpdate(Map<Id, SObject> oldMap, Map<Id, SObject> newMap) {
		OnAfterUpdateCalled++;
	}

	global override void OnBeforeDelete(Map<Id, SObject> values) {
		OnBeforeDeleteCalled++;
	}

	global override void OnAfterDelete(Map<Id, SObject> values) {
		OnAfterDeleteCalled++;
	}

	global override void OnUnDelete(Map<Id, SObject> values) {
		OnUnDeleteCalled++;
	}

	public LabTools_TriggerHandlerMock() {
		OnBeforeInsertCalled = 0;
		OnAfterInsertCalled = 0;
		OnBeforeUpdateCalled = 0;
		OnAfterUpdateCalled = 0;
		OnBeforeDeleteCalled = 0;
		OnAfterDeleteCalled = 0;
		OnUnDeleteCalled = 0;
	}

	// TODO: make this a map for each type so we can test against it.
	global static Integer OnBeforeInsertCalled { get; set; }
	global static Integer OnAfterInsertCalled { get; set; }
	global static Integer OnBeforeUpdateCalled { get; set; }
	global static Integer OnAfterUpdateCalled { get; set; }
	global static Integer OnBeforeDeleteCalled { get; set; }
	global static Integer OnAfterDeleteCalled { get; set; }
	global static Integer OnUnDeleteCalled { get; set; }

}