//
// Created by Maxim Pervushin on 21/08/14.
// Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "NSString+IRSignature.h"
#import "NSData+IRHexadecimalString.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (IRSignature)

+ (NSString *)signatureStringWithAPISecret:(NSString *)apiSecret apiKey:(NSString *)apiKey nonce:(NSString *)nonce {

    NSData *apiSecretData = [apiSecret dataUsingEncoding:NSUTF8StringEncoding];

    NSString *message = [NSString stringWithFormat:@"%@%@", nonce, apiKey];
    NSData *messageData = [message dataUsingEncoding:NSUTF8StringEncoding];

    NSMutableData* hash = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];

    CCHmac(kCCHmacAlgSHA256, apiSecretData.bytes, apiSecretData.length, messageData.bytes, messageData.length, hash.mutableBytes);

    return [[hash hexadecimalString] uppercaseString];
}

@end