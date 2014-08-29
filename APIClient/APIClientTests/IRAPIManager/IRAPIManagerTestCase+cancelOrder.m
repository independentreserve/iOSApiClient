//
//  IRAPIManagerTestCase+cancelOrder.m
//  APIClient
//
//  Created by Maxim Pervushin on 29/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRAPIManagerTestCase+cancelOrder.h"

@implementation IRAPIManagerTestCase (cancelOrder)

- (void)test_cancelOrder_sendsDataToNetworkManager {
    [[IRAPIManager manager] cancelOrderWithGUID:nil responseHandler:nil];
    NSString *expectedURLString = [NSString stringWithFormat:@"/%@", IRAPI_CancelOrderMethod];
    XCTAssertEqualObjects(self.fakeNetworkManager.lastURLString, expectedURLString);
    XCTAssertNotNil(self.fakeNetworkManager.lastParameters);
}

@end
