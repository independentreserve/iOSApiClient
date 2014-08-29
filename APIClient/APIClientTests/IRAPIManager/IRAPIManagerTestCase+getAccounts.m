//
//  IRAPIManagerTestCase+getAccounts.m
//  APIClient
//
//  Created by Maxim Pervushin on 29/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRAPIManagerTestCase+getAccounts.h"

@implementation IRAPIManagerTestCase (getAccounts)

- (void)test_getAccounts_sendsDataToNetworkManager {
    [[IRAPIManager manager] getAccountsWithResponseHandler:nil];
    NSString *expectedURLString = [NSString stringWithFormat:@"/%@", IRAPI_GetAccountsMethod];
    XCTAssertEqualObjects(self.fakeNetworkManager.lastURLString, expectedURLString);
    XCTAssertNotNil(self.fakeNetworkManager.lastParameters);
}

@end
