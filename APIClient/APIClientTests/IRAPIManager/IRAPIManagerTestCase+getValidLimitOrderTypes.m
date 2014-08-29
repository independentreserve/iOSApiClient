//
//  IRAPIManagerTestCase+getValidLimitOrderTypes.m
//  
//
//  Created by Maxim Pervushin on 29/08/14.
//
//

#import "IRAPIManagerTestCase+getValidLimitOrderTypes.h"

@implementation IRAPIManagerTestCase (getValidLimitOrderTypes)

- (void)test_getValidLimitOrderTypes_sendsDataToNetworkManager {
    [[IRAPIManager manager] getValidLimitOrderTypesResponseHandler:nil];
    NSString *expectedURLString = [NSString stringWithFormat:@"/%@", IRAPI_GetValidLimitOrderTypesMethod];
    XCTAssertEqualObjects(self.fakeNetworkManager.lastURLString, expectedURLString);
    XCTAssertNil(self.fakeNetworkManager.lastParameters);
}

@end
