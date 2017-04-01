public with sharing class LabTools_Reflector {

	public List<Type> GetTypes(Object obj) {
		List<Type> results = new List<Type>();

		for(Type t : all_types) {
			if (IsTypeOf(obj, t)) {
				results.add(t);
			} else if (IsListOf(obj, t)) {
				results.add(ToListType(t));
			}
		}

		results.add(Type.forName('Object'));
		return results;
	}

	public Boolean IsTypeOf(Object obj, Type t) {
		if (obj == null || t == null) return false;

		List<Object> newList = (List<Object>)ToListType(t).newInstance();

		try {
			newList.add(obj);
			return true;
		} catch (Exception ex) {
			return false;
		}
	}

	public Boolean IsListOf(Object obj, Type t) {
		if (obj == null || t == null) return false;
		if (IsList(obj) == false) return false;

		List<Object> newList = (List<Object>)ToListType(t).newInstance();
		List<Object> clonedList = ((List<Object>)obj).clone();
		clonedList.clear();

		return newList == clonedList;
	}

	public Boolean IsList(Object obj) {
		if (obj == null) return false;
		return obj instanceof List<Object>;
	}

	public Boolean IsSObject(Object obj) {
		if (obj == null) return false;
		return obj instanceof SObject;
	}

	public Type ToListType(Type t) {
		return Type.forName('List<' + t.getName() + '>');
	}

	public SObjectType ToSObjectType(Type t) {
		for(SObjectType st : Schema.getGlobalDescribe().values()) {
			if (t.getName().ToUpperCase() == st.getDescribe().getName().ToUpperCase()) return st;
		}
		return null;
	}




	public LabTools_Reflector() {
		// Add primitive types
		for(String name : primitives) {
			primitive_types.add(Type.forName(name));
		}
		all_types.addAll(primitive_types);

		// Add SObject types
		for(SObjectType sType : Schema.getGlobalDescribe().values()) {
			object_types.add(Type.forName(sType.getDescribe().getName()));
		}
		all_types.addAll(object_types);

		// Add Apex Class types
		List<ApexClass> classes = [SELECT name FROM ApexClass];
		for(ApexClass c : classes) {
			Type t = Type.forName(c.Name);
			if (t == null) continue; //For some reason test classes return null here
			class_types.add(t);
		}
		all_types.addAll(class_types);
	}




	private List<Type> all_types = new List<Type>();
	private List<Type> primitive_types = new List<Type>();
	private List<Type> object_types = new List<Type>();
	private List<Type> class_types = new List<Type>();
	private static List<String> primitives = new List<String> {
		'Boolean',
		'Id',
		'String',
		'Blob',
		'Date',
		'Datetime',
		'Time',
		'Integer',
		'Long',
		'Double'
	};
}
