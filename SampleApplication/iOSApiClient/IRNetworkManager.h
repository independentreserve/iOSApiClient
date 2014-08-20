//
//  IRNetworkManager.h
//  SampleApplication
//
//  Created by Maxim Pervushin on 19/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^IRNetworkManagerResponseHandler)(BOOL success, id content);

@interface IRNetworkManager : NSObject

+ (instancetype)manager;

- (void)GET:(NSString *)method parameters:(NSDictionary *)parameters handler:(IRNetworkManagerResponseHandler)handler;

- (void)POST:(NSString *)method parameters:(NSDictionary *)parameters handler:(IRNetworkManagerResponseHandler)handler;

@end
