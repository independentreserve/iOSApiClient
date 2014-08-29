//
//  IRGetValueViewController.h
//  SampleApplication
//
//  Created by Maxim Pervushin on 26/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IRParameterChangeDelegate;

@interface IRGetValueViewController : UIViewController

@property (nonatomic, copy) NSString *parameterName;
@property (nonatomic, strong) id initialParameterValue;
@property (nonatomic, readonly) id currentParameterValue;
@property (nonatomic, weak) id <IRParameterChangeDelegate> parameterDelegate;

@end
