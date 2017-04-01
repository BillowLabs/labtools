global abstract class LabTools_TriggerHandler implements LabTools_ITriggerHandler {
	global virtual Boolean IsForType(SObjectType t) {
		return false;
	}

	global virtual void execute() {
		if(Trigger.isInsert && Trigger.isBefore){
			OnBeforeInsert(Trigger.newMap);

		} else if(Trigger.isInsert && Trigger.isAfter){
			OnAfterInsert(Trigger.newMap);

		} else if(Trigger.isUpdate && Trigger.isBefore){
			OnBeforeUpdate(Trigger.oldMap, Trigger.newMap);

		} else if(Trigger.isUpdate && Trigger.isAfter){
			OnAfterUpdate(Trigger.oldMap, Trigger.newMap);

		} else if(Trigger.isDelete && Trigger.isBefore){
			OnBeforeDelete(Trigger.oldMap);

		} else if(Trigger.isDelete && Trigger.isAfter){
			OnAfterDelete(Trigger.oldMap);

		} else if(Trigger.isUnDelete){
			OnUndelete(Trigger.newMap);
		}
	}

	global virtual void OnBeforeInsert(Map<Id, SObject> values) {
		System.debug('OnBeforeInsert called, but not implemented');
	}

	global virtual void OnAfterInsert(Map<Id, SObject> values) {
		System.debug('OnAfterInsert called, but not implemented');
	}

	global virtual void OnBeforeUpdate(Map<Id, SObject> oldMap, Map<Id, SObject> newMap) {
		System.debug('OnBeforeUpdate called, but not implemented');
	}

	global virtual void OnAfterUpdate(Map<Id, SObject> oldMap, Map<Id, SObject> newMap) {
		System.debug('OnAfterUpdate called, but not implemented');
	}

	global virtual void OnBeforeDelete(Map<Id, SObject> values) {
		System.debug('OnBeforeDelete called, but not implemented');
	}

	global virtual void OnAfterDelete(Map<Id, SObject> values) {
		System.debug('OnAfterDelete called, but not implemented');
	}

	global virtual void OnUnDelete(Map<Id, SObject> values) {
		System.debug('OnUnDelete called, but not implemented');
	}

}