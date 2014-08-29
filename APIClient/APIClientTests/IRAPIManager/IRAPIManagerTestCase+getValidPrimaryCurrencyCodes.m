//
//  IRAPIManagerTestCase+getValidPrimaryCurrencyCodes.m
//  APIClient
//
//  Created by Maxim Pervushin on 29/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRAPIManagerTestCase+getValidPrimaryCurrencyCodes.h"


@implementation IRAPIManagerTestCase (getValidPrimaryCurrencyCodes)

- (void)test_getValidPrimaryCurrencyCodes_sendsDataToNetworkManager {
    [[IRAPIManager manager] getValidPrimaryCurrencyCodesResponseHandler:nil];
    NSString *expectedURLString = [NSString stringWithFormat:@"/%@", IRAPI_GetValidPrimaryCurrencyCodesMethod];
    XCTAssertEqualObjects(self.fakeNetworkManager.lastURLString, expectedURLString);
    XCTAssertNil(self.fakeNetworkManager.lastParameters);
}

@end
