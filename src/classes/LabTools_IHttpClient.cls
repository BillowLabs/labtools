global interface LabTools_IHttpClient {
	HttpResponse Send(HttpRequest request);
	void Future(LabTools_FutureRequest request);
}