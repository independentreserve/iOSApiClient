iOSApiClient
============

Independent Reserve Objective-C API client and sample application for iOS

The client wraps up all of the private and public methods exposed by the Independent Reserve API, and handles authentication when it is configured with a valid API Key and API Secret.

It is designed to be easily plugged in by 3rd party developers into their own applications.

The sample application shows how to use the client in a simple iOS application setting.

Refer to https://www.independentreserve.com/API  for full API documentation.

###System Requirements

* Xcode 5.11 with iOS 7 or later support

###Steps to build

* You can compile both the client and the static library in Xcode. To build the universal static library use the 'APIClientUniversalLibrary' target.
* Use the SampleApplication target if you wish to run the sample app in a simulator or on your device.
* A precompiled static library can be found in the 'Binaries' folder.

###Configuring Sample Application

To run the sample application you need to first configure your API Key and API Secret. These can be generated on the Settings page at https://www.independentreserve.com. 

You can configure the Sample Application in two ways:

* Update the SampleApplication-Info.plist file and set correct values for the IndependentReserveAPIKey and IndependentReserveAPISecret keys;

OR

* Set the values directly in code. [IRAPIManager manager].apiKey = @"your-api-key" and [IRAPIManager manager].apiSecret = @"your-api-secret"

Once you have configured the application, you need to remove the two #error processor directives in the IRAppDelegate class. These are purely there to remind you to set the config before running the app.


##Need help?

Contact us at support@independentreserve.com
