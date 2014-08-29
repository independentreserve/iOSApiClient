//
//  IRMethodsListTableViewController.m
//  SampleApplication
//
//  Created by Maxim Pervushin on 20/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRMethodsListTableViewController.h"
#import "IRRequestMethodViewController.h"
#import "IRGetParametersTableViewController.h"
#import <APIClient/IRConstants.h>

@interface IRMethodsListTableViewController ()

@property (nonatomic, readonly) NSArray *methodsByType;

@end

@implementation IRMethodsListTableViewController
@synthesize methodsByType = methodsByType_;

#pragma mark - Methods
#pragma mark Methods (Private)

- (NSArray *)methodsByType {
    if (methodsByType_ == nil) {
        methodsByType_ = @[
            @{
                @"type" : @"Public",
                @"methods" : @[
                @{@"name" : IRAPI_GetValidPrimaryCurrencyCodesMethod, @"parameters" : @[]},
                @{@"name" : IRAPI_GetValidSecondaryCurrencyCodesMethod, @"parameters" : @[]},
                @{@"name" : IRAPI_GetValidLimitOrderTypesMethod, @"parameters" : @[]},
                @{@"name" : IRAPI_GetValidMarketOrderTypesMethod, @"parameters" : @[]},
                @{@"name" : IRAPI_GetMarketSummaryMethod, @"parameters" : @[IRAPI_PrimaryCurrencyCodeParameter, IRAPI_SecondaryCurrencyCodeParameter]},
                @{@"name" : IRAPI_GetOrderBookMethod, @"parameters" : @[IRAPI_PrimaryCurrencyCodeParameter, IRAPI_SecondaryCurrencyCodeParameter]},
                @{@"name" : IRAPI_GetTradeHistorySummaryMethod, @"parameters" : @[IRAPI_PrimaryCurrencyCodeParameter, IRAPI_SecondaryCurrencyCodeParameter, IRAPI_NumberOfHoursInThePastToRetrieveParameter]},
                @{@"name" : IRAPI_GetRecentTradesMethod, @"parameters" : @[IRAPI_PrimaryCurrencyCodeParameter, IRAPI_SecondaryCurrencyCodeParameter, IRAPI_NumberOfRecentTradesToRetrieveParameter]}
            ]
            }, @{
                @"type" : @"Private",
                @"methods" : @[
                    @{@"name" : IRAPI_PlaceLimitOrderMethod, @"parameters" : @[IRAPI_PrimaryCurrencyCodeParameter, IRAPI_SecondaryCurrencyCodeParameter, IRAPI_OrderTypeParameter, IRAPI_PriceParameter, IRAPI_VolumeParameter]},
                    @{@"name" : IRAPI_PlaceMarketOrderMethod, @"parameters" : @[IRAPI_PrimaryCurrencyCodeParameter, IRAPI_SecondaryCurrencyCodeParameter, IRAPI_OrderTypeParameter, IRAPI_VolumeParameter]},
                    @{@"name" : IRAPI_CancelOrderMethod, @"parameters" : @[IRAPI_OrderGUIDParameter]},
                    @{@"name" : IRAPI_GetOpenOrdersMethod, @"parameters" : @[IRAPI_PrimaryCurrencyCodeParameter, IRAPI_SecondaryCurrencyCodeParameter, IRAPI_PageIndexParameter, IRAPI_PageSizeParameter]},
                    @{@"name" : IRAPI_GetClosedOrdersMethod, @"parameters" : @[IRAPI_PrimaryCurrencyCodeParameter, IRAPI_SecondaryCurrencyCodeParameter, IRAPI_PageIndexParameter, IRAPI_PageSizeParameter]},
                    @{@"name" : IRAPI_GetAccountsMethod, @"parameters" : @[]},
                    @{@"name" : IRAPI_GetTransactionsMethod, @"parameters" : @[IRAPI_FromTimestampUTCParameter, IRAPI_ToTimestampUTCParameter, IRAPI_AccountGUIDParameter, IRAPI_PageIndexParameter, IRAPI_PageSizeParameter]},
                    @{@"name" : IRAPI_GetBitcoinDepositAddressMethod, @"parameters" : @[]}
                ]
            }];
    }

    return methodsByType_;
}

#pragma mark Methods (Overloaded)

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *selectedIndexPath = [self.tableView.indexPathsForSelectedRows firstObject];
    if (selectedIndexPath == nil) {
        // Nothing to do if no one row selected in table;
        return;
    }

    if ([segue.destinationViewController isKindOfClass:IRRequestMethodViewController.class]) {
        // Configure view controller for method request.
        IRRequestMethodViewController *requestMethodViewController = segue.destinationViewController;
        NSArray *methods = self.methodsByType[selectedIndexPath.section][@"methods"];
        NSDictionary *method = methods[selectedIndexPath.row];
        requestMethodViewController.methodName = method[@"name"];
        requestMethodViewController.methodParameters = nil;

    } else if ([segue.destinationViewController isKindOfClass:IRGetParametersTableViewController.class]) {
        // Configure view controller for changing parameters.
        IRGetParametersTableViewController *getParametersViewController = segue.destinationViewController;
        NSArray *methods = self.methodsByType[selectedIndexPath.section][@"methods"];
        NSDictionary *method = methods[selectedIndexPath.row];
        getParametersViewController.methodName = method[@"name"];
        getParametersViewController.requiredParameters = method[@"parameters"];
    }
}

#pragma mark - Protocols
#pragma mark Protocols (UITableViewDataSource)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.methodsByType.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *methods = self.methodsByType[section][@"methods"];
    return methods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MethodCell" forIndexPath:indexPath];
    NSArray *methods = self.methodsByType[indexPath.section][@"methods"];
    NSDictionary *method = methods[indexPath.row];
    cell.textLabel.text = method[@"name"];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.methodsByType[section][@"type"];
}

#pragma mark Protocols (UITableViewDelegate)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *methods = self.methodsByType[indexPath.section][@"methods"];
    NSDictionary *method = methods[indexPath.row];
    NSArray *methodParameters = method[@"parameters"];

    // Get parameter values if method requires parameters or request it immediately.
    if (methodParameters.count == 0) {
        [self performSegueWithIdentifier:@"RequestMethod" sender:self];
    } else {
        [self performSegueWithIdentifier:@"GetParameters" sender:self];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
