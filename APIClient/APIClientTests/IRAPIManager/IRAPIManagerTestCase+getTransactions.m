//
//  IRAPIManagerTestCase+getTransactions.m
//  APIClient
//
//  Created by Maxim Pervushin on 29/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRAPIManagerTestCase+getTransactions.h"

@implementation IRAPIManagerTestCase (getTransactions)

- (void)test_getTransactions_sendsDataToNetworkManager {
    [[IRAPIManager manager] getTransactionsWithAccountGUID:nil fromDate:nil toDate:nil pageIndex:nil pageSize:nil responseHandler:nil];
    NSString *expectedURLString = [NSString stringWithFormat:@"/%@", IRAPI_GetTransactionsMethod];
    XCTAssertEqualObjects(self.fakeNetworkManager.lastURLString, expectedURLString);
    XCTAssertNotNil(self.fakeNetworkManager.lastParameters);
}

@end
