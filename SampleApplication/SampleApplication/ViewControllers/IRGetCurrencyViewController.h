//
//  IRGetCurrencyViewController.h
//  SampleApplication
//
//  Created by Maxim Pervushin on 25/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IRCellDelegate;

@interface IRGetCurrencyViewController : UIViewController

@property (nonatomic, copy) NSString *parameterName;
@property (nonatomic, copy) NSString *initialValue;

@property (nonatomic, weak) id <IRCellDelegate> parameterDelegate;

@end
