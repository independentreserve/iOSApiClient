//
//  IRGetDateViewController.m
//  SampleApplication
//
//  Created by Maxim Pervushin on 26/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRGetDateViewController.h"

@interface IRGetDateViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation IRGetDateViewController

#pragma mark - Methods
#pragma mark Methods (Overloaded)

- (id)currentParameterValue {
    return self.datePicker.date;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.datePicker.date = self.initialParameterValue;
}

@end
