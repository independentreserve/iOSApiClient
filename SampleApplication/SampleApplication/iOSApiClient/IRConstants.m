//
// Created by Maxim Pervushin on 25/08/14.
// Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRConstants.h"

NSString *const IRAPI_RootPublic = @"https://api.independentreserve.com/Public";
NSString *const IRAPI_RootPrivate = @"https://api.independentreserve.com/Private";

NSString *const IRAPI_GetValidPrimaryCurrencyCodesMethod = @"GetValidPrimaryCurrencyCodes";
NSString *const IRAPI_GetValidSecondaryCurrencyCodesMethod = @"GetValidSecondaryCurrencyCodes";
NSString *const IRAPI_GetValidLimitOrderTypesMethod = @"GetValidLimitOrderTypes";
NSString *const IRAPI_GetValidMarketOrderTypesMethod = @"GetValidMarketOrderTypes";
NSString *const IRAPI_GetMarketSummaryMethod = @"GetMarketSummary";
NSString *const IRAPI_GetOrderBookMethod = @"GetOrderBook";
NSString *const IRAPI_GetTradeHistorySummaryMethod = @"GetTradeHistorySummary";
NSString *const IRAPI_GetRecentTradesMethod = @"GetRecentTrades";

NSString *const IRAPI_PlaceLimitOrderMethod = @"PlaceLimitOrder";
NSString *const IRAPI_PlaceMarketOrderMethod = @"PlaceMarketOrder";
NSString *const IRAPI_CancelOrderMethod = @"CancelOrder";
NSString *const IRAPI_GetAccountsMethod = @"GetAccounts";
NSString *const IRAPI_GetBitcoinDepositAddressMethod = @"GetBitcoinDepositAddress";
NSString *const IRAPI_GetOpenOrdersMethod = @"GetOpenOrders";
NSString *const IRAPI_GetClosedOrdersMethod = @"GetClosedOrders";
NSString *const IRAPI_GetTransactionsMethod = @"GetTransactions";

NSString *const IRAPI_APIKeyParameter = @"apiKey";
NSString *const IRAPI_AccountGUIDParameter = @"accountGuid";
NSString *const IRAPI_FromTimestampUTCParameter = @"fromTimestampUtc";
NSString *const IRAPI_NonceParameter = @"nonce";
NSString *const IRAPI_NumberOfHoursInThePastToRetrieveParameter = @"numberOfHoursInThePastToRetrieve";
NSString *const IRAPI_NumberOfRecentTradesToRetrieveParameter = @"numberOfRecentTradesToRetrieve";
NSString *const IRAPI_OrderGUIDParameter = @"orderGuid";
NSString *const IRAPI_OrderTypeParameter = @"orderType";
NSString *const IRAPI_PageIndexParameter = @"pageIndex";
NSString *const IRAPI_PageSizeParameter = @"pageSize";
NSString *const IRAPI_PriceParameter = @"price";
NSString *const IRAPI_PrimaryCurrencyCodeParameter = @"primaryCurrencyCode";
NSString *const IRAPI_SecondaryCurrencyCodeParameter = @"secondaryCurrencyCode";
NSString *const IRAPI_SignatureParameter = @"signature";
NSString *const IRAPI_ToTimestampUTCParameter = @"toTimestampUtc";
NSString *const IRAPI_VolumeParameter = @"volume";


