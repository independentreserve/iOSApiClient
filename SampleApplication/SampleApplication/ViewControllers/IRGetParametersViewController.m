//
//  IRGetParametersViewController.m
//  SampleApplication
//
//  Created by Maxim Pervushin on 20/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRGetParametersViewController.h"
#import "IRRequestMethodViewController.h"
#import "IRConstants.h"
#import "IRCellDelegate.h"
#import "IRParameterTableViewCell.h"
#import "IRGetCurrencyViewController.h"
#import "IRGetNumberViewController.h"

@interface IRGetParametersViewController () <IRCellDelegate>

@property (nonatomic, strong, readonly) NSDictionary *defaultParameters;
@property (nonatomic, strong, readonly) NSDictionary *parametersAliases;

- (void)getParameter;

@end

@implementation IRGetParametersViewController
@synthesize defaultParameters = defaultParameters_;
@synthesize parametersAliases = parametersAliases_;
@synthesize requiredParameters = requiredParameters_;

- (NSDictionary *)defaultParameters {
    if (defaultParameters_ == nil) {
        defaultParameters_ = @{
            IRAPI_AccountGUIDParameter : @"11111111-1111-1111-1111-111111111111",
            IRAPI_FromTimestampUTCParameter : [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * 7], // Today minus one week
            IRAPI_NumberOfHoursInThePastToRetrieveParameter : @(24),
            IRAPI_NumberOfRecentTradesToRetrieveParameter : @(10),
            IRAPI_OrderGUIDParameter : @"11111111-1111-1111-1111-111111111111",
            IRAPI_OrderTypeParameter : @"",
            IRAPI_PageIndexParameter : @"",
            IRAPI_PageSizeParameter : @"",
            IRAPI_PriceParameter : @"",
            IRAPI_PrimaryCurrencyCodeParameter : @"Xbt",
            IRAPI_SecondaryCurrencyCodeParameter : @"Usd",
            IRAPI_ToTimestampUTCParameter : [NSDate dateWithTimeIntervalSinceNow:0], // Today
            IRAPI_VolumeParameter : @""
        };
    }

    return defaultParameters_;
}

- (NSDictionary *)parametersAliases {
    if (parametersAliases_ == nil) {
        parametersAliases_ = @{
            IRAPI_AccountGUIDParameter : @"Account Guid:",
            IRAPI_FromTimestampUTCParameter : @"From Timestamp:", // Today minus one week
            IRAPI_NumberOfHoursInThePastToRetrieveParameter : @"Number Of Hours:",
            IRAPI_NumberOfRecentTradesToRetrieveParameter : @"Number Of Trades:",
            IRAPI_OrderGUIDParameter : @"",
            IRAPI_OrderTypeParameter : @"",
            IRAPI_PageIndexParameter : @"",
            IRAPI_PageSizeParameter : @"",
            IRAPI_PriceParameter : @"",
            IRAPI_PrimaryCurrencyCodeParameter : @"Primary Currency:",
            IRAPI_SecondaryCurrencyCodeParameter : @"Secondary Currency:",
            IRAPI_ToTimestampUTCParameter : @"", // Today
            IRAPI_VolumeParameter : @""
        };
    }

    return parametersAliases_;
}

- (void)setRequiredParameters:(NSArray *)requiredParameters {
    if (requiredParameters_ != requiredParameters) {
        requiredParameters_ = requiredParameters;
    }

    self.parameters = [NSMutableDictionary new];

    for (NSString *parameterName in requiredParameters_) {
        self.parameters[parameterName] = self.defaultParameters[parameterName];
    }

    if (self.isViewLoaded) {
        [self.tableView reloadData];
    }
}

#pragma mark - Methods
#pragma mark Methods (Private)

- (void)getParameter {
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    if (selectedIndexPath != nil) {
        NSString *parameterName = self.requiredParameters[selectedIndexPath.row];
        id parameterValue = self.parameters[self.requiredParameters[selectedIndexPath.row]];

        if ([parameterName isEqualToString:IRAPI_PrimaryCurrencyCodeParameter]
            || [parameterName isEqualToString:IRAPI_SecondaryCurrencyCodeParameter]) {
            NSLog(@"Get Currency Param: %@ %@", parameterName, parameterValue);
            [self performSegueWithIdentifier:@"GetCurrencyCodeParameter" sender:self];

        } else if ([parameterName isEqualToString:IRAPI_NumberOfHoursInThePastToRetrieveParameter]
            || [parameterName isEqualToString:IRAPI_NumberOfRecentTradesToRetrieveParameter]) {
            NSLog(@"Get Numeric Param: %@ %@", parameterName, parameterValue);
            [self performSegueWithIdentifier:@"GetNumberParameter" sender:self];
        }
    }
}

#pragma mark Methods (Overloaded)

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"GetCurrencyCodeParameter"]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        if (selectedIndexPath != nil) {
            NSString *parameterName = self.requiredParameters[selectedIndexPath.row];
            id parameterValue = self.parameters[self.requiredParameters[selectedIndexPath.row]];
            IRGetCurrencyViewController *getCurrencyViewController = segue.destinationViewController;
            getCurrencyViewController.parameterName = parameterName;
            getCurrencyViewController.parameterDelegate = self;
        }

    } else if ([segue.identifier isEqualToString:@"GetNumberParameter"]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        if (selectedIndexPath != nil) {
            NSString *parameterName = self.requiredParameters[selectedIndexPath.row];
            id parameterValue = self.parameters[self.requiredParameters[selectedIndexPath.row]];
            IRGetNumberViewController *getNumberViewController = segue.destinationViewController;
            getNumberViewController.parameterName = parameterName;
            getNumberViewController.initialValue = parameterValue;
            getNumberViewController.parameterDelegate = self;
        }
    }

    if ([segue.identifier isEqualToString:@"RequestMethod"] && [segue.destinationViewController isKindOfClass:IRRequestMethodViewController.class]) {
        IRRequestMethodViewController *requestMethodViewController = segue.destinationViewController;
        requestMethodViewController.methodName = self.method;
        requestMethodViewController.methodParameters = [self.parameters copy];
    }
}

#pragma mark - Protocols
#pragma mark Protocols (UITableViewDataSource)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.requiredParameters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IRParameterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RightDetailCell"
                                                                     forIndexPath:indexPath];

    NSString *parameterName = self.requiredParameters[indexPath.row];
    NSString *parameterAlias = self.parametersAliases[self.requiredParameters[indexPath.row]];
    id parameterValue = self.parameters[self.requiredParameters[indexPath.row]];

    cell.parameterName = parameterName;
    cell.textLabel.text = parameterAlias;
    if ([parameterValue isKindOfClass:NSString.class]) {
        cell.detailTextLabel.text = parameterValue;
    } else if ([parameterName isEqualToString:IRAPI_NumberOfHoursInThePastToRetrieveParameter]
        || [parameterName isEqualToString:IRAPI_NumberOfRecentTradesToRetrieveParameter]) {
        cell.detailTextLabel.text = [(NSNumber *) parameterValue stringValue];
    }

    return cell;
}

#pragma mark Protocols (UITableViewDelegate)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self getParameter];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Protocols (UIScrollView)

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self resignFirstResponder];
}

#pragma mark Protocols (IRCellDelegate)

- (void)cellValueWithKey:(NSString *)key changed:(id)newValue {
    self.parameters[key] = newValue;
    [self.tableView reloadData];

    NSLog(@"PARAMETERS: %@", self.parameters);
}

@end
