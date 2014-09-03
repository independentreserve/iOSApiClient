iOSApiClient
============

Independent Reserve Objective-C API client and sample application for iOS

The client wraps up all of the private and public methods exposed by the Independent Reserve API, and handles authentication when it is configured with a valid API Key and API Secret.
It is designed to be easily plugged in by 3rd party developers into their own applications.

The sample application shows how to use the client in a simple iOS application.

Refer to https://www.independentreserve.com/API  for API documentation

###System Requirements

* Xcode 5 with iOS 7 and later support

###Steps to build

* You can compile both the client and the static library in Xcode. To build the universal static library use the 'APIClientUniversalLibrary' target
* Precompiled static library can be found in the 'Binaries' folder

###Configuring Sample Application

To start sample application you need to set your Independent Reserve API Key and API Secret. You can do it in two ways:

* Set them in SampleApplication-Info.plist file. Add values for IndependentReserveAPIKey and IndependentReserveAPISecret keys;
* Set them in code. [IRAPIManager manager].apiKey = @"your-api-key" and [IRAPIManager manager].apiSecret = @"your-api-secret"



##Need help?

Contact us at support@independentreserve.com
