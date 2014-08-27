//
//  IRGetStringViewController.m
//  SampleApplication
//
//  Created by Maxim Pervushin on 26/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRGetStringViewController.h"

@interface IRGetStringViewController ()

@property (nonatomic, weak) IBOutlet UITextField *textField;

@end

@implementation IRGetStringViewController

#pragma mark - Methods
#pragma mark Methods (Overloaded)

- (id)currentParameterValue {
    return self.textField.text;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.textField.text = self.initialParameterValue;
}

@end
