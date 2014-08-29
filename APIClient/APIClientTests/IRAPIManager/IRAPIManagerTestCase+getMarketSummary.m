//
//  IRAPIManagerTestCase+getMarketSummary.m
//  APIClient
//
//  Created by Maxim Pervushin on 29/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRAPIManagerTestCase+getMarketSummary.h"

@implementation IRAPIManagerTestCase (getMarketSummary)

- (void)test_getMarketSummary_sendsDataToNetworkManager {
    [[IRAPIManager manager] getMarketSummaryForPrimaryCurrencyCode:nil secondaryCurrencyCode:nil responseHandler:nil];
    NSString *expectedURLString = [NSString stringWithFormat:@"/%@", IRAPI_GetMarketSummaryMethod];
    XCTAssertEqualObjects(self.fakeNetworkManager.lastURLString, expectedURLString);
    XCTAssertNotNil(self.fakeNetworkManager.lastParameters);
}

@end
