// Marking test stubs as @isTest excludes them from code coverage
// However, in order to do so, the class can not be virtual as we want: #ThankYouSalesforce
public abstract class LabTools_HttpClientTestStub implements LabTools_IHttpClient {
	public virtual HttpResponse Send(HttpRequest request) {
		throw new LabTools_NotImplementedException('You must override the Send(HttpRequest request) method when using the HttpClientTestStub');
	}
	public virtual void Future(LabTools_FutureRequest request) {
		throw new LabTools_NotImplementedException('You must override the Future(FutureRequest request) method when using the HttpClientTestStub');
	}
}