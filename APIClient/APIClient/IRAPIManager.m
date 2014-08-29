//
//  IRAPIManager.m
//  SampleApplication
//
//  Created by Maxim Pervushin on 19/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRAPIManager.h"
#import "IRConstants.h"
#import "IRNetworkManagement.h"
#import "IRNetworkManager.h"
#import "NSString+IRSignature.h"

@interface IRAPIManager ()

// Current timestamp converted to string object.
@property (nonatomic, readonly) NSString *nonce;
// Dictionary with parameters required for private methods (nonce, API key, signature).
@property (nonatomic, readonly) NSMutableDictionary *privateRequiredParameters;

// Returns full URL string for public method with name specified.
- (NSString *)publicMethodFullURLString:(NSString *)methodName;

// Returns full URL string for private method with name specified.
- (NSString *)privateMethodFullURLString:(NSString *)methodName;

@end

@implementation IRAPIManager
@dynamic nonce;
@dynamic privateRequiredParameters;
@synthesize networkManager = networkManager_;
@synthesize publicAPIRoot = publicAPIRoot_;
@synthesize privateAPIRoot = privateAPIRoot_;
@synthesize apiKey = apiKey_;
@synthesize apiSecret = apiSecret_;

#pragma mark - Methods
#pragma mark Methods (Static)

+ (instancetype)manager {
    static IRAPIManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [IRAPIManager new];
    });

    return manager;
}

#pragma mark Methods (Public)

- (id <IRNetworkManagement>)networkManager {
    if (networkManager_ == nil) {
        // Use default IRNetworkManager object if property is not set.
        return [IRNetworkManager manager];
    }

    return networkManager_;
}

- (NSString *)publicAPIRoot {
    if (publicAPIRoot_ == nil) {
        // Use IRAPI_RootPublic if property is not set.
        return IRAPI_RootPublic;
    }

    return publicAPIRoot_;
}

- (NSString *)privateAPIRoot {
    if (privateAPIRoot_ == nil) {
        // Use IRAPI_RootPrivate if property is not set.
        return IRAPI_RootPrivate;
    }

    return privateAPIRoot_;
}

- (NSString *)apiKey {
    if (apiKey_ == nil || ![apiKey_ isKindOfClass:NSString.class] || [apiKey_ isEqualToString:@""]) {
        // Return value of 'IndependentReserveAPIKey' property from info.plist if property is not set
        return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"IndependentReserveAPIKey"];
    }

    return apiKey_;
}

- (NSString *)apiSecret {
    if (apiSecret_ == nil || ![apiSecret_ isKindOfClass:NSString.class] || [apiSecret_ isEqualToString:@""]) {
        // Return value of 'IndependentReserveAPISecret' property from info.plist if property is not set
        return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"IndependentReserveAPISecret"];
    }

    return apiSecret_;
}

#pragma mark Independent Reserve API Public Methods

- (void)getValidPrimaryCurrencyCodesResponseHandler:(IRAPIManagerResponseHandler)responseHandler {
    // Perform request
    [self.networkManager GET:[self publicMethodFullURLString:IRAPI_GetValidPrimaryCurrencyCodesMethod]
                  parameters:nil
                     handler:responseHandler];
}

- (void)getValidSecondaryCurrencyCodesResponseHandler:(IRAPIManagerResponseHandler)responseHandler {
    // Perform request
    [self.networkManager GET:[self publicMethodFullURLString:IRAPI_GetValidSecondaryCurrencyCodesMethod]
                  parameters:nil
                     handler:responseHandler];
}

- (void)getValidLimitOrderTypesResponseHandler:(IRAPIManagerResponseHandler)responseHandler {
    // Perform request
    [self.networkManager GET:[self publicMethodFullURLString:IRAPI_GetValidLimitOrderTypesMethod]
                  parameters:nil
                     handler:responseHandler];
}

- (void)getValidMarketOrderTypesResponseHandler:(IRAPIManagerResponseHandler)responseHandler {
    // Perform request
    [self.networkManager GET:[self publicMethodFullURLString:IRAPI_GetValidMarketOrderTypesMethod]
                  parameters:nil
                     handler:responseHandler];
}

- (void)getMarketSummaryForPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                         secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                               responseHandler:(IRAPIManagerResponseHandler)responseHandler {

    // Prepare parameters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    if (primaryCurrencyCode != nil) {
        parameters[IRAPI_PrimaryCurrencyCodeParameter] = primaryCurrencyCode;
    }
    if (secondaryCurrencyCode != nil) {
        parameters[IRAPI_SecondaryCurrencyCodeParameter] = secondaryCurrencyCode;
    }

    // Perform request
    [self.networkManager GET:[self publicMethodFullURLString:IRAPI_GetMarketSummaryMethod]
                  parameters:parameters
                     handler:responseHandler];
}

- (void)getOrderBookForPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                     secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                           responseHandler:(IRAPIManagerResponseHandler)responseHandler {

    // Prepare parameters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    if (primaryCurrencyCode != nil) {
        parameters[IRAPI_PrimaryCurrencyCodeParameter] = primaryCurrencyCode;
    }
    if (secondaryCurrencyCode != nil) {
        parameters[IRAPI_SecondaryCurrencyCodeParameter] = secondaryCurrencyCode;
    }

    // Perform request
    [self.networkManager GET:[self publicMethodFullURLString:IRAPI_GetOrderBookMethod]
                  parameters:parameters
                     handler:responseHandler];
}

- (void)getTradeHistorySummaryForPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                               secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                    numberOfHoursInThePastToRetrieve:(NSNumber *)numberOfHoursInThePastToRetrieve
                                     responseHandler:(IRAPIManagerResponseHandler)responseHandler {

    // Prepare parameters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    if (primaryCurrencyCode != nil) {
        parameters[IRAPI_PrimaryCurrencyCodeParameter] = primaryCurrencyCode;
    }
    if (secondaryCurrencyCode != nil) {
        parameters[IRAPI_SecondaryCurrencyCodeParameter] = secondaryCurrencyCode;
    }
    if (numberOfHoursInThePastToRetrieve != nil) {
        parameters[IRAPI_NumberOfHoursInThePastToRetrieveParameter] = numberOfHoursInThePastToRetrieve;
    }

    // Perform request
    [self.networkManager GET:[self publicMethodFullURLString:IRAPI_GetTradeHistorySummaryMethod]
                  parameters:parameters
                     handler:responseHandler];
}

- (void)getRecentTradesForPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                        secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
               numberOfRecentTradesToRetrieve:(NSNumber *)numberOfRecentTradesToRetrieve
                              responseHandler:(IRAPIManagerResponseHandler)responseHandler {

    // Prepare parameters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    if (primaryCurrencyCode != nil) {
        parameters[IRAPI_PrimaryCurrencyCodeParameter] = primaryCurrencyCode;
    }
    if (secondaryCurrencyCode != nil) {
        parameters[IRAPI_SecondaryCurrencyCodeParameter] = secondaryCurrencyCode;
    }
    if (numberOfRecentTradesToRetrieve != nil) {
        parameters[IRAPI_NumberOfRecentTradesToRetrieveParameter] = numberOfRecentTradesToRetrieve;
    }

    // Perform request
    [self.networkManager GET:[self publicMethodFullURLString:IRAPI_GetRecentTradesMethod]
                  parameters:parameters
                     handler:responseHandler];
}

#pragma mark Independent Reserve API Private Methods

- (void)placeLimitOrderWithPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                         secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                                     orderType:(NSString *)orderType
                                         price:(NSNumber *)price
                                        volume:(NSNumber *)volume
                               responseHandler:(IRAPIManagerResponseHandler)responseHandler {

    // Prepare parameters
    NSMutableDictionary *parameters = [self.privateRequiredParameters mutableCopy];
    if (primaryCurrencyCode != nil) {
        parameters[IRAPI_PrimaryCurrencyCodeParameter] = primaryCurrencyCode;
    }
    if (secondaryCurrencyCode != nil) {
        parameters[IRAPI_SecondaryCurrencyCodeParameter] = secondaryCurrencyCode;
    }
    if (orderType != nil) {
        parameters[IRAPI_OrderTypeParameter] = orderType;
    }
    if (price != nil) {
        parameters[IRAPI_PriceParameter] = price;
    }
    if (volume != nil) {
        parameters[IRAPI_VolumeParameter] = volume;
    }

    // Perform request
    [self.networkManager POST:[self privateMethodFullURLString:IRAPI_PlaceLimitOrderMethod]
                   parameters:parameters
                      handler:responseHandler];
}

- (void)placeMarketOrderWithPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                          secondaryCurrencyCode:(NSString *)secondaryCurrencyCode orderType:(NSString *)orderType
                                         volume:(NSNumber *)volume
                                responseHandler:(IRAPIManagerResponseHandler)responseHandler {

    // Prepare parameters
    NSMutableDictionary *parameters = [self.privateRequiredParameters mutableCopy];
    if (primaryCurrencyCode != nil) {
        parameters[IRAPI_PrimaryCurrencyCodeParameter] = primaryCurrencyCode;
    }
    if (secondaryCurrencyCode != nil) {
        parameters[IRAPI_SecondaryCurrencyCodeParameter] = secondaryCurrencyCode;
    }
    if (orderType != nil) {
        parameters[IRAPI_OrderTypeParameter] = orderType;
    }
    if (volume != nil) {
        parameters[IRAPI_VolumeParameter] = volume;
    }

    // Perform request
    [self.networkManager POST:[self privateMethodFullURLString:IRAPI_PlaceMarketOrderMethod]
                   parameters:parameters
                      handler:responseHandler];
}

- (void)cancelOrderWithGUID:(NSString *)orderGUID responseHandler:(IRAPIManagerResponseHandler)responseHandler {

    // Prepare parameters
    NSMutableDictionary *parameters = [self.privateRequiredParameters mutableCopy];
    if (orderGUID != nil) {
        parameters[IRAPI_OrderGUIDParameter] = orderGUID;
    }

    // Perform request
    [self.networkManager POST:[self privateMethodFullURLString:IRAPI_CancelOrderMethod]
                   parameters:parameters
                      handler:responseHandler];
}

- (void)getOpenOrdersWithPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                       secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                                   pageIndex:(NSNumber *)pageIndex
                                    pageSize:(NSNumber *)pageSize
                             responseHandler:(IRAPIManagerResponseHandler)responseHandler {

    // Prepare parameters
    NSMutableDictionary *parameters = [self.privateRequiredParameters mutableCopy];
    if (primaryCurrencyCode != nil) {
        parameters[IRAPI_PrimaryCurrencyCodeParameter] = primaryCurrencyCode;
    }
    if (secondaryCurrencyCode != nil) {
        parameters[IRAPI_SecondaryCurrencyCodeParameter] = secondaryCurrencyCode;
    }
    if (pageIndex != nil) {
        parameters[IRAPI_PageIndexParameter] = pageIndex;
    }
    if (pageSize != nil) {
        parameters[IRAPI_PageSizeParameter] = pageSize;
    }

    // Perform request
    [self.networkManager POST:[self privateMethodFullURLString:IRAPI_GetOpenOrdersMethod]
                   parameters:parameters
                      handler:responseHandler];
}

- (void)getClosedOrdersWithPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                         secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                                     pageIndex:(NSNumber *)pageIndex
                                      pageSize:(NSNumber *)pageSize
                               responseHandler:(IRAPIManagerResponseHandler)responseHandler {

    // Prepare parameters
    NSMutableDictionary *parameters = [self.privateRequiredParameters mutableCopy];
    if (primaryCurrencyCode != nil) {
        parameters[IRAPI_PrimaryCurrencyCodeParameter] = primaryCurrencyCode;
    }
    if (secondaryCurrencyCode != nil) {
        parameters[IRAPI_SecondaryCurrencyCodeParameter] = secondaryCurrencyCode;
    }
    if (pageIndex != nil) {
        parameters[IRAPI_PageIndexParameter] = pageIndex;
    }
    if (pageSize != nil) {
        parameters[IRAPI_PageSizeParameter] = pageSize;
    }

    // Perform request
    [self.networkManager POST:[self privateMethodFullURLString:IRAPI_GetClosedOrdersMethod]
                   parameters:parameters
                      handler:responseHandler];
}

- (void)getAccountsWithResponseHandler:(IRAPIManagerResponseHandler)responseHandler {

    // Prepare parameters
    NSMutableDictionary *parameters = [self.privateRequiredParameters mutableCopy];

    // Perform request
    [self.networkManager POST:[self privateMethodFullURLString:IRAPI_GetAccountsMethod]
                   parameters:parameters
                      handler:responseHandler];
}

- (void)getTransactionsWithAccountGUID:(NSString *)accountGUID
                              fromDate:(NSDate *)fromDate
                                toDate:(NSDate *)toDate
                             pageIndex:(NSNumber *)pageIndex
                              pageSize:(NSNumber *)pageSize
                       responseHandler:(IRAPIManagerResponseHandler)responseHandler {

    // Prepare parameters
    NSMutableDictionary *parameters = [self.privateRequiredParameters mutableCopy];
    if (accountGUID != nil) {
        parameters[IRAPI_AccountGUIDParameter] = accountGUID;
    }
    // Convert fromDate and toDate to ISO 8601 standard string.
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    if (fromDate != nil) {
        parameters[IRAPI_FromTimestampUTCParameter] = [formatter stringFromDate:fromDate];
    }
    if (toDate != nil) {
        parameters[IRAPI_ToTimestampUTCParameter] = [formatter stringFromDate:toDate];
    }
    if (pageIndex != nil) {
        parameters[IRAPI_PageIndexParameter] = pageIndex;
    }
    if (pageSize != nil) {
        parameters[IRAPI_PageSizeParameter] = pageSize;
    }

    // Perform request
    [self.networkManager POST:[self privateMethodFullURLString:IRAPI_GetTransactionsMethod]
                   parameters:parameters
                      handler:responseHandler];
}

- (void)getBitcoinDepositAddressWithResponseHandler:(IRAPIManagerResponseHandler)responseHandler {
    // Perform request
    [self.networkManager POST:[self privateMethodFullURLString:IRAPI_GetBitcoinDepositAddressMethod]
                   parameters:[self.privateRequiredParameters mutableCopy]
                      handler:responseHandler];
}

#pragma mark Methods (Private)

- (NSString *)nonce {
    return [NSString stringWithFormat:@"%@", @((int) [[NSDate date] timeIntervalSince1970])];
}

- (NSMutableDictionary *)privateRequiredParameters {

    NSString *nonce = self.nonce;

    NSMutableDictionary *requiredParameters = [@{
        IRAPI_NonceParameter : nonce
    } mutableCopy];

    if (self.apiKey != nil && self.apiSecret != nil) {
        requiredParameters[IRAPI_APIKeyParameter] = self.apiKey;
        requiredParameters[IRAPI_SignatureParameter]
            = [NSString signatureStringWithAPIKey:self.apiKey apiSecret:self.apiSecret nonce:nonce];
    } else {
        NSLog(@"WARNING: Independent Reserve API key or API secret is not set. Private methods will not work.");
    }

    return requiredParameters;
}

- (NSString *)publicMethodFullURLString:(NSString *)methodName {
    return [NSString stringWithFormat:@"%@/%@", self.publicAPIRoot, methodName];
}

- (NSString *)privateMethodFullURLString:(NSString *)methodName {
    return [NSString stringWithFormat:@"%@/%@", self.privateAPIRoot, methodName];
}

@end
