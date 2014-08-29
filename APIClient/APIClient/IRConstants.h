//
// Created by Maxim Pervushin on 25/08/14.
// Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

//
// Independent Reserve API related constants
//

// Default API root
extern NSString *const IRAPI_RootPublic;
extern NSString *const IRAPI_RootPrivate;

// Public methods names
extern NSString *const IRAPI_GetValidPrimaryCurrencyCodesMethod;
extern NSString *const IRAPI_GetValidSecondaryCurrencyCodesMethod;
extern NSString *const IRAPI_GetValidLimitOrderTypesMethod;
extern NSString *const IRAPI_GetValidMarketOrderTypesMethod;
extern NSString *const IRAPI_GetMarketSummaryMethod;
extern NSString *const IRAPI_GetOrderBookMethod;
extern NSString *const IRAPI_GetTradeHistorySummaryMethod;
extern NSString *const IRAPI_GetRecentTradesMethod;

// Private methods names
extern NSString *const IRAPI_PlaceLimitOrderMethod;
extern NSString *const IRAPI_PlaceMarketOrderMethod;
extern NSString *const IRAPI_CancelOrderMethod;
extern NSString *const IRAPI_GetOpenOrdersMethod;
extern NSString *const IRAPI_GetClosedOrdersMethod;
extern NSString *const IRAPI_GetAccountsMethod;
extern NSString *const IRAPI_GetTransactionsMethod;
extern NSString *const IRAPI_GetBitcoinDepositAddressMethod;

// Parameters names
extern NSString *const IRAPI_APIKeyParameter;
extern NSString *const IRAPI_AccountGUIDParameter;
extern NSString *const IRAPI_FromTimestampUTCParameter;
extern NSString *const IRAPI_NonceParameter;
extern NSString *const IRAPI_NumberOfHoursInThePastToRetrieveParameter;
extern NSString *const IRAPI_NumberOfRecentTradesToRetrieveParameter;
extern NSString *const IRAPI_OrderGUIDParameter;
extern NSString *const IRAPI_OrderTypeParameter;
extern NSString *const IRAPI_PageIndexParameter;
extern NSString *const IRAPI_PageSizeParameter;
extern NSString *const IRAPI_PriceParameter;
extern NSString *const IRAPI_PrimaryCurrencyCodeParameter;
extern NSString *const IRAPI_SecondaryCurrencyCodeParameter;
extern NSString *const IRAPI_SignatureParameter;
extern NSString *const IRAPI_ToTimestampUTCParameter;
extern NSString *const IRAPI_VolumeParameter;
