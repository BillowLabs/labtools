global class LabTools_ConfigVars implements LabTools_IConfigVars {

	global String Read(String key) {
		List<LabTools_ConfigVar__c> results = [
			SELECT Value__c
			FROM LabTools_ConfigVar__c
			WHERE Name = :key
		];

		if (results.size() == 0) return null;

		return results[0].Value__c;
	}

	global Map<String, String> ReadAll(List<String> keys) {
		List<LabTools_ConfigVar__c> values = [
			SELECT Name, Value__c
			FROM LabTools_ConfigVar__c
			WHERE Name = :keys
		];

		Map<String, String> result = new Map<String, String>();
		for(LabTools_ConfigVar__c var : values) {
			result.put(var.Name, var.Value__c);
		}

		return result;
	}

}