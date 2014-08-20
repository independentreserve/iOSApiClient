//
//  IRAPIManager.h
//  SampleApplication
//
//  Created by Maxim Pervushin on 19/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^IRAPIManagerResponseHandler)(BOOL success, id content);

@interface IRAPIManager : NSObject

+ (instancetype)manager;

- (void)requestValidPrimaryCurrencyCodesResponseHandler:(IRAPIManagerResponseHandler)responseHandler;

- (void)requestValidSecondaryCurrencyCodesResponseHandler:(IRAPIManagerResponseHandler)responseHandler;

- (void)requestValidLimitOrderTypesResponseHandler:(IRAPIManagerResponseHandler)responseHandler;

- (void)requestValidMarketOrderTypesResponseHandler:(IRAPIManagerResponseHandler)responseHandler;

- (void)requestMarketSummaryForPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                             secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                                   responseHandler:(IRAPIManagerResponseHandler)responseHandler;

- (void)requestOrderBookForPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                         secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                               responseHandler:(IRAPIManagerResponseHandler)responseHandler;

- (void)requestTradeHistorySummaryForPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                                   secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                        numberOfHoursInThePastToRetrieve:(NSNumber *)numberOfHoursInThePastToRetrieve
                                         responseHandler:(IRAPIManagerResponseHandler)responseHandler;

- (void)requestRecentTradesForPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                            secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                   numberOfRecentTradesToRetrieve:(NSNumber *)numberOfRecentTradesToRetrieve
                                  responseHandler:(IRAPIManagerResponseHandler)responseHandler;

@end
