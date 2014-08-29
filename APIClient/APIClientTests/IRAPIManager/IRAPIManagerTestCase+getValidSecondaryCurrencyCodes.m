//
//  IRAPIManagerTestCase+getValidSecondaryCurrencyCodes.m
//  APIClient
//
//  Created by Maxim Pervushin on 29/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRAPIManagerTestCase+getValidSecondaryCurrencyCodes.h"

@implementation IRAPIManagerTestCase (getValidSecondaryCurrencyCodes)

- (void)test_getValidSecondaryCurrencyCodes_sendsDataToNetworkManager {
    [[IRAPIManager manager] getValidSecondaryCurrencyCodesResponseHandler:nil];
    NSString *expectedURLString = [NSString stringWithFormat:@"/%@", IRAPI_GetValidSecondaryCurrencyCodesMethod];
    XCTAssertEqualObjects(self.fakeNetworkManager.lastURLString, expectedURLString);
    XCTAssertNil(self.fakeNetworkManager.lastParameters);
}

@end
