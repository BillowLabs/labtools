global class LabTools_FutureRequest {
	public String endpoint;
	public String method;
	public String handler;
	public Map<String, String> headers = new Map<String, String>();
	public String body;

	global void SetHandler(Type type) {
		Object obj = type.NewInstance();
		if ((obj instanceof LabTools_IHttpResponseHandler) == false){
			throw new LabTools_ApplicationException(type.getName() + ' must implement ' + LabTools_IHttpResponseHandler.class.getName());
		}

		handler = type.getName();
	}

	global void SetEndpoint(String url) {
		endpoint = url;
		method = 'GET';
	}

	global void SetEndpoint(String url, String m) {
		endpoint = url;
		method = m;
	}

	global void AddHeader(String key, String value) {
		headers.put(key, value);
	}

	global void SetBody(String b) {
		body = b;
	}
}