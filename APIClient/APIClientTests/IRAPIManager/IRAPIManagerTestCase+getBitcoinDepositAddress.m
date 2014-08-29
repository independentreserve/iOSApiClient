//
//  IRAPIManagerTestCase+getBitcoinDepositAddress.m
//  APIClient
//
//  Created by Maxim Pervushin on 29/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRAPIManagerTestCase+getBitcoinDepositAddress.h"

@implementation IRAPIManagerTestCase (getBitcoinDepositAddress)

- (void)test_getBitcoinDepositAddress_sendsDataToNetworkManager {
    [[IRAPIManager manager] getBitcoinDepositAddressWithResponseHandler:nil];
    NSString *expectedURLString = [NSString stringWithFormat:@"/%@", IRAPI_GetBitcoinDepositAddressMethod];
    XCTAssertEqualObjects(self.fakeNetworkManager.lastURLString, expectedURLString);
    XCTAssertNotNil(self.fakeNetworkManager.lastParameters);
}

@end
