//
//  IRCellDelegate.h
//  SampleApplication
//
//  Created by Maxim Pervushin on 25/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IRCellDelegate <NSObject>

- (void)cellValueWithKey:(NSString *)key changed:(id)newValue;

@end
