//
//  IRGetOptionViewController.h
//  SampleApplication
//
//  Created by Maxim Pervushin on 26/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRGetValueViewController.h"

/*
    IRGetValueViewController inheritor with multiple string options.
 */
@interface IRGetOptionViewController : IRGetValueViewController

@property (nonatomic, strong) NSArray *options;

@end
