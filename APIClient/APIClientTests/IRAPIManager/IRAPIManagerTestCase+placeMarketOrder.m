//
//  IRAPIManagerTestCase+placeMarketOrder.m
//  APIClient
//
//  Created by Maxim Pervushin on 29/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRAPIManagerTestCase+placeMarketOrder.h"

@implementation IRAPIManagerTestCase (placeMarketOrder)

- (void)test_placeMarketOrder_sendsDataToNetworkManager {
    [[IRAPIManager manager] placeMarketOrderWithPrimaryCurrencyCode:nil secondaryCurrencyCode:nil orderType:nil volume:nil responseHandler:nil];
    NSString *expectedURLString = [NSString stringWithFormat:@"/%@", IRAPI_PlaceMarketOrderMethod];
    XCTAssertEqualObjects(self.fakeNetworkManager.lastURLString, expectedURLString);
    XCTAssertNotNil(self.fakeNetworkManager.lastParameters);
}

@end
