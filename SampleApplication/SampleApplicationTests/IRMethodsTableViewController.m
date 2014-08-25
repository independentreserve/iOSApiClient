//
//  IRMethodsTableViewController.m
//  SampleApplication
//
//  Created by Maxim Pervushin on 20/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRMethodsTableViewController.h"
#import "IRRequestMethodViewController.h"
#import "IRGetParametersViewController.h"

@interface IRMethodsTableViewController ()

@property (nonatomic, strong) NSArray *types;

@end

@implementation IRMethodsTableViewController

- (void)viewWillAppear:(BOOL)animated {
    self.types = @[@{
        @"type" : @"Public",
        @"methods" : @[
            @{@"name" : @"GetValidPrimaryCurrencyCodes", @"parameters" : @[]},
            @{@"name" : @"GetValidSecondaryCurrencyCodes", @"parameters" : @[]},
            @{@"name" : @"GetValidLimitOrderTypes", @"parameters" : @[]},
            @{@"name" : @"GetValidMarketOrderTypes", @"parameters" : @[]},
            @{@"name" : @"GetMarketSummary", @"parameters" : @[@"primaryCurrencyCode", @"secondaryCurrencyCode"]},
            @{@"name" : @"GetOrderBook", @"parameters" : @[@"primaryCurrencyCode", @"secondaryCurrencyCode"]},
            @{@"name" : @"GetTradeHistorySummary", @"parameters" : @[@"primaryCurrencyCode", @"secondaryCurrencyCode", @"numberOfHoursInThePastToRetrieve"]},
            @{@"name" : @"GetRecentTrades", @"parameters" : @[@"primaryCurrencyCode", @"secondaryCurrencyCode", @"numberOfRecentTradesToRetrieve"]}
        ]
    }, @{
        @"type" : @"Private",
        @"methods" : @[
            @{@"name" : @"PlaceLimitOrder", @"parameters" : @[@"primaryCurrencyCode", @"secondaryCurrencyCode", @"orderType", @"price", @"volume"]},
            @{@"name" : @"PlaceMarketOrder", @"parameters" : @[@"primaryCurrencyCode", @"secondaryCurrencyCode", @"orderType", @"price", @"volume"]},
            @{@"name" : @"CancelOrder", @"parameters" : @[]},
            @{@"name" : @"GetOpenOrders", @"parameters" : @[@"primaryCurrencyCode", @"secondaryCurrencyCode", @"pageIndex", @"pageSize"]},
            @{@"name" : @"GetClosedOrders", @"parameters" : @[@"primaryCurrencyCode", @"secondaryCurrencyCode", @"pageIndex", @"pageSize"]},
            @{@"name" : @"GetAccounts", @"parameters" : @[]},
            @{@"name" : @"GetTransactions", @"parameters" : @[]},
            @{@"name" : @"GetBitcoinDepositAddress", @"parameters" : @[]}
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
            getParametersViewController.method = method[@"name"];
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
