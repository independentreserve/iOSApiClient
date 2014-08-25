//
//  IRGetCurrencyViewController.m
//  SampleApplication
//
//  Created by Maxim Pervushin on 25/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRGetCurrencyViewController.h"
#import "IRCellDelegate.h"

@interface IRGetCurrencyViewController ()

@property (nonatomic, weak) IBOutlet UILabel *parameterNameLabel;
@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)acceptNewValue:(id)sender;

- (IBAction)declineNewValue:(id)sender;

@end

@implementation IRGetCurrencyViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.parameterNameLabel.text = self.parameterName;

//    NSUInteger index = 0;
//    index = [self.segmentedControl index]
}

- (IBAction)acceptNewValue:(id)sender {
    if ([self.parameterDelegate respondsToSelector:@selector(cellValueWithKey:changed:)]) {
        NSString *parameterValue = [self.segmentedControl titleForSegmentAtIndex:self.segmentedControl.selectedSegmentIndex];
        [self.parameterDelegate cellValueWithKey:self.parameterName changed:parameterValue];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)declineNewValue:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
