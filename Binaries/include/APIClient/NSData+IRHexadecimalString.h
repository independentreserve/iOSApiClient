//
// Created by Maxim Pervushin on 21/08/14.
// Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
    @category   
        IRHexadecimalString
 */
@interface NSData (IRHexadecimalString)

/*!
    @method
        hexadecimalString

    @return
        NSString object containing hexadecimal representation of NSData object.
 */
- (NSString *)hexadecimalString;

@end