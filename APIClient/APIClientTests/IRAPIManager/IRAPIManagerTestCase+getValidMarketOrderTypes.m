//
//  IRAPIManagerTestCase+getValidMarketOrderTypes.m
//  APIClient
//
//  Created by Maxim Pervushin on 29/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRAPIManagerTestCase+getValidMarketOrderTypes.h"

@implementation IRAPIManagerTestCase (getValidMarketOrderTypes)

- (void)test_getValidMarketOrderTypes_sendsDataToNetworkManager {
    [[IRAPIManager manager] getValidMarketOrderTypesResponseHandler:nil];
    NSString *expectedURLString = [NSString stringWithFormat:@"/%@", IRAPI_GetValidMarketOrderTypesMethod];
    XCTAssertEqualObjects(self.fakeNetworkManager.lastURLString, expectedURLString);
    XCTAssertNil(self.fakeNetworkManager.lastParameters);
}

@end
