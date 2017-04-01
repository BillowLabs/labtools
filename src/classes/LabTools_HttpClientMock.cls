public class LabTools_HttpClientMock implements LabTools_IHttpClient {
	public Integer SendCalled { get; set; }
	public Integer FutureCalled { get; set; }
	public Map<HttpRequest, HttpResponse> ResponseMap { get; set; }
	public List<LabTools_FutureRequest> FutureRequests { get; set; }

	public HttpResponse Send(HttpRequest request) {
		SendCalled++;
		return ResponseMap.get(request);
	}

	public virtual void Future(LabTools_FutureRequest request) {
		FutureCalled++;
		FutureRequests.add(request);
	}

	public void AddResponse(HttpRequest req, HttpResponse res) {
		ResponseMap.put(req, res);
	}

	public LabTools_HttpClientMock() {
		SendCalled = 0;
		FutureCalled = 0;
		ResponseMap = new Map<HttpRequest, HttpResponse>();
		FutureRequests = new List<LabTools_FutureRequest>();
	}

}