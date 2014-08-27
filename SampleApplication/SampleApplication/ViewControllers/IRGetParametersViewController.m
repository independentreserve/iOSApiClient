//
//  IRGetParametersViewController.m
//  SampleApplication
//
//  Created by Maxim Pervushin on 20/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRGetParametersViewController.h"
#import "IRConstants.h"
#import "IRParameterChangeDelegate.h"
#import "IRParameterTableViewCell.h"
#import "IRGetOptionViewController.h"
#import "IRRequestMethodViewController.h"

@interface IRGetParametersViewController () <IRParameterChangeDelegate>

@property (nonatomic, strong, readonly) NSDictionary *defaultParameters;
@property (nonatomic, strong, readonly) NSDictionary *parametersAliases;
@property (nonatomic, strong, readonly) NSDictionary *segueByParameter;

- (void)getParameter;

@end

@implementation IRGetParametersViewController
@synthesize defaultParameters = defaultParameters_;
@synthesize parametersAliases = parametersAliases_;
@synthesize requiredParameters = requiredParameters_;
@synthesize segueByParameter = segueByParameter_;

- (NSDictionary *)defaultParameters {
    if (defaultParameters_ == nil) {
        defaultParameters_ = @{
            IRAPI_AccountGUIDParameter : @"11111111-1111-1111-1111-111111111111",
            IRAPI_FromTimestampUTCParameter : [NSDate dateWithTimeIntervalSinceNow:-60 * 60 * 24 * 7], // Today minus one week
            IRAPI_NumberOfHoursInThePastToRetrieveParameter : @(24),
            IRAPI_NumberOfRecentTradesToRetrieveParameter : @(10),
            IRAPI_OrderGUIDParameter : @"11111111-1111-1111-1111-111111111111",
            IRAPI_OrderTypeParameter : @"",
            IRAPI_PageIndexParameter : @(1),
            IRAPI_PageSizeParameter : @(10),
            IRAPI_PriceParameter : @(500),
            IRAPI_PrimaryCurrencyCodeParameter : @"Xbt",
            IRAPI_SecondaryCurrencyCodeParameter : @"Usd",
            IRAPI_ToTimestampUTCParameter : [NSDate dateWithTimeIntervalSinceNow:0], // Today
            IRAPI_VolumeParameter : @(0.01)
        };
    }

    return defaultParameters_;
}

- (NSDictionary *)parametersAliases {
    if (parametersAliases_ == nil) {
        parametersAliases_ = @{
            IRAPI_AccountGUIDParameter : @"Account Guid:",
            IRAPI_FromTimestampUTCParameter : @"From Date:",
            IRAPI_NumberOfHoursInThePastToRetrieveParameter : @"Number Of Hours:",
            IRAPI_NumberOfRecentTradesToRetrieveParameter : @"Number Of Trades:",
            IRAPI_OrderGUIDParameter : @"Order GUID",
            IRAPI_OrderTypeParameter : @"Order Type",
            IRAPI_PageIndexParameter : @"Page Index",
            IRAPI_PageSizeParameter : @"Page Size",
            IRAPI_PriceParameter : @"Price",
            IRAPI_PrimaryCurrencyCodeParameter : @"Primary Currency:",
            IRAPI_SecondaryCurrencyCodeParameter : @"Secondary Currency:",
            IRAPI_ToTimestampUTCParameter : @"To Date:",
            IRAPI_VolumeParameter : @"Volume"
        };
    }

    return parametersAliases_;
}

- (NSDictionary *)segueByParameter {
    if (segueByParameter_ == nil) {
        segueByParameter_ = @{
            IRAPI_AccountGUIDParameter : @"GetString",
            IRAPI_FromTimestampUTCParameter : @"GetDate",
            IRAPI_NumberOfHoursInThePastToRetrieveParameter : @"GetNumber",
            IRAPI_NumberOfRecentTradesToRetrieveParameter : @"GetNumber",
            IRAPI_OrderGUIDParameter : @"GetString",
            IRAPI_OrderTypeParameter : @"GetOption",
            IRAPI_PageIndexParameter : @"GetNumber",
            IRAPI_PageSizeParameter : @"GetNumber",
            IRAPI_PriceParameter : @"GetNumber",
            IRAPI_PrimaryCurrencyCodeParameter : @"GetOption",
            IRAPI_SecondaryCurrencyCodeParameter : @"GetOption",
            IRAPI_ToTimestampUTCParameter : @"GetDate",
            IRAPI_VolumeParameter : @"GetNumber"
        };
    }

    return segueByParameter_;
}

- (void)setRequiredParameters:(NSArray *)requiredParameters {
    if (requiredParameters_ != requiredParameters) {
        requiredParameters_ = requiredParameters;
    }

    self.parameters = [NSMutableDictionary new];

    // Fill parameters array with default values.
    for (NSString *parameterName in requiredParameters_) {
        self.parameters[parameterName] = self.defaultParameters[parameterName];

        // PlaceMarketOrder and PlaceLimitOrder uses different order types.
        if ([parameterName isEqualToString:IRAPI_OrderTypeParameter]) {
            if ([self.methodName isEqualToString:IRAPI_PlaceMarketOrderMethod]) {
                // Set MarketBid for PlaceMarketOrder as default.
                self.parameters[parameterName] = @"MarketBid";

            } else if ([self.methodName isEqualToString:IRAPI_PlaceLimitOrderMethod]) {
                // Set LimitBid for PlaceLimitOrder as default.
                self.parameters[parameterName] = @"LimitBid";
            }
        }
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
        [self performSegueWithIdentifier:self.segueByParameter[parameterName] sender:self];
    }
}

#pragma mark Methods (Overloaded)

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.destinationViewController isKindOfClass:IRRequestMethodViewController.class]) {
        IRRequestMethodViewController *requestMethodViewController = segue.destinationViewController;
        requestMethodViewController.methodName = self.methodName;
        requestMethodViewController.methodParameters = [self.parameters copy];

    } else if ([segue.destinationViewController isKindOfClass:IRGetValueViewController.class]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        if (selectedIndexPath == nil) {
            return;
        }
        NSString *parameterName = self.requiredParameters[selectedIndexPath.row];
        id parameterValue = self.parameters[self.requiredParameters[selectedIndexPath.row]];

        IRGetValueViewController *getValueViewController = segue.destinationViewController;
        getValueViewController.parameterDelegate = self;
        getValueViewController.parameterName = parameterName;
        getValueViewController.initialParameterValue = parameterValue;

        // Additional initialization for IRGetOptionViewController objects
        if ([segue.destinationViewController isKindOfClass:IRGetOptionViewController.class]) {
            IRGetOptionViewController *getOptionViewController = segue.destinationViewController;

            if ([parameterName isEqualToString:IRAPI_PrimaryCurrencyCodeParameter]) {
                getOptionViewController.options = @[@"Xbt", @"Usd"];

            } else if ([parameterName isEqualToString:IRAPI_SecondaryCurrencyCodeParameter]) {
                getOptionViewController.options = @[@"Usd", @"Xbt"];

            } else if ([parameterName isEqualToString:IRAPI_OrderTypeParameter]) {
                if ([self.methodName isEqualToString:IRAPI_PlaceMarketOrderMethod]) {
                    getOptionViewController.options = @[@"MarketBid", @"MarketOffer"];

                } else if ([self.methodName isEqualToString:IRAPI_PlaceLimitOrderMethod]) {
                    getOptionViewController.options = @[@"LimitBid", @"LimitOffer"];
                }
            }
        }
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

    NSString *cellId = @"RightDetailCell";
    NSString *parameterName = self.requiredParameters[indexPath.row];
    if ([parameterName isEqualToString:IRAPI_FromTimestampUTCParameter]
        || [parameterName isEqualToString:IRAPI_ToTimestampUTCParameter]) {
        cellId = @"SubtitleCell";
    }

    IRParameterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];

    NSString *parameterAlias = self.parametersAliases[self.requiredParameters[indexPath.row]];
    id parameterValue = self.parameters[self.requiredParameters[indexPath.row]];

    cell.parameterName = parameterName;
    cell.textLabel.text = parameterAlias;

    if ([parameterValue isKindOfClass:NSString.class]) {
        cell.detailTextLabel.text = parameterValue;

    } else if ([parameterValue isKindOfClass:NSNumber.class]) {
        cell.detailTextLabel.text = [(NSNumber *) parameterValue stringValue];

    } else if ([parameterValue isKindOfClass:NSDate.class]) {
        cell.detailTextLabel.text = [(NSDate *) parameterValue description];
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

- (void)parameter:(NSString *)key valueChanged:(id)newValue {
    self.parameters[key] = newValue;
    [self.tableView reloadData];
}

@end
