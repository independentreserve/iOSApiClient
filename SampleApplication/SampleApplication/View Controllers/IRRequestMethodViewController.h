//
//  IRRequestMethodViewController.h
//  SampleApplication
//
//  Created by Maxim Pervushin on 20/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
    Performs request to Independent Reserve API and shows result.
 */
@interface IRRequestMethodViewController : UIViewController

@property (nonatomic, copy) NSString *methodName;
@property (nonatomic, copy) NSDictionary *methodParameters;

@end
