//
//  IRSampleNetworkManager.h
//  SampleApplication
//
//  Created by Maxim Pervushin on 27/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRNetworkManagement.h"

/*
 Sample network management class. The only difference from IRNetworkManager class is extra logging.
    Made to demonstrate ability of IRAPIManager to use advanced network managers which corresponds 
    to IRNetworkManagement protocol. In your application you can create network manager that have
    better integration with your application.
 */
@interface IRSampleNetworkManager : NSObject <IRNetworkManagement>

@end
