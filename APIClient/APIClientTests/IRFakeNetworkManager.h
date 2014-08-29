//
//  IRFakeNetworkManager.h
//  APIClient
//
//  Created by Maxim Pervushin on 29/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRNetworkManagement.h"

@interface IRFakeNetworkManager : NSObject <IRNetworkManagement>

@property (nonatomic, copy) NSString *lastURLString;
@property (nonatomic, strong) NSDictionary *lastParameters;

@end
