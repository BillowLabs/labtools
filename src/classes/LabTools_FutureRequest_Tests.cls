@isTest
private class LabTools_FutureRequest_Tests
{
	@isTest
	static void WhenUsingGet_ShouldSetMethodAndEndpoint()
	{
		LabTools_FutureRequest request = new LabTools_FutureRequest();

		Test.startTest();
		request.SetEndpoint('http://www.google.com');
		Test.stopTest();

		System.assertEquals('http://www.google.com', request.endpoint);
		System.assertEquals('GET', request.method);
	}

	@isTest
	static void WhenUsingSetEndpointAndMethod_ShouldSetMethodAndEndpoint()
	{
		LabTools_FutureRequest request = new LabTools_FutureRequest();

		Test.startTest();
		request.SetEndpoint('http://www.google.com', 'POST');
		Test.stopTest();

		System.assertEquals('http://www.google.com', request.endpoint);
		System.assertEquals('POST', request.method);
	}


	@isTest
	static void WhenSettingHandler_ShouldUseTypeName()
	{
		LabTools_FutureRequest request = new LabTools_FutureRequest();

		Test.startTest();
		request.SetHandler(TestResponseHandler.class);
		Test.stopTest();

		System.assertEquals(TestResponseHandler.class.getName(), request.handler);
	}


	@isTest
	static void WhenAddingHeader_ShouldAddKeyValue()
	{
		LabTools_FutureRequest request = new LabTools_FutureRequest();

		Test.startTest();
		request.AddHeader('One', '1');
		request.AddHeader('Two', '2');
		Test.stopTest();

		System.assertEquals(2, request.headers.size());
		System.assertEquals('1', request.headers.get('One'));
		System.assertEquals('2', request.headers.get('Two'));
	}


	@isTest
	static void WhenSettingBody_ShouldSetBody()
	{
		LabTools_FutureRequest request = new LabTools_FutureRequest();

		Test.startTest();
		request.SetBody('One Two Three');
		Test.stopTest();

		System.assertEquals('One Two Three', request.body);
	}



	@isTest
	static void WhenHandlerDoesntImplementInterface_ShouldThrowException()
	{
		LabTools_FutureRequest request = new LabTools_FutureRequest();
		Boolean exceptionThrown = false;

		Test.startTest();
		try {
			request.SetHandler(LabTools_FutureRequest_Tests.class);
		} catch(LabTools_ApplicationException ex) {
			exceptionThrown = true;
		}
		Test.stopTest();

		System.assert(exceptionThrown);
	}


	public class TestResponseHandler implements LabTools_IHttpResponseHandler {
		// NOTE: this class must remain public in order to be instantiated as a handler.
		public void Handle(HttpResponse response) {}
	}
}
