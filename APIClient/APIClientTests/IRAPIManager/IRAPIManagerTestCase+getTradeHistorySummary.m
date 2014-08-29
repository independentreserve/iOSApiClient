//
//  IRAPIManagerTestCase+getTradeHistorySummary.m
//  APIClient
//
//  Created by Maxim Pervushin on 29/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRAPIManagerTestCase+getTradeHistorySummary.h"

@implementation IRAPIManagerTestCase (getTradeHistorySummary)

- (void)test_getTradeHistorySummary_sendsDataToNetworkManager {
    [[IRAPIManager manager] getTradeHistorySummaryForPrimaryCurrencyCode:nil secondaryCurrencyCode:nil numberOfHoursInThePastToRetrieve:nil responseHandler:nil];
    NSString *expectedURLString = [NSString stringWithFormat:@"/%@", IRAPI_GetTradeHistorySummaryMethod];
    XCTAssertEqualObjects(self.fakeNetworkManager.lastURLString, expectedURLString);
    XCTAssertNotNil(self.fakeNetworkManager.lastParameters);
}

@end
