//
//  IRFakeNetworkManager.m
//  APIClient
//
//  Created by Maxim Pervushin on 29/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRFakeNetworkManager.h"

@implementation IRFakeNetworkManager

+ (instancetype)manager {
    return nil;
}

- (void)GET:(NSString *)urlString parameters:(NSDictionary *)parameters handler:(IRNetworkResponseHandler)handler {
    self.lastURLString = urlString;
    self.lastParameters = parameters;
}

- (void)POST:(NSString *)urlString parameters:(NSDictionary *)parameters handler:(IRNetworkResponseHandler)handler {
    self.lastURLString = urlString;
    self.lastParameters = parameters;
}

@end
