//
//  IRGetValueViewController.m
//  SampleApplication
//
//  Created by Maxim Pervushin on 26/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRGetValueViewController.h"
#import "IRParameterChangeDelegate.h"

@interface IRGetValueViewController ()

@property (nonatomic, weak) IBOutlet UILabel *parameterNameLabel;

- (IBAction)acceptNewValue:(id)sender;

- (IBAction)declineNewValue:(id)sender;

@end

@implementation IRGetValueViewController

#pragma mark - Methods
#pragma mark Methods (Private)

- (IBAction)acceptNewValue:(id)sender {
    if ([self.parameterDelegate respondsToSelector:@selector(parameter:valueChanged:)]) {
        [self.parameterDelegate parameter:self.parameterName valueChanged:self.currentParameterValue];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)declineNewValue:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Methods (Overloaded)

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.parameterNameLabel.text = self.parameterName;
}


@end
