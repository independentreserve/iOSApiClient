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
    
#error Set valid API key. Use [IRAPIManager manager].apiKey = @"your-api-key" or add object "IndependentReserveAPIKey" to info.plist file.
#error Set valid API secret. Use [IRAPIManager manager].apiSecret = @"your-api-secret" or add object "IndependentReserveAPISecret" to info.plist file.

    return YES;
}

@end
