//
//  IRAPIManagerTestCase+getRecentTrades.m
//  APIClient
//
//  Created by Maxim Pervushin on 29/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRAPIManagerTestCase+getRecentTrades.h"

@implementation IRAPIManagerTestCase (getRecentTrades)

- (void)test_getRecentTrades_sendsDataToNetworkManager {
    [[IRAPIManager manager] getRecentTradesForPrimaryCurrencyCode:nil secondaryCurrencyCode:nil numberOfRecentTradesToRetrieve:nil responseHandler:nil];
    NSString *expectedURLString = [NSString stringWithFormat:@"/%@", IRAPI_GetRecentTradesMethod];
    XCTAssertEqualObjects(self.fakeNetworkManager.lastURLString, expectedURLString);
    XCTAssertNotNil(self.fakeNetworkManager.lastParameters);
}

@end
