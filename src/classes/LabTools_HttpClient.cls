global class LabTools_HttpClient implements LabTools_IHttpClient {

	global HttpResponse Send(HttpRequest request) {
		return (new Http()).send(request);
	}

	global void Future(LabTools_FutureRequest request) {
		AsyncCall(JSON.serialize(request));
	}

	@future (callout=true)
	private static void AsyncCall(String jRequest) {
		LabTools_FutureRequest fRequest = (LabTools_FutureRequest)JSON.deserialize(jRequest, LabTools_FutureRequest.class);

		HttpRequest request = new HttpRequest();
		request.setEndpoint(fRequest.endpoint);
		request.setMethod(fRequest.method);

		for(String key : fRequest.headers.keySet()) {
			request.setHeader(key, fRequest.headers.get(key));
		}

		if (fRequest.body != null) {
			request.setBody(fRequest.body);
		}

		HttpResponse result = (new Http()).send(request);

		if (fRequest.handler == null) return;
		System.debug('Handling with: ' + fRequest.handler);

		Type targettype = Type.forName(fRequest.handler);
		LabTools_IHttpResponseHandler handler = (LabTools_IHttpResponseHandler)targettype.NewInstance();
		handler.handle(result);
	}
}