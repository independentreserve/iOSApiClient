//
//  IRAPIManager.m
//  SampleApplication
//
//  Created by Maxim Pervushin on 19/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRAPIManager.h"
#import "IRNetworkManager.h"

#define IRAPIManager_GetValidPrimaryCurrencyCodesMethod @"GetValidPrimaryCurrencyCodes"
#define IRAPIManager_GetValidSecondaryCurrencyCodesMethod @"GetValidSecondaryCurrencyCodes"
#define IRAPIManager_GetValidLimitOrderTypesMethod @"GetValidLimitOrderTypes"
#define IRAPIManager_GetValidMarketOrderTypesMethod @"GetValidMarketOrderTypes"
#define IRAPIManager_GetMarketSummaryMethod @"GetMarketSummary"
#define IRAPIManager_GetOrderBookMethod @"GetOrderBook"
#define IRAPIManager_GetTradeHistorySummaryMethod @"GetTradeHistorySummary"
#define IRAPIManager_GetRecentTradesMethod @"GetRecentTrades"

#define IRAPIManager_PrimaryCurrencyCodeParameter @"primaryCurrencyCode"
#define IRAPIManager_SecondaryCurrencyCodeParameter @"secondaryCurrencyCode"
#define IRAPIManager_NumberOfHoursInThePastToRetrieve @"numberOfHoursInThePastToRetrieve"
#define IRAPIManager_NumberOfRecentTradesToRetrieve @"numberOfRecentTradesToRetrieve"

@implementation IRAPIManager

+ (instancetype)manager {
    static IRAPIManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [IRAPIManager new];
    });
    return manager;
}

- (void)requestValidPrimaryCurrencyCodesResponseHandler:(IRAPIManagerResponseHandler)responseHandler {
    [[IRNetworkManager manager] GET:IRAPIManager_GetValidPrimaryCurrencyCodesMethod parameters:nil
                            handler:responseHandler];
}

- (void)requestValidSecondaryCurrencyCodesResponseHandler:(IRAPIManagerResponseHandler)responseHandler {
    [[IRNetworkManager manager] GET:IRAPIManager_GetValidSecondaryCurrencyCodesMethod parameters:nil
                            handler:responseHandler];
}

- (void)requestValidLimitOrderTypesResponseHandler:(IRAPIManagerResponseHandler)responseHandler {
    [[IRNetworkManager manager] GET:IRAPIManager_GetValidLimitOrderTypesMethod parameters:nil handler:responseHandler];
}

- (void)requestValidMarketOrderTypesResponseHandler:(IRAPIManagerResponseHandler)responseHandler {
    [[IRNetworkManager manager] GET:IRAPIManager_GetValidMarketOrderTypesMethod parameters:nil handler:responseHandler];
}

- (void)requestMarketSummaryForPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                             secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                                   responseHandler:(IRAPIManagerResponseHandler)responseHandler {
    NSDictionary *parameters = @{
        IRAPIManager_PrimaryCurrencyCodeParameter : primaryCurrencyCode,
        IRAPIManager_SecondaryCurrencyCodeParameter : secondaryCurrencyCode
    };
    [[IRNetworkManager manager] GET:IRAPIManager_GetMarketSummaryMethod
                         parameters:parameters
                            handler:responseHandler];
}

- (void)requestOrderBookForPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                         secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                               responseHandler:(IRAPIManagerResponseHandler)responseHandler {
    NSDictionary *parameters = @{
        IRAPIManager_PrimaryCurrencyCodeParameter : primaryCurrencyCode,
        IRAPIManager_SecondaryCurrencyCodeParameter : secondaryCurrencyCode
    };
    [[IRNetworkManager manager] GET:IRAPIManager_GetOrderBookMethod
                         parameters:parameters
                            handler:responseHandler];
}

- (void)requestTradeHistorySummaryForPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                                   secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                        numberOfHoursInThePastToRetrieve:(NSNumber *)numberOfHoursInThePastToRetrieve
                                         responseHandler:(IRAPIManagerResponseHandler)responseHandler {
    NSDictionary *parameters = @{
        IRAPIManager_PrimaryCurrencyCodeParameter : primaryCurrencyCode,
        IRAPIManager_SecondaryCurrencyCodeParameter : secondaryCurrencyCode,
        IRAPIManager_NumberOfHoursInThePastToRetrieve : numberOfHoursInThePastToRetrieve
    };
    [[IRNetworkManager manager] GET:IRAPIManager_GetTradeHistorySummaryMethod
                         parameters:parameters
                            handler:responseHandler];
}

- (void)requestRecentTradesForPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                            secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                   numberOfRecentTradesToRetrieve:(NSNumber *)numberOfRecentTradesToRetrieve
                                  responseHandler:(IRAPIManagerResponseHandler)responseHandler {
    NSDictionary *parameters = @{
        IRAPIManager_PrimaryCurrencyCodeParameter : primaryCurrencyCode,
        IRAPIManager_SecondaryCurrencyCodeParameter : secondaryCurrencyCode,
        IRAPIManager_NumberOfRecentTradesToRetrieve : numberOfRecentTradesToRetrieve
    };
    [[IRNetworkManager manager] GET:IRAPIManager_GetRecentTradesMethod
                         parameters:parameters
                            handler:responseHandler];
}


@end
