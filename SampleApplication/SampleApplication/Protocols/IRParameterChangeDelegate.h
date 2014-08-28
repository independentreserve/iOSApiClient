//
//  IRParameterChangeDelegate.h
//  SampleApplication
//
//  Created by Maxim Pervushin on 25/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 Declares a method for tracking parameter value changes.
 */
@protocol IRParameterChangeDelegate <NSObject>

- (void)parameter:(NSString *)parameter valueChanged:(id)newValue;

@end
