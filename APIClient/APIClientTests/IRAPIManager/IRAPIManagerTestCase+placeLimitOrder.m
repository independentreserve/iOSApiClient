//
//  IRAPIManagerTestCase+placeLimitOrder.m
//  APIClient
//
//  Created by Maxim Pervushin on 29/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRAPIManagerTestCase+placeLimitOrder.h"

@implementation IRAPIManagerTestCase (placeLimitOrder)

- (void)test_placeLimitOrder_sendsDataToNetworkManager {
    [[IRAPIManager manager] placeLimitOrderWithPrimaryCurrencyCode:nil secondaryCurrencyCode:nil orderType:nil price:nil volume:nil responseHandler:nil];
    NSString *expectedURLString = [NSString stringWithFormat:@"/%@", IRAPI_PlaceLimitOrderMethod];
    XCTAssertEqualObjects(self.fakeNetworkManager.lastURLString, expectedURLString);
    XCTAssertNotNil(self.fakeNetworkManager.lastParameters);
}

@end
