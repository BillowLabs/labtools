@isTest
private class LabTools_HttpClient_Tests
{

	@isTest
	static void WhenMakingRequest_ShouldReturnResponse()
	{
		LabTools_HttpClient client = new LabTools_HttpClient();
		HttpRequest request = new HttpRequest();
		request.setEndpoint('http://getme.com');
		request.setMethod('GET');

		Test.setMock(HttpCalloutMock.class, new GetHttpCalloutMock());

		Test.startTest();
		HttpResponse response = client.Send(request);
		Test.stopTest();

		System.assert(response != null);
		System.assertEquals('Working', response.getBody());
		System.assertEquals(200, response.getStatusCode());
	}


	@isTest
	static void WhenMakingFutureRequest_ShouldHandleResponse()
	{
		LabTools_HttpClient client = new LabTools_HttpClient();
		LabTools_FutureRequest request = new LabTools_FutureRequest();
		request.SetEndpoint('http://getme.com');
		request.SetHandler(TestResponseHandler.class);
		request.SetBody('Content');
		request.AddHeader('One', '1');

		Test.setMock(HttpCalloutMock.class, new AsyncGetHttpCalloutMock());

		Test.startTest();
		client.Future(request);
		Test.stopTest();

		System.assertEquals(1, TestResponseHandlerCalled);
	}



	private static Integer TestResponseHandlerCalled = 0;
	public class TestResponseHandler implements LabTools_IHttpResponseHandler {
		// NOTE: this class must remain public in order to be instantiated as a handler.
		public void Handle(HttpResponse response) {
			LabTools_HttpClient_Tests.TestResponseHandlerCalled++;
			System.assertEquals('Working', response.getBody());
			System.assertEquals(200, response.getStatusCode());
		}
	}


	private class GetHttpCalloutMock implements HttpCalloutMock {
		public HTTPResponse respond(HTTPRequest req) {

			System.assertEquals('http://getme.com', req.getEndpoint());
			System.assertEquals('GET', req.getMethod());

			// Create a fake response
			HttpResponse res = new HttpResponse();
			res.setBody('Working');
			res.setStatusCode(200);
			return res;

		}
	}

	private class AsyncGetHttpCalloutMock implements HttpCalloutMock {
		public HTTPResponse respond(HTTPRequest req) {

			System.assertEquals('http://getme.com', req.getEndpoint());
			System.assertEquals('GET', req.getMethod());
			System.assertEquals('1', req.getHeader('One'));
			System.assertEquals('Content', req.getBody());

			// Create a fake response
			HttpResponse res = new HttpResponse();
			res.setBody('Working');
			res.setStatusCode(200);
			return res;

		}
	}


}