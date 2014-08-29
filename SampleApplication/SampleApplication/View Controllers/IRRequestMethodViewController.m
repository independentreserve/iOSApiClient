//
//  IRRequestMethodViewController.m
//  SampleApplication
//
//  Created by Maxim Pervushin on 20/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRRequestMethodViewController.h"

@interface IRRequestMethodViewController ()

@property (nonatomic, weak) IBOutlet UILabel *methodParametersLabel;
@property (nonatomic, weak) IBOutlet UILabel *responseLabel;

@end

@implementation IRRequestMethodViewController

- (void)viewWillAppear:(BOOL)animated {

    self.title = self.methodName;
    self.methodParametersLabel.text = self.methodParameters != nil ? self.methodParameters.description : @"No Parameters";

    __weak __typeof(&*self) weakSelf = self;
    id responseHandler = ^(id response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong __typeof(&*weakSelf) strongSelf = weakSelf;
            if (error == nil) {
                strongSelf.responseLabel.text = [response description];
            } else {
                strongSelf.responseLabel.text = error.localizedDescription;
            }
        });
    };

    // Invoke IRAPIManager method corresponding to IR API method.
    if ([self.methodName isEqualToString:IRAPI_GetValidPrimaryCurrencyCodesMethod]) {
        [[IRAPIManager manager] getValidPrimaryCurrencyCodesResponseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:IRAPI_GetValidSecondaryCurrencyCodesMethod]) {
        [[IRAPIManager manager] getValidSecondaryCurrencyCodesResponseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:IRAPI_GetValidLimitOrderTypesMethod]) {
        [[IRAPIManager manager] getValidLimitOrderTypesResponseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:IRAPI_GetValidMarketOrderTypesMethod]) {
        [[IRAPIManager manager] getValidMarketOrderTypesResponseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:IRAPI_GetMarketSummaryMethod]) {
        [[IRAPIManager manager] getMarketSummaryForPrimaryCurrencyCode:self.methodParameters[IRAPI_PrimaryCurrencyCodeParameter]
                                                 secondaryCurrencyCode:self.methodParameters[IRAPI_SecondaryCurrencyCodeParameter]
                                                       responseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:IRAPI_GetOrderBookMethod]) {
        [[IRAPIManager manager] getOrderBookForPrimaryCurrencyCode:self.methodParameters[IRAPI_PrimaryCurrencyCodeParameter]
                                             secondaryCurrencyCode:self.methodParameters[IRAPI_SecondaryCurrencyCodeParameter]
                                                   responseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:IRAPI_GetTradeHistorySummaryMethod]) {
        [[IRAPIManager manager] getTradeHistorySummaryForPrimaryCurrencyCode:self.methodParameters[IRAPI_PrimaryCurrencyCodeParameter]
                                                       secondaryCurrencyCode:self.methodParameters[IRAPI_SecondaryCurrencyCodeParameter]
                                            numberOfHoursInThePastToRetrieve:self.methodParameters[IRAPI_NumberOfHoursInThePastToRetrieveParameter]
                                                             responseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:IRAPI_GetRecentTradesMethod]) {
        [[IRAPIManager manager] getRecentTradesForPrimaryCurrencyCode:self.methodParameters[IRAPI_PrimaryCurrencyCodeParameter]
                                                secondaryCurrencyCode:self.methodParameters[IRAPI_SecondaryCurrencyCodeParameter]
                                       numberOfRecentTradesToRetrieve:self.methodParameters[IRAPI_NumberOfRecentTradesToRetrieveParameter]
                                                      responseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:IRAPI_PlaceLimitOrderMethod]) {
        [[IRAPIManager manager] placeLimitOrderWithPrimaryCurrencyCode:self.methodParameters[IRAPI_PrimaryCurrencyCodeParameter]
                                                 secondaryCurrencyCode:self.methodParameters[IRAPI_SecondaryCurrencyCodeParameter]
                                                             orderType:self.methodParameters[IRAPI_OrderTypeParameter]
                                                                 price:self.methodParameters[IRAPI_PriceParameter]
                                                                volume:self.methodParameters[IRAPI_VolumeParameter]
                                                       responseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:IRAPI_PlaceMarketOrderMethod]) {
        [[IRAPIManager manager] placeMarketOrderWithPrimaryCurrencyCode:self.methodParameters[IRAPI_PrimaryCurrencyCodeParameter]
                                                  secondaryCurrencyCode:self.methodParameters[IRAPI_SecondaryCurrencyCodeParameter]
                                                              orderType:self.methodParameters[IRAPI_OrderTypeParameter]
                                                                 volume:self.methodParameters[IRAPI_VolumeParameter]
                                                        responseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:IRAPI_CancelOrderMethod]) {
        [[IRAPIManager manager] cancelOrderWithGUID:self.methodParameters[IRAPI_OrderGUIDParameter]
                                    responseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:IRAPI_GetOpenOrdersMethod]) {
        [[IRAPIManager manager] getOpenOrdersWithPrimaryCurrencyCode:self.methodParameters[IRAPI_PrimaryCurrencyCodeParameter]
                                               secondaryCurrencyCode:self.methodParameters[IRAPI_SecondaryCurrencyCodeParameter]
                                                           pageIndex:self.methodParameters[IRAPI_PageIndexParameter]
                                                            pageSize:self.methodParameters[IRAPI_PageSizeParameter]
                                                     responseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:IRAPI_GetClosedOrdersMethod]) {
        [[IRAPIManager manager] getClosedOrdersWithPrimaryCurrencyCode:self.methodParameters[IRAPI_PrimaryCurrencyCodeParameter]
                                                 secondaryCurrencyCode:self.methodParameters[IRAPI_SecondaryCurrencyCodeParameter]
                                                             pageIndex:self.methodParameters[IRAPI_PageIndexParameter]
                                                              pageSize:self.methodParameters[IRAPI_PageSizeParameter]
                                                       responseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:IRAPI_GetAccountsMethod]) {
        [[IRAPIManager manager] getAccountsWithResponseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:IRAPI_GetTransactionsMethod]) {
        [[IRAPIManager manager] getTransactionsWithAccountGUID:self.methodParameters[IRAPI_AccountGUIDParameter]
                                                      fromDate:self.methodParameters[IRAPI_FromTimestampUTCParameter]
                                                        toDate:self.methodParameters[IRAPI_ToTimestampUTCParameter]
                                                     pageIndex:self.methodParameters[IRAPI_PageIndexParameter]
                                                      pageSize:self.methodParameters[IRAPI_PageSizeParameter]
                                               responseHandler:responseHandler];

    } else if ([self.methodName isEqualToString:IRAPI_GetBitcoinDepositAddressMethod]) {
        [[IRAPIManager manager] getBitcoinDepositAddressWithResponseHandler:responseHandler];
    }

    [super viewWillAppear:animated];
}

@end
