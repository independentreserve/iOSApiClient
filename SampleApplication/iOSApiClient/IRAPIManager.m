//
//  IRAPIManager.m
//  SampleApplication
//
//  Created by Maxim Pervushin on 19/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRAPIManager.h"
#import "IRNetworkManager.h"
#import "NSString+IRSignature.h"
#import "IRConstants.h"

@interface IRAPIManager ()

+ (NSString *)getNonce;

+ (NSString *)getAPIKey;

+ (NSString *)getAPISecret;

+ (NSString *)getSignatureWithNonce:(NSString *)nonce;

@end

@implementation IRAPIManager

+ (instancetype)manager {

    id apiKey = [IRAPIManager getAPIKey];
    if (apiKey == nil || [apiKey isEqualToString:@""]) {
        NSLog(@"WARNING: Independent Reserve API Key is invalid. Unable to initialize IRAPIManager.");
        return nil;
    }

    id apiSecret = [IRAPIManager getAPISecret];
    if (apiSecret == nil || [apiSecret isEqualToString:@""]) {
        NSLog(@"WARNING: Independent Reserve API Secret is invalid. Unable to initialize IRAPIManager.");
        return nil;
    }

    static IRAPIManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [IRAPIManager new];
    });

    return manager;
}

#pragma mark - Public API Methods

- (void)getValidPrimaryCurrencyCodesResponseHandler:(IRAPIManagerResponseHandler)responseHandler {
    [[IRNetworkManager manager] GET:IRAPI_GetValidPrimaryCurrencyCodesMethod parameters:nil handler:responseHandler];
}

- (void)getValidSecondaryCurrencyCodesResponseHandler:(IRAPIManagerResponseHandler)responseHandler {
    [[IRNetworkManager manager] GET:IRAPI_GetValidSecondaryCurrencyCodesMethod parameters:nil handler:responseHandler];
}

- (void)getValidLimitOrderTypesResponseHandler:(IRAPIManagerResponseHandler)responseHandler {
    [[IRNetworkManager manager] GET:IRAPI_GetValidLimitOrderTypesMethod parameters:nil handler:responseHandler];
}

- (void)getValidMarketOrderTypesResponseHandler:(IRAPIManagerResponseHandler)responseHandler {
    [[IRNetworkManager manager] GET:IRAPI_GetValidMarketOrderTypesMethod parameters:nil handler:responseHandler];
}

- (void)getMarketSummaryForPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                         secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                               responseHandler:(IRAPIManagerResponseHandler)responseHandler {

    NSDictionary *parameters = @{
        IRAPI_PrimaryCurrencyCodeParameter : primaryCurrencyCode,
        IRAPI_SecondaryCurrencyCodeParameter : secondaryCurrencyCode
    };

    [[IRNetworkManager manager] GET:IRAPI_GetMarketSummaryMethod parameters:parameters handler:responseHandler];
}

- (void)getOrderBookForPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                     secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                           responseHandler:(IRAPIManagerResponseHandler)responseHandler {

    NSDictionary *parameters = @{
        IRAPI_PrimaryCurrencyCodeParameter : primaryCurrencyCode,
        IRAPI_SecondaryCurrencyCodeParameter : secondaryCurrencyCode
    };

    [[IRNetworkManager manager] GET:IRAPI_GetOrderBookMethod parameters:parameters handler:responseHandler];
}

- (void)getTradeHistorySummaryForPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                               secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                    numberOfHoursInThePastToRetrieve:(NSNumber *)numberOfHoursInThePastToRetrieve
                                     responseHandler:(IRAPIManagerResponseHandler)responseHandler {

    NSDictionary *parameters = @{
        IRAPI_PrimaryCurrencyCodeParameter : primaryCurrencyCode,
        IRAPI_SecondaryCurrencyCodeParameter : secondaryCurrencyCode,
        IRAPI_NumberOfHoursInThePastToRetrieveParameter : numberOfHoursInThePastToRetrieve
    };

    [[IRNetworkManager manager] GET:IRAPI_GetTradeHistorySummaryMethod parameters:parameters handler:responseHandler];
}

- (void)getRecentTradesForPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                        secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
               numberOfRecentTradesToRetrieve:(NSNumber *)numberOfRecentTradesToRetrieve
                              responseHandler:(IRAPIManagerResponseHandler)responseHandler {

    NSDictionary *parameters = @{
        IRAPI_PrimaryCurrencyCodeParameter : primaryCurrencyCode,
        IRAPI_SecondaryCurrencyCodeParameter : secondaryCurrencyCode,
        IRAPI_NumberOfRecentTradesToRetrieveParameter : numberOfRecentTradesToRetrieve
    };

    [[IRNetworkManager manager] GET:IRAPI_GetRecentTradesMethod parameters:parameters handler:responseHandler];
}

#pragma mark - Private API Methods

- (void)placeLimitOrderWithPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                         secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                                     orderType:(NSString *)orderType
                                         price:(NSNumber *)price
                                        volume:(NSNumber *)volume
                               responseHandler:(IRAPIManagerResponseHandler)responseHandler {

    NSString *nonce = [IRAPIManager getNonce];

    NSDictionary *parameters = @{
        IRAPI_APIKeyParameter : [IRAPIManager getAPIKey],
        IRAPI_NonceParameter : nonce,
        IRAPI_SignatureParameter : [IRAPIManager getSignatureWithNonce:nonce],
        IRAPI_PrimaryCurrencyCodeParameter : primaryCurrencyCode,
        IRAPI_SecondaryCurrencyCodeParameter : secondaryCurrencyCode,
        IRAPI_OrderTypeParameter : orderType,
        IRAPI_PriceParameter : price,
        IRAPI_VolumeParameter : volume
    };

    [[IRNetworkManager manager] POST:IRAPI_PlaceLimitOrderMethod parameters:parameters handler:responseHandler];
}

- (void)placeMarketOrderWithPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                          secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                                      orderType:(NSString *)orderType
                                          price:(NSNumber *)price
                                         volume:(NSNumber *)volume
                                responseHandler:(IRAPIManagerResponseHandler)responseHandler {

    NSString *nonce = [IRAPIManager getNonce];

    NSDictionary *parameters = @{
        IRAPI_APIKeyParameter : [IRAPIManager getAPIKey],
        IRAPI_NonceParameter : nonce,
        IRAPI_SignatureParameter : [IRAPIManager getSignatureWithNonce:nonce],
        IRAPI_PrimaryCurrencyCodeParameter : primaryCurrencyCode,
        IRAPI_SecondaryCurrencyCodeParameter : secondaryCurrencyCode,
        IRAPI_OrderTypeParameter : orderType,
        IRAPI_PriceParameter : price,
        IRAPI_VolumeParameter : volume
    };

    [[IRNetworkManager manager] POST:IRAPI_PlaceMarketOrderMethod parameters:parameters handler:responseHandler];
}

- (void)cancelOrderWithGUID:(NSString *)orderGUID responseHandler:(IRAPIManagerResponseHandler)responseHandler {
    NSString *nonce = [IRAPIManager getNonce];

    NSDictionary *parameters = @{
        IRAPI_APIKeyParameter : [IRAPIManager getAPIKey],
        IRAPI_NonceParameter : nonce,
        IRAPI_SignatureParameter : [IRAPIManager getSignatureWithNonce:nonce],
        IRAPI_OrderGUIDParameter : orderGUID
    };

    [[IRNetworkManager manager] POST:IRAPI_CancelOrderMethod parameters:parameters handler:responseHandler];
}

- (void)getOpenOrdersWithPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                       secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                                   pageIndex:(NSNumber *)pageIndex
                                    pageSize:(NSNumber *)pageSize
                             responseHandler:(IRAPIManagerResponseHandler)responseHandler {

    NSString *nonce = [IRAPIManager getNonce];

    NSDictionary *parameters = @{
        IRAPI_APIKeyParameter : [IRAPIManager getAPIKey],
        IRAPI_NonceParameter : nonce,
        IRAPI_SignatureParameter : [IRAPIManager getSignatureWithNonce:nonce],
        IRAPI_PrimaryCurrencyCodeParameter : primaryCurrencyCode,
        IRAPI_SecondaryCurrencyCodeParameter : secondaryCurrencyCode,
        IRAPI_PageIndexParameter : pageIndex,
        IRAPI_PageSizeParameter : pageSize
    };

    [[IRNetworkManager manager] POST:IRAPI_GetOpenOrdersMethod parameters:parameters handler:responseHandler];
}

- (void)getClosedOrdersWithPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                         secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                                     pageIndex:(NSNumber *)pageIndex
                                      pageSize:(NSNumber *)pageSize
                               responseHandler:(IRAPIManagerResponseHandler)responseHandler {

    NSString *nonce = [IRAPIManager getNonce];

    NSDictionary *parameters = @{
        IRAPI_APIKeyParameter : [IRAPIManager getAPIKey],
        IRAPI_NonceParameter : nonce,
        IRAPI_SignatureParameter : [IRAPIManager getSignatureWithNonce:nonce],
        IRAPI_PrimaryCurrencyCodeParameter : primaryCurrencyCode,
        IRAPI_SecondaryCurrencyCodeParameter : secondaryCurrencyCode,
        IRAPI_PageIndexParameter : pageIndex,
        IRAPI_PageSizeParameter : pageSize
    };

    [[IRNetworkManager manager] POST:IRAPI_GetClosedOrdersMethod parameters:parameters handler:responseHandler];
}

- (void)getAccountsWithResponseHandler:(IRAPIManagerResponseHandler)responseHandler {
    NSString *nonce = [IRAPIManager getNonce];

    NSDictionary *parameters = @{
        IRAPI_APIKeyParameter : [IRAPIManager getAPIKey],
        IRAPI_NonceParameter : nonce,
        IRAPI_SignatureParameter : [IRAPIManager getSignatureWithNonce:nonce],
    };

    [[IRNetworkManager manager]
        POST:IRAPI_GetAccountsMethod parameters:parameters handler:responseHandler];
}

- (void)getTransactionsWithAccountGUID:(NSString *)accountGUID
                              fromDate:(NSDate *)fromDate
                                toDate:(NSDate *)toDate
                             pageIndex:(NSNumber *)pageIndex
                              pageSize:(NSNumber *)pageSize
                       responseHandler:(IRAPIManagerResponseHandler)responseHandler {

    NSString *nonce = [IRAPIManager getNonce];

    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];

    NSString *fromDateString = [formatter stringFromDate:fromDate];
    NSString *toDateString = [formatter stringFromDate:toDate];

    NSDictionary *parameters = @{
        IRAPI_APIKeyParameter : [IRAPIManager getAPIKey],
        IRAPI_NonceParameter : nonce,
        IRAPI_SignatureParameter : [IRAPIManager getSignatureWithNonce:nonce],
        IRAPI_AccountGUIDParameter : accountGUID,
        IRAPI_FromTimestampUTCParameter : fromDateString,
        IRAPI_ToTimestampUTCParameter : toDateString,
        IRAPI_PageIndexParameter : pageIndex,
        IRAPI_PageSizeParameter : pageSize
    };

    [[IRNetworkManager manager] POST:IRAPI_GetTransactionsMethod parameters:parameters handler:responseHandler];
}

- (void)getBitcoinDepositAddressWithResponseHandler:(IRAPIManagerResponseHandler)responseHandler {

    NSString *nonce = [IRAPIManager getNonce];

    NSDictionary *parameters = @{
        IRAPI_APIKeyParameter : [IRAPIManager getAPIKey],
        IRAPI_NonceParameter : nonce,
        IRAPI_SignatureParameter : [IRAPIManager getSignatureWithNonce:nonce],
    };

    [[IRNetworkManager manager] POST:IRAPI_GetBitcoinDepositAddressMethod parameters:parameters handler:responseHandler];
}

#pragma mark Methods (Private)

+ (NSString *)getNonce {
    NSTimeInterval timeInMilliseconds = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%@", @((int) timeInMilliseconds)];
}

+ (NSString *)getAPIKey {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"IndependentReserveAPIKey"];
}

+ (NSString *)getAPISecret {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"IndependentReserveAPISecret"];
}

+ (NSString *)getSignatureWithNonce:(NSString *)nonce {
    return [NSString signatureStringWithAPISecret:[self getAPISecret] apiKey:[self getAPIKey] nonce:nonce];
}

@end
