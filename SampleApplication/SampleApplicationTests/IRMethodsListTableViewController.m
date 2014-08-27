//
//  IRMethodsListTableViewController.m
//  SampleApplication
//
//  Created by Maxim Pervushin on 20/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRMethodsListTableViewController.h"
#import "IRRequestMethodViewController.h"
#import "IRGetParametersViewController.h"
#import "IRConstants.h"

@interface IRMethodsListTableViewController ()

@property (nonatomic, strong) NSArray *types;

@end

@implementation IRMethodsListTableViewController

- (void)viewWillAppear:(BOOL)animated {
    self.types = @[@{
        @"type" : @"Public",
        @"methods" : @[
            @{@"name" : IRAPI_GetValidPrimaryCurrencyCodesMethod, @"parameters" : @[]},
            @{@"name" : IRAPI_GetValidSecondaryCurrencyCodesMethod, @"parameters" : @[]},
            @{@"name" : IRAPI_GetValidLimitOrderTypesMethod, @"parameters" : @[]},
            @{@"name" : IRAPI_GetValidMarketOrderTypesMethod, @"parameters" : @[]},
            @{@"name" : IRAPI_GetMarketSummaryMethod, @"parameters" : @[IRAPI_PrimaryCurrencyCodeParameter, IRAPI_SecondaryCurrencyCodeParameter]},
            @{@"name" : IRAPI_GetOrderBookMethod, @"parameters" : @[IRAPI_PrimaryCurrencyCodeParameter, IRAPI_SecondaryCurrencyCodeParameter]},
            @{@"name" : IRAPI_GetTradeHistorySummaryMethod, @"parameters" : @[IRAPI_PrimaryCurrencyCodeParameter, IRAPI_SecondaryCurrencyCodeParameter, IRAPI_NumberOfHoursInThePastToRetrieveParameter]},
            @{@"name" : IRAPI_GetRecentTradesMethod, @"parameters" : @[IRAPI_PrimaryCurrencyCodeParameter, IRAPI_SecondaryCurrencyCodeParameter,IRAPI_NumberOfRecentTradesToRetrieveParameter]}
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

    [super viewWillAppear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (self.tableView.indexPathsForSelectedRows.count > 0) {
        if ([segue.identifier isEqualToString:@"RequestMethod"] && [segue.destinationViewController isKindOfClass:IRRequestMethodViewController.class]) {
            IRRequestMethodViewController *requestMethodViewController = segue.destinationViewController;
            NSIndexPath *selectedIndexPath = [self.tableView.indexPathsForSelectedRows firstObject];
            NSArray *methods = self.types[selectedIndexPath.section][@"methods"];
            NSDictionary *method = methods[selectedIndexPath.row];
            requestMethodViewController.methodName = method[@"name"];
            requestMethodViewController.methodParameters = nil;

        } else if ([segue.identifier isEqualToString:@"GetParameters"] && [segue.destinationViewController isKindOfClass:IRGetParametersViewController.class]) {
            IRGetParametersViewController *getParametersViewController = segue.destinationViewController;
            NSIndexPath *selectedIndexPath = [self.tableView.indexPathsForSelectedRows firstObject];
            NSArray *methods = self.types[selectedIndexPath.section][@"methods"];
            NSDictionary *method = methods[selectedIndexPath.row];
            getParametersViewController.methodName = method[@"name"];
            getParametersViewController.requiredParameters = method[@"parameters"];
        }
    }
}

#pragma mark - Protocols
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.types.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *methods = self.types[section][@"methods"];
    return methods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MethodCell" forIndexPath:indexPath];
    NSArray *methods = self.types[indexPath.section][@"methods"];
    NSDictionary *method = methods[indexPath.row];
    cell.textLabel.text = method[@"name"];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.types[section][@"type"];
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSArray *methods = self.types[indexPath.section][@"methods"];
    NSDictionary *method = methods[indexPath.row];
    NSArray *methodParameters = method[@"parameters"];

    if (methodParameters.count == 0) {
        [self performSegueWithIdentifier:@"RequestMethod" sender:self];
    } else {
        [self performSegueWithIdentifier:@"GetParameters" sender:self];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
