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
            @"GetValidPrimaryCurrencyCodes" : @"requestValidPrimaryCurrencyCodesResponseHandler:",
            @"GetValidSecondaryCurrencyCodes" : @"requestValidSecondaryCurrencyCodesResponseHandler:",
            @"GetValidLimitOrderTypes" : @"requestValidLimitOrderTypesResponseHandler:",
            @"GetValidMarketOrderTypes" : @"requestValidMarketOrderTypesResponseHandler:",
            @"GetMarketSummary" : @"requestMarketSummaryForPrimaryCurrencyCode:secondaryCurrencyCode:responseHandler:",
            @"GetOrderBook" : @"requestOrderBookForPrimaryCurrencyCode:secondaryCurrencyCode:responseHandler:",
            @"GetTradeHistorySummary" : @"requestTradeHistorySummaryForPrimaryCurrencyCode:secondaryCurrencyCode:numberOfHoursInThePastToRetrieve:responseHandler:",
            @"GetRecentTrades" : @"requestRecentTradesForPrimaryCurrencyCode:secondaryCurrencyCode:numberOfRecentTradesToRetrieve:responseHandler:",

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
    id responseBlock = ^(BOOL success, id response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong __typeof(&*weakSelf) strongSelf = weakSelf;
            strongSelf.responseLabel.text = [response description];
        });
    };

    SEL selector = NSSelectorFromString(self.methodToSelector[self.methodName]);
    NSMethodSignature *methodSignature = [[IRAPIManager manager] methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    invocation.selector = selector;
    invocation.target = [IRAPIManager manager];

    NSUInteger parameterIndex = 2; // User defined parameters starts from 2
    for (NSString *parameter in self.methodParameters.allValues) {
        NSString *parameterCopy = [parameter copy];
        [invocation setArgument:&parameterCopy atIndex:parameterIndex];
        parameterIndex++;
    }

    // All methods have response blocks as latest parameter
    [invocation setArgument:&responseBlock atIndex:parameterIndex];

    [invocation invoke];

    [super viewWillAppear:animated];
}

@end
