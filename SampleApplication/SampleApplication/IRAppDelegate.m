//
//  IRAppDelegate.m
//  SampleApplication
//
//  Created by Maxim Pervushin on 19/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRAppDelegate.h"
#import "IRSampleNetworkManager.h"
#import <APIClient/IRAPIManager.h>

@implementation IRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Use custom network manager
    [IRAPIManager manager].networkManager = [IRSampleNetworkManager manager];
    // Set apiKey and apiSecret of IRAPIManager object or add IndependentReserveAPIKey and IndependentReserveAPISecret properties to application info.plist.
    
#error You should provide valid Independent Reserve API key and API secret. You can do it in two ways:\
    1. Set them in SampleApplication-Info.plist file. Add values for IndependentReserveAPIKey and IndependentReserveAPISecret keys; \
    2. Set them in code. [IRAPIManager manager].apiKey = @"your-api-key" and [IRAPIManager manager].apiSecret = @"your-api-secret"

    return YES;
}

@end
