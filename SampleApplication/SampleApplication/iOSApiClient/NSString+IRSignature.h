//
// Created by Maxim Pervushin on 21/08/14.
// Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IRSignature)

+ (NSString *)signatureStringWithAPISecret:(NSString *)apiSecret apiKey:(NSString *)apiKey nonce:(NSString *)nonce;

@end