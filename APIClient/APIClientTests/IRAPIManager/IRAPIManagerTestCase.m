//
//  IRAPIManagerTestCase.m
//  APIClient
//
//  Created by Maxim Pervushin on 29/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRAPIManagerTestCase.h"
#import "IRFakeNetworkManager.h"

@implementation IRAPIManagerTestCase
@synthesize fakeNetworkManager = fakeNetworkManager_;

- (IRFakeNetworkManager *)fakeNetworkManager {
    if (fakeNetworkManager_ == nil) {
        fakeNetworkManager_ = [IRFakeNetworkManager new];
    }

    return fakeNetworkManager_;
}

- (void)setUp {
    [super setUp];
    [IRAPIManager manager].networkManager = self.fakeNetworkManager;
    [IRAPIManager manager].publicAPIRoot = @"";
    [IRAPIManager manager].privateAPIRoot = @"";
}

- (void)tearDown {
    [super tearDown];
}

@end
