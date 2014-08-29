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
    // Use development API roots
    [IRAPIManager manager].publicAPIRoot = @"http://dev.api.independentreserve.com/Public";
    [IRAPIManager manager].privateAPIRoot = @"http://dev.api.independentreserve.com/Private";
    // Use custom network manager
    [IRAPIManager manager].networkManager = [IRSampleNetworkManager manager];
    // Set apiKey and apiSecret of IRAPIManager object or add IndependentReserveAPIKey and IndependentReserveAPISecret properties to application info.plist.
    [IRAPIManager manager].apiKey = @"60109b31-9bcb-4a4b-a5ed-a8002d3097db";
    [IRAPIManager manager].apiSecret = @"06e2e9606ea348dd9e635cb273868280";

    return YES;
}

@end
