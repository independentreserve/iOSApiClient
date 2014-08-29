//
//  IRAPIManagerTestCase.h
//  APIClient
//
//  Created by Maxim Pervushin on 29/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IRAPIManager.h"
#import "IRConstants.h"
#import "IRFakeNetworkManager.h"

@interface IRAPIManagerTestCase : XCTestCase

@property (nonatomic, strong, readonly) IRFakeNetworkManager *fakeNetworkManager;

@end
