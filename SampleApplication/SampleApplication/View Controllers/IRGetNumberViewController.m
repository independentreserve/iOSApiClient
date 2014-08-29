//
//  IRGetNumberViewController.m
//  SampleApplication
//
//  Created by Maxim Pervushin on 25/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRGetNumberViewController.h"

@interface IRGetNumberViewController ()

@property (nonatomic, weak) IBOutlet UITextField *textField;

@end

@implementation IRGetNumberViewController

#pragma mark - Methods
#pragma mark Methods (Overloaded)

- (id)currentParameterValue {
    return @(self.textField.text.floatValue);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.textField.text = [(NSNumber *) self.initialParameterValue stringValue];
}

@end
