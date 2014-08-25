//
//  IRGetNumberViewController.m
//  SampleApplication
//
//  Created by Maxim Pervushin on 25/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRGetNumberViewController.h"
#import "IRCellDelegate.h"
#import "IRConstants.h"

@interface IRGetNumberViewController ()

@property (nonatomic, weak) IBOutlet UILabel *parameterNameLabel;
@property (nonatomic, weak) IBOutlet UITextField *textField;

- (IBAction)acceptNewValue:(id)sender;

- (IBAction)declineNewValue:(id)sender;

@end

@implementation IRGetNumberViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.parameterNameLabel.text = self.parameterName;
    if ([self.parameterName isEqualToString:IRAPI_NumberOfHoursInThePastToRetrieveParameter]
        || [self.parameterName isEqualToString:IRAPI_NumberOfRecentTradesToRetrieveParameter]) {
        self.textField.text = [(NSNumber *)self.initialValue stringValue];
    } else {
        self.textField.text = @"";
    }
}

- (IBAction)acceptNewValue:(id)sender {
    if ([self.parameterDelegate respondsToSelector:@selector(cellValueWithKey:changed:)]) {
        [self.parameterDelegate cellValueWithKey:self.parameterName changed:[NSNumber numberWithInteger:self.textField.text.integerValue]];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)declineNewValue:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
