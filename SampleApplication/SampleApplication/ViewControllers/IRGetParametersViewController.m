//
//  IRGetParametersViewController.m
//  SampleApplication
//
//  Created by Maxim Pervushin on 20/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRGetParametersViewController.h"
#import "IRRequestMethodViewController.h"

@interface IRGetParametersViewController ()

@property (nonatomic, weak) IBOutlet UISegmentedControl *primaryCurrencyCodesSegmentedControl;
@property (nonatomic, weak) IBOutlet UISegmentedControl *secondaryCurrencyCodesSegmentedControl;
@property (nonatomic, weak) IBOutlet UITextField *numberOfHoursInThePastToRetrieveTextField;
@property (nonatomic, weak) IBOutlet UITextField *numberOfRecentTradesToRetrieveTextField;

- (void)updateUI;

- (NSDictionary *)getParameters;

@end

@implementation IRGetParametersViewController

- (void)updateUI {
    self.primaryCurrencyCodesSegmentedControl.hidden = [self.requiredParameters indexOfObject:@"primaryCurrencyCode"] == NSNotFound;
    self.secondaryCurrencyCodesSegmentedControl.hidden = [self.requiredParameters indexOfObject:@"secondaryCurrencyCode"] == NSNotFound;
    self.numberOfHoursInThePastToRetrieveTextField.hidden = [self.requiredParameters indexOfObject:@"numberOfHoursInThePastToRetrieve"] == NSNotFound;
    self.numberOfRecentTradesToRetrieveTextField.hidden = [self.requiredParameters indexOfObject:@"numberOfRecentTradesToRetrieve"] == NSNotFound;
}

- (NSDictionary *)getParameters {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    if (!self.primaryCurrencyCodesSegmentedControl.hidden) {
        parameters[@"primaryCurrencyCode"] = [self.primaryCurrencyCodesSegmentedControl titleForSegmentAtIndex:self.primaryCurrencyCodesSegmentedControl.selectedSegmentIndex];
    }
    if (!self.secondaryCurrencyCodesSegmentedControl.hidden) {
        parameters[@"secondaryCurrencyCode"] = [self.secondaryCurrencyCodesSegmentedControl titleForSegmentAtIndex:self.secondaryCurrencyCodesSegmentedControl.selectedSegmentIndex];
    }
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    if (!self.numberOfHoursInThePastToRetrieveTextField.hidden) {
        parameters[@"numberOfHoursInThePastToRetrieve"] = [formatter numberFromString:self.numberOfHoursInThePastToRetrieveTextField.text];
    }
    if (!self.numberOfRecentTradesToRetrieveTextField.hidden) {
        parameters[@"numberOfRecentTradesToRetrieve"] = [formatter numberFromString:self.numberOfRecentTradesToRetrieveTextField.text];
    }
    return [parameters copy];
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateUI];
    [super viewWillAppear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"RequestMethod"] && [segue.destinationViewController isKindOfClass:IRRequestMethodViewController.class]) {
        IRRequestMethodViewController *requestMethodViewController = segue.destinationViewController;
        requestMethodViewController.methodName = self.method;
        requestMethodViewController.methodParameters = [self getParameters];
    }
}

@end
