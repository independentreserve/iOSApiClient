//
//  IRNetworkManagement.h
//  SampleApplication
//
//  Created by Maxim Pervushin on 27/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^IRNetworkResponseHandler)(id content, NSError *error);

/*!
    @protocol
        IRNetworkManagement
 
    @abstract
        IRNetworkManagement protocol declares a methods for GET and POST network requests.
 */
@protocol IRNetworkManagement <NSObject>

/*!
    @method
        manager
 
    @abstract
        Returns default instance.
 */
+ (instancetype)manager;

/*!
    @method
        GET:parameters:handler:
        
    @abstract
        Performs HTTP GET request.
 
    @param
        urlString
            URL string of the request.
 
    @param
        parameters
            Dictionary with parameters.
 
    @param
        handler
            A block which receives the results of the GET request.
 */
- (void)GET:(NSString *)urlString parameters:(NSDictionary *)parameters handler:(IRNetworkResponseHandler)handler;

/*!
    @method
        POST:parameters:handler:

    @abstract
        Performs HTTP POST request with 'application/json' content type.

    @param
        urlString
            URL string of the request.

    @param
        parameters
            Dictionary with parameters.

    @param
        handler
            A block which receives the results of the GET request.
 */
- (void)POST:(NSString *)urlString parameters:(NSDictionary *)parameters handler:(IRNetworkResponseHandler)handler;

@end
