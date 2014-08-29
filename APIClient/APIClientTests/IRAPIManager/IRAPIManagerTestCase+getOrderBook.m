//
//  IRAPIManagerTestCase+getOrderBook.m
//  APIClient
//
//  Created by Maxim Pervushin on 29/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRAPIManagerTestCase+getOrderBook.h"

@implementation IRAPIManagerTestCase (getOrderBook)

- (void)test_getOrderBook_sendsDataToNetworkManager {
    [[IRAPIManager manager] getOrderBookForPrimaryCurrencyCode:nil secondaryCurrencyCode:nil responseHandler:nil];
    NSString *expectedURLString = [NSString stringWithFormat:@"/%@", IRAPI_GetOrderBookMethod];
    XCTAssertEqualObjects(self.fakeNetworkManager.lastURLString, expectedURLString);
    XCTAssertNotNil(self.fakeNetworkManager.lastParameters);
}

@end
