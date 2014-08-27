//
//  IRAPIManager.h
//  SampleApplication
//
//  Created by Maxim Pervushin on 19/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IRNetworkManagement;

typedef void (^IRAPIManagerResponseHandler)(id content, NSError *error);

/*!
    @class IRAPIManager

    @abstract
        Independent Reserve API management class.
*/
@interface IRAPIManager : NSObject

/*!
    @method manager

    @abstract
        Retrieves default IRAPIManager instance.
 */
+ (instancetype)manager;

/*!
    @property networkManager

    @abstract
        Network management object which performs network requests.

*/
@property (nonatomic, strong) id <IRNetworkManagement> networkManager;

/*!
    @property publicAPIRoot
 
    @abstract 
        Independent Reserve API root for public methods. If property set to nil returns IRAPI_RootPublic value from IRConstants.
*/
@property (nonatomic, strong) NSString *publicAPIRoot;

/*!
    @property privateAPIRoot
 
    @abstract
        Independent Reserve API root for private methods. If property set to nil returns IRAPI_RootPrivate value from IRConstants.
 */
@property (nonatomic, strong) NSString *privateAPIRoot;

/*!
    @property apiKey

    @abstract
        API key used to perform requests to private methods. If property set to nil returns 'IndependentReserveAPIKey' value from info.plist.
*/
@property (nonatomic, strong) NSString *apiKey;

/*!
    @property apiSecret

    @abstract
        API secret used to perform requests to private methods. If property set to nil returns 'IndependentReserveAPISecret' value from info.plist.
*/
@property (nonatomic, strong) NSString *apiSecret;

/*!
    @method getValidPrimaryCurrencyCodesResponseHandler:

    @abstract
        Retrieves valid primary currency codes.

    @param
        responseHandler
        A block which receives the results of the API call.
*/
- (void)getValidPrimaryCurrencyCodesResponseHandler:(IRAPIManagerResponseHandler)responseHandler;

/*!
    @method getValidSecondaryCurrencyCodesResponseHandler:

    @abstract
        Retrieves valid secondary currency codes.

    @param
        responseHandler
            A block which receives the results of the API call.
*/
- (void)getValidSecondaryCurrencyCodesResponseHandler:(IRAPIManagerResponseHandler)responseHandler;

/*!
    @method getValidLimitOrderTypesResponseHandler:

    @abstract
        Retrieves valid limit order types.

    @param
        responseHandler
            A block which receives the results of the API call.
*/
- (void)getValidLimitOrderTypesResponseHandler:(IRAPIManagerResponseHandler)responseHandler;

/*!
    @method getValidMarketOrderTypesResponseHandler:

    @abstract
        Retrieves valid market order types.

    @param
        responseHandler
            A block which receives the results of the API call.
*/
- (void)getValidMarketOrderTypesResponseHandler:(IRAPIManagerResponseHandler)responseHandler;

/*!
    @method
        getMarketSummaryForPrimaryCurrencyCode:secondaryCurrencyCode:responseHandler:

    @abstract
        Retrieves a current snapshot of the Independent Reserve market for a given currency pair.

    @param
        primaryCurrencyCode
            Primary currency code. Must be a valid primary currency which can be checked via the getValidPrimaryCurrencyCodesResponseHandler: methodName.
    
    @param
        secondaryCurrencyCode
            Secondary currency code. Must be a valid secondary currency which can be checked via the getValidSecondaryCurrencyCodesResponseHandler: methodName.
    
    @param
        responseHandler
            A block which receives the results of the API call.
*/
- (void)getMarketSummaryForPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                         secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                               responseHandler:(IRAPIManagerResponseHandler)responseHandler;

/*!
    @method
        getOrderBookForPrimaryCurrencyCode:secondaryCurrencyCode:responseHandler:

    @abstract
        Retrieves the order book for a given currency pair.

    @param
        primaryCurrencyCode
            Primary currency code. Must be a valid primary currency which can be checked via the getValidPrimaryCurrencyCodesResponseHandler: methodName.

    @param
        secondaryCurrencyCode
            Secondary currency code. Must be a valid secondary currency which can be checked via the getValidSecondaryCurrencyCodesResponseHandler: methodName.

    @param
        responseHandler
            A block which receives the results of the API call.
*/
- (void)getOrderBookForPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                     secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                           responseHandler:(IRAPIManagerResponseHandler)responseHandler;

/*!
    @method
        getTradeHistorySummaryForPrimaryCurrencyCode:secondaryCurrencyCode:numberOfHoursInThePastToRetrieve:responseHandler:

    @abstract
        Retrieves summarised historical trading data for a given currency pair. Data is summarised into 1 hour intervals.

    @param
        primaryCurrencyCode
            Primary currency code. Must be a valid primary currency which can be checked via the getValidPrimaryCurrencyCodesResponseHandler: methodName.

    @param
        secondaryCurrencyCode
            Secondary currency code. Must be a valid secondary currency which can be checked via the getValidSecondaryCurrencyCodesResponseHandler: methodName.

    @param
        numberOfHoursInThePastToRetrieve
            How many past hours of historical summary data to retrieve.

    @param
        responseHandler
            A block which receives the results of the API call.
*/
- (void)getTradeHistorySummaryForPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                               secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                    numberOfHoursInThePastToRetrieve:(NSNumber *)numberOfHoursInThePastToRetrieve
                                     responseHandler:(IRAPIManagerResponseHandler)responseHandler;

/*!
    @method
        getRecentTradesForPrimaryCurrencyCode:secondaryCurrencyCode:numberOfRecentTradesToRetrieve:responseHandler:

    @abstract
        Retrieves a list of most recently executed trades for a given currency pair.

    @param
        primaryCurrencyCode
            Primary currency code. Must be a valid primary currency which can be checked via the getValidPrimaryCurrencyCodesResponseHandler: methodName.

    @param
        secondaryCurrencyCode
            Secondary currency code. Must be a valid secondary currency which can be checked via the getValidSecondaryCurrencyCodesResponseHandler: methodName.

    @param
        numberOfRecentTradesToRetrieve
            How many recent trades to retrieve.

    @param
        responseHandler
            A block which receives the results of the API call.
*/
- (void)getRecentTradesForPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                        secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
               numberOfRecentTradesToRetrieve:(NSNumber *)numberOfRecentTradesToRetrieve
                              responseHandler:(IRAPIManagerResponseHandler)responseHandler;

/*!
    @method
        placeLimitOrderWithPrimaryCurrencyCode:secondaryCurrencyCode:orderType:price:volume:responseHandler:

    @abstract
        Places new limit bid / offer order. A Limit Bid is a buy order and a Limit Offer is a sell order.

    @param
        primaryCurrencyCode
            Primary currency code. Must be a valid primary currency which can be checked via the getValidPrimaryCurrencyCodesResponseHandler: methodName.

    @param
        secondaryCurrencyCode
            Secondary currency code. Must be a valid secondary currency which can be checked via the getValidSecondaryCurrencyCodesResponseHandler: methodName.

    @param
        orderType
            The type of limit order. Must be a valid limit order type, which can be checked via the getValidLimitOrderTypesResponseHandler: methodName.

    @param
        price
            The price in secondary currency to buy/sell.

    @param
        volume
            The volume to buy/sell in primary currency.

    @param
        responseHandler
            A block which receives the results of the API call.
*/
- (void)placeLimitOrderWithPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                         secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                                     orderType:(NSString *)orderType
                                         price:(NSNumber *)price
                                        volume:(NSNumber *)volume
                               responseHandler:(IRAPIManagerResponseHandler)responseHandler;

/*!
    @method
        placeMarketOrderWithPrimaryCurrencyCode:secondaryCurrencyCode:orderType:volume:responseHandler:

    @abstract
        Places new market bid / offer order. A Market Bid is a buy order and a Market Offer is a sell order.

    @param
        primaryCurrencyCode
            Primary currency code. Must be a valid primary currency which can be checked via the getValidPrimaryCurrencyCodesResponseHandler: methodName.

    @param
        secondaryCurrencyCode
            Secondary currency code. Must be a valid secondary currency which can be checked via the getValidSecondaryCurrencyCodesResponseHandler: methodName.

    @param
        orderType
            The type of market order. Must be a valid market order type, which can be checked via the getValidMarketOrderTypesResponseHandler: methodName.

    @param
        volume
            The volume to buy/sell in primary currency.

    @param
        responseHandler
            A block which receives the results of the API call.
*/
- (void)placeMarketOrderWithPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                          secondaryCurrencyCode:(NSString *)secondaryCurrencyCode orderType:(NSString *)orderType
                                         volume:(NSNumber *)volume
                                responseHandler:(IRAPIManagerResponseHandler)responseHandler;

/*!
    @method
        cancelOrderWithGUID:responseHandler:

    @abstract
        Cancels a previously placed order.

    @param
        orderGUID
            The GUID of currently open or partially filled order.

    @param
        responseHandler
            A block which receives the results of the API call.
*/
- (void)cancelOrderWithGUID:(NSString *)orderGUID
            responseHandler:(IRAPIManagerResponseHandler)responseHandler;

/*!
    @method
        getOpenOrdersWithPrimaryCurrencyCode:secondaryCurrencyCode:pageIndex:pageSize:responseHandler:

    @abstract
        Retrieves a page of a specified size, with your currently Open and Partially Filled orders.

    @param
        primaryCurrencyCode
            Primary currency code. Must be a valid primary currency which can be checked via the getValidPrimaryCurrencyCodesResponseHandler: methodName.

    @param
        secondaryCurrencyCode
            Secondary currency code. Must be a valid secondary currency which can be checked via the getValidSecondaryCurrencyCodesResponseHandler: methodName.

    @param
        pageIndex
            The page index.

    @param
        pageSize
            The size of the page.

    @param
        responseHandler
            A block which receives the results of the API call.
*/
- (void)getOpenOrdersWithPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                       secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                                   pageIndex:(NSNumber *)pageIndex
                                    pageSize:(NSNumber *)pageSize
                             responseHandler:(IRAPIManagerResponseHandler)responseHandler;

/*!
    @method
        getClosedOrdersWithPrimaryCurrencyCode:secondaryCurrencyCode:pageIndex:pageSize:responseHandler:

    @abstract
        Retrieves a page of a specified, size with your Closed and Cancelled orders.

    @param
        primaryCurrencyCode
            Primary currency code. Must be a valid primary currency which can be checked via the getValidPrimaryCurrencyCodesResponseHandler: methodName.

    @param
        secondaryCurrencyCode
            Secondary currency code. Must be a valid secondary currency which can be checked via the getValidSecondaryCurrencyCodesResponseHandler: methodName.

    @param
        pageIndex
            The page index.

    @param
        pageSize
            The size of the page.

    @param
        responseHandler
            A block which receives the results of the API call.
*/
- (void)getClosedOrdersWithPrimaryCurrencyCode:(NSString *)primaryCurrencyCode
                         secondaryCurrencyCode:(NSString *)secondaryCurrencyCode
                                     pageIndex:(NSNumber *)pageIndex
                                      pageSize:(NSNumber *)pageSize
                               responseHandler:(IRAPIManagerResponseHandler)responseHandler;

/*!
    @method
        getAccountsWithResponseHandler:

    @abstract
        Retrieves information about your Independent Reserve accounts in digital and fiat currencies.

    @param
        responseHandler
            A block which receives the results of the API call.
*/
- (void)getAccountsWithResponseHandler:(IRAPIManagerResponseHandler)responseHandler;

/*!
    @method
        getTransactionsWithAccountGUID:fromDate:toDate:pageIndex:pageSize:responseHandler:

    @abstract
        Retrieves a page of a specified size, containing all transactions made on an account.

    @param
        accountGUID
            The GUID of your Independent Reserve account. You can retrieve information about your accounts via the getAccountsWithResponseHandler: methodName

    @param
        fromDate
            Optional. The date from which you want to retrieve transactions.

    @param
        toDate
            Optional. The date until which you want to retrieve transactions.

    @param
        pageIndex
            The page index.

    @param
        pageSize
            The size of the page.

    @param
        responseHandler
            A block which receives the results of the API call.
*/
- (void)getTransactionsWithAccountGUID:(NSString *)accountGUID
                              fromDate:(NSDate *)fromDate
                                toDate:(NSDate *)toDate
                             pageIndex:(NSNumber *)pageIndex
                              pageSize:(NSNumber *)pageSize
                       responseHandler:(IRAPIManagerResponseHandler)responseHandler;

/*!
    @method
        getBitcoinDepositAddressWithResponseHandler:

    @abstract
        Retrieves the Bitcoin address which should be used for new Bitcoin deposits.

    @param
        responseHandler
            A block which receives the results of the API call.
*/
- (void)getBitcoinDepositAddressWithResponseHandler:(IRAPIManagerResponseHandler)responseHandler;

@end
