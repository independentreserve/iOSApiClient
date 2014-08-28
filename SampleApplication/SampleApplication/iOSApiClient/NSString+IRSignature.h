//
// Created by Maxim Pervushin on 21/08/14.
// Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
    @category
        IRSignature
 */
@interface NSString (IRSignature)

/*!
    @method
        signatureStringWithAPIKey:apiSecret:nonce:

    @abstract
        Signature is a HMAC-SHA256 encoded message containing the nonce and API key. The HMAC-SHA256 code must be generated using the API Secret that was generated with your API key. This code must be converted to it's hexadecimal representation (64 uppercase characters).

    @param
        apiKey
            Independent Reserve API Key.

    @param
        apiSecret
            Independent Reserve API Secret.

    @param
        nonce
            String representation of a 64 bit unsigned integer. The nonce must increase with each request made to the API.

    @return
        NSString object containing calculated signature.
 */
+ (NSString *)signatureStringWithAPIKey:(NSString *)apiKey apiSecret:(NSString *)apiSecret nonce:(NSString *)nonce;

@end