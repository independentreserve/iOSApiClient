//
//  NSString_IRSignatureTestCase.m
//  APIClient
//
//  Created by Maxim Pervushin on 29/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+IRSignature.h"

@interface NSString_IRSignatureTestCase : XCTestCase

@end

@implementation NSString_IRSignatureTestCase

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testCreatesValidSignatureString {
    NSString *apiKeyString = @"11111111-1111-1111-1111-111111111111";
    NSString *nonceString = @"1111111111";
    NSString *apiSecretString = @"11111111111111111111111111111111";

    NSString *signature = [NSString signatureStringWithAPIKey:apiKeyString apiSecret:apiSecretString nonce:nonceString];

    XCTAssertEqualObjects(@"C1EE92FF415392B333F5CCD7634D0724DFD7C845ED3028E0BF5C497FFDD34F59", signature);
}

@end
