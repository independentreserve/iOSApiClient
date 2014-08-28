//
//  IRParameterTableViewCell.h
//  SampleApplication
//
//  Created by Maxim Pervushin on 25/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 Table view cell with property for parameter name storage.
 */
@interface IRParameterTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *parameterName;

@end

