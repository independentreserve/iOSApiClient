//
//  IRRequestMethodViewController.m
//  SampleApplication
//
//  Created by Maxim Pervushin on 20/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRRequestMethodViewController.h"
#import "IRAPIManager.h"

@interface IRRequestMethodViewController ()

@property (nonatomic, weak) IBOutlet UILabel *methodParametersLabel;
@property (nonatomic, weak) IBOutlet UILabel *responseLabel;
@property (nonatomic, readonly) NSDictionary *methodToSelector;

@end

@implementation IRRequestMethodViewController
@synthesize methodToSelector = methodToSelector_;

- (NSDictionary *)methodToSelector {
    if (methodToSelector_ == nil) {
        methodToSelector_ = @{
            @"GetValidPrimaryCurrencyCodes" : @"getValidPrimaryCurrencyCodesResponseHandler:",
            @"GetValidSecondaryCurrencyCodes" : @"getValidSecondaryCurrencyCodesResponseHandler:",
            @"GetValidLimitOrderTypes" : @"getValidLimitOrderTypesResponseHandler:",
            @"GetValidMarketOrderTypes" : @"getValidMarketOrderTypesResponseHandler:",
            @"GetMarketSummary" : @"getMarketSummaryForPrimaryCurrencyCode:secondaryCurrencyCode:responseHandler:",
            @"GetOrderBook" : @"getOrderBookForPrimaryCurrencyCode:secondaryCurrencyCode:responseHandler:",
            @"GetTradeHistorySummary" : @"getTradeHistorySummaryForPrimaryCurrencyCode:secondaryCurrencyCode:numberOfHoursInThePastToRetrieve:responseHandler:",
            @"GetRecentTrades" : @"getRecentTradesForPrimaryCurrencyCode:secondaryCurrencyCode:numberOfRecentTradesToRetrieve:responseHandler:",

            @"PlaceLimitOrder" : @"",
            @"PlaceMarketOrder" : @"",
            @"CancelOrder" : @"",
            @"GetOpenOrders" : @"",
            @"GetClosedOrders" : @"",
            @"GetTransactions" : @"",
            @"GetBitcoinDepositAddress" : @""
        };
    }
    return methodToSelector_;
}

- (void)viewWillAppear:(BOOL)animated {

    self.title = self.methodName;
    self.methodParametersLabel.text = self.methodParameters != nil ? self.methodParameters.description : @"No Parameters";

    __weak __typeof(&*self) weakSelf = self;
    id responseHandler = ^(BOOL success, id response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong __typeof(&*weakSelf) strongSelf = weakSelf;
            strongSelf.responseLabel.text = [response description];
        });
    };

    // TODO: Yes, I know about NSInvocation and performSelector:, but parameters order...

    if ([self.methodName isEqualToString:@"GetValidPrimaryCurrencyCodes"]) {
        [[IRAPIManager manager] getValidPrimaryCurrencyCodesResponseHandler:responseHandler];
    } else if ([self.methodName isEqualToString:@"GetValidSecondaryCurrencyCodes"]) {
        [[IRAPIManager manager] getValidSecondaryCurrencyCodesResponseHandler:responseHandler];
    } else if ([self.methodName isEqualToString:@"GetValidLimitOrderTypes"]) {
        [[IRAPIManager manager] getValidLimitOrderTypesResponseHandler:responseHandler];
    } else if ([self.methodName isEqualToString:@"GetValidMarketOrderTypes"]) {
        [[IRAPIManager manager] getValidMarketOrderTypesResponseHandler:responseHandler];
    } else if ([self.methodName isEqualToString:@"GetMarketSummary"]) {
        [[IRAPIManager manager] getMarketSummaryForPrimaryCurrencyCode:self.methodParameters[@"primaryCurrencyCode"]
                                                 secondaryCurrencyCode:self.methodParameters[@"secondaryCurrencyCode"]
                                                       responseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:@"GetOrderBook"]) {
        [[IRAPIManager manager] getOrderBookForPrimaryCurrencyCode:self.methodParameters[@"primaryCurrencyCode"]
                                             secondaryCurrencyCode:self.methodParameters[@"secondaryCurrencyCode"]
                                                   responseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:@"GetTradeHistorySummary"]) {
        [[IRAPIManager manager] getTradeHistorySummaryForPrimaryCurrencyCode:self.methodParameters[@"primaryCurrencyCode"]
                                                       secondaryCurrencyCode:self.methodParameters[@"secondaryCurrencyCode"]
                                            numberOfHoursInThePastToRetrieve:self.methodParameters[@"numberOfHoursInThePastToRetrieve"]
                                                             responseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:@"GetRecentTrades"]) {
        [[IRAPIManager manager] getRecentTradesForPrimaryCurrencyCode:self.methodParameters[@"primaryCurrencyCode"]
                                                secondaryCurrencyCode:self.methodParameters[@"secondaryCurrencyCode"]
                                       numberOfRecentTradesToRetrieve:self.methodParameters[@"numberOfRecentTradesToRetrieve"]
                                                      responseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:@"PlaceLimitOrder"]) {
        [[IRAPIManager manager] placeLimitOrderWithPrimaryCurrencyCode:self.methodParameters[@"primaryCurrencyCode"]
                                                 secondaryCurrencyCode:self.methodParameters[@"secondaryCurrencyCode"]
                                                             orderType:@"LimitOffer"
                                                                 price:@(510)
                                                                volume:@(0.01)
                                                       responseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:@"PlaceMarketOrder"]) {
        [[IRAPIManager manager] placeMarketOrderWithPrimaryCurrencyCode:self.methodParameters[@"primaryCurrencyCode"]
                                                 secondaryCurrencyCode:self.methodParameters[@"secondaryCurrencyCode"]
                                                             orderType:@"MarketOffer"
                                                                 price:@(510)
                                                                volume:@(0.01)
                                                       responseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:@"CancelOrder"]) {
        [[IRAPIManager manager] cancelOrderWithGUID:@"6F9619FF-8B86-D011-B42D-00CF4FC964FF"
                                    responseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:@"GetOpenOrders"]) {
        [[IRAPIManager manager] getOpenOrdersWithPrimaryCurrencyCode:self.methodParameters[@"primaryCurrencyCode"]
                                               secondaryCurrencyCode:self.methodParameters[@"secondaryCurrencyCode"]
                                                           pageIndex:@(1)
                                                            pageSize:@(10)
                                                     responseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:@"GetClosedOrders"]) {
        [[IRAPIManager manager] getClosedOrdersWithPrimaryCurrencyCode:self.methodParameters[@"primaryCurrencyCode"]
                                                 secondaryCurrencyCode:self.methodParameters[@"secondaryCurrencyCode"]
                                                             pageIndex:@(1)
                                                              pageSize:@(10)
                                                       responseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:@"GetAccounts"]) {
        [[IRAPIManager manager] getAccountsWithResponseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:@"GetTransactions"]) {
        [[IRAPIManager manager] getTransactionsWithAccountGUID:@"28f56c69-84ab-432d-9b33-19dfb5511172"
                                                      fromDate:[NSDate dateWithTimeIntervalSinceNow:-60000]
                                                        toDate:[NSDate dateWithTimeIntervalSinceNow:0]
                                                     pageIndex:@(1)
                                                      pageSize:@(10)
                                               responseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:@"GetBitcoinDepositAddress"]) {
        [[IRAPIManager manager] getBitcoinDepositAddressWithResponseHandler:responseHandler];
    }

    [super viewWillAppear:animated];
}

@end
