//
//  IRSampleNetworkManager.m
//  SampleApplication
//
//  Created by Maxim Pervushin on 27/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRSampleNetworkManager.h"

@interface IRSampleNetworkManager ()

@property (nonatomic, strong) NSOperationQueue *queue;

- (NSString *)serializeParameters:(NSDictionary *)parameters;

@end

@implementation IRSampleNetworkManager
@synthesize queue = queue_;

#pragma mark - Methods
#pragma mark Methods (Private)

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

#pragma mark Methods (Overloaded)

- (id)init {
    self = [super init];
    if (self != nil) {
        queue_ = [NSOperationQueue new];
        queue_.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    }
    return self;
}

+ (instancetype)manager {
    static id manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    return manager;
}

- (void)GET:(NSString *)urlString parameters:(NSDictionary *)parameters handler:(IRNetworkResponseHandler)handler {
    if (handler == nil) {
        return;
    }

    NSString *parametersString = [self serializeParameters:parameters];
    NSString *fullURLString = [NSString stringWithFormat:@"%@%@", urlString, parametersString];
    NSURL *url = [NSURL URLWithString:fullURLString];
    NSLog(@"GET: %@", url.absoluteString);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    id completionHandler = ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError == nil) {
            NSError *jsonParseError = nil;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParseError];
            NSLog(@"GET Succeed: %@", jsonObject);
            handler(jsonObject, jsonParseError);

        } else {
            NSLog(@"GET Failed: %@", connectionError.localizedDescription);
            handler(nil, connectionError);
        }
    };
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:self.queue completionHandler:completionHandler];
}

- (void)POST:(NSString *)urlString parameters:(NSDictionary *)parameters handler:(IRNetworkResponseHandler)handler {
    if (handler == nil) {
        return;
    }

    NSURL *url = [NSURL URLWithString:urlString];

    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSError *jsonSerializationError = nil;
    [urlRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameters options:0 error:&jsonSerializationError]];

    NSLog(@"POST: %@", url.absoluteString);
    NSLog(@"Parameters: %@", parameters);

    id completionHandler = ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError == nil) {
            NSError *jsonParseError = nil;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParseError];
            NSLog(@"POST Succeed: %@", jsonObject);
            handler(jsonObject, jsonParseError);

        } else {
            NSLog(@"POST Failed: %@", connectionError.localizedDescription);
            handler(nil, connectionError);
        }
    };
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:self.queue completionHandler:completionHandler];
}

@end
