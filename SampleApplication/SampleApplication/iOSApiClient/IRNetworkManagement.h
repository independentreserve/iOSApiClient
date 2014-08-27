//
//  IRNetworkManagement.h
//  SampleApplication
//
//  Created by Maxim Pervushin on 27/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^IRNetworkResponseHandler)(id content, NSError *error);

@protocol IRNetworkManagement <NSObject>

+ (instancetype)manager;

- (void)GET:(NSString *)urlString parameters:(NSDictionary *)parameters handler:(IRNetworkResponseHandler)handler;

- (void)POST:(NSString *)urlString parameters:(NSDictionary *)parameters handler:(IRNetworkResponseHandler)handler;


@end
