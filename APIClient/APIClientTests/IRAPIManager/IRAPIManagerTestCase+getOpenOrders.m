//
//  IRAPIManagerTestCase+getOpenOrders.m
//  APIClient
//
//  Created by Maxim Pervushin on 29/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRAPIManagerTestCase+getOpenOrders.h"

@implementation IRAPIManagerTestCase (getOpenOrders)

- (void)test_getOpenOrders_sendsDataToNetworkManager {
    [[IRAPIManager manager] getOpenOrdersWithPrimaryCurrencyCode:nil secondaryCurrencyCode:nil pageIndex:nil pageSize:nil responseHandler:nil];
    NSString *expectedURLString = [NSString stringWithFormat:@"/%@", IRAPI_GetOpenOrdersMethod];
    XCTAssertEqualObjects(self.fakeNetworkManager.lastURLString, expectedURLString);
    XCTAssertNotNil(self.fakeNetworkManager.lastParameters);
}

@end
