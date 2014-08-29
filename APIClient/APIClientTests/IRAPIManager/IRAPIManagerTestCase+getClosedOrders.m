//
//  IRAPIManagerTestCase+getClosedOrders.m
//  APIClient
//
//  Created by Maxim Pervushin on 29/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRAPIManagerTestCase+getClosedOrders.h"

@implementation IRAPIManagerTestCase (getClosedOrders)

- (void)test_getClosedOrders_sendsDataToNetworkManager {
    [[IRAPIManager manager] getClosedOrdersWithPrimaryCurrencyCode:nil secondaryCurrencyCode:nil pageIndex:nil pageSize:nil responseHandler:nil];
    NSString *expectedURLString = [NSString stringWithFormat:@"/%@", IRAPI_GetClosedOrdersMethod];
    XCTAssertEqualObjects(self.fakeNetworkManager.lastURLString, expectedURLString);
    XCTAssertNotNil(self.fakeNetworkManager.lastParameters);
}

@end
