global interface LabTools_IConfigVars {
	String Read(String key);
	Map<String, String> ReadAll(List<String> keys);
}