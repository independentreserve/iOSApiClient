//
// Created by Maxim Pervushin on 21/08/14.
// Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "NSData+IRHexadecimalString.h"


@implementation NSData (IRHexadecimalString)

- (NSString *)hexadecimalString {
    const unsigned char *dataBuffer = (const unsigned char *) [self bytes];

    if (!dataBuffer) {
        return [NSString string];
    }

    NSUInteger dataLength = [self length];
    NSMutableString *hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];

    for (int i = 0; i < dataLength; ++i) {
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long) dataBuffer[i]]];
    }

    return [NSString stringWithString:hexString];
}

@end