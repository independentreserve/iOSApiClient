//
//  IRGetParametersTableViewController.h
//  SampleApplication
//
//  Created by Maxim Pervushin on 20/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
    Shows a list of parameters for Independent Reserve API method.
 */
@interface IRGetParametersTableViewController : UITableViewController

@property (nonatomic, copy) NSString *methodName;
@property (nonatomic, strong) NSArray *requiredParameters;
@property (nonatomic, strong) NSMutableDictionary *parameters;

@end
