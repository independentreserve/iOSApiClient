//
//  IRNetworkManager.m
//  SampleApplication
//
//  Created by Maxim Pervushin on 19/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRNetworkManager.h"

#define IRNetworkManager_PublicAPIEndpoint @"http://dev.api.independentreserve.com/Public"
#define IRNetworkManager_PrivateAPIEndpoint @"http://dev.api.independentreserve.com/Private"

@interface IRNetworkManager ()

@property (nonatomic, strong) NSOperationQueue *queue;

- (NSString *)serializeParameters:(NSDictionary *)parameters;

@end

@implementation IRNetworkManager
@synthesize queue = queue_;

+ (instancetype)manager {
    static IRNetworkManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [IRNetworkManager new];
    });
    return manager;
}

- (NSString *)serializeParameters:(NSDictionary *)parameters {
    if (parameters == nil) {
        return @"";
    } else {
        NSMutableString *parametersString = [NSMutableString new];
        NSUInteger index = 0;
        for (NSString *key in parameters.allKeys) {
            if (index == 0) {
                [parametersString appendFormat:@"?%@=%@", key, parameters[key]];
            } else {
                [parametersString appendFormat:@"&%@=%@", key, parameters[key]];
            }
            index++;
        }
        return [parametersString copy];
    }
}

- (id)init {
    self = [super init];
    if (self != nil) {
        queue_ = [NSOperationQueue new];
        queue_.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    }
    return self;
}

- (void)GET:(NSString *)method parameters:(NSDictionary *)parameters handler:(IRNetworkManagerResponseHandler)handler {
    if (handler == nil) {
        return;
    }

    NSString *parametersString = [self serializeParameters:parameters];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@%@",
                           IRNetworkManager_PublicAPIEndpoint, method, parametersString];
    
    NSURL *url = [NSURL URLWithString:urlString];

    NSLog(@"GET: %@", urlString);

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:self.queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                   if (connectionError != nil) {
                                        handler(NO, nil);
                                   } else {
                                       NSError *jsonError = nil;
                                       id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

                                       NSLog(@"JSON: %@", json);

                                       handler(connectionError == nil && jsonError == nil, json);
                                   }
                           }];
}

- (void)POST:(NSString *)method parameters:(NSDictionary *)parameters handler:(IRNetworkManagerResponseHandler)handler {
    if (handler == nil) {
        return;
    }

    NSString *urlString = [NSString stringWithFormat:@"%@/%@", IRNetworkManager_PrivateAPIEndpoint, method];
    NSURL *url = [NSURL URLWithString:urlString];

    NSLog(@"POST: %@", urlString);
    NSLog(@"PARAMETERS: %@", parameters);

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSError *jsonSerializationError = nil;
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameters options:0 error:&jsonSerializationError]];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:self.queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError != nil) {
                                   handler(NO, nil);
                               } else {
                                   NSError *jsonError = nil;
                                   id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

                                   NSLog(@"JSON: %@", json);

                                   handler(connectionError == nil && jsonError == nil, json);
                               }
                           }];
}

@end
