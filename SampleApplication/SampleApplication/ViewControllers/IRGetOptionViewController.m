//
//  IRGetOptionViewController.m
//  SampleApplication
//
//  Created by Maxim Pervushin on 26/08/14.
//  Copyright (c) 2014 Independent Reserve Pty. Ltd. All rights reserved.
//

#import "IRGetOptionViewController.h"

@interface IRGetOptionViewController () <UIPickerViewDataSource>

//@property (nonatomic, readonly) NSArray *options;
@property (nonatomic, weak) IBOutlet UILabel *parameterNameLabel;
@property (nonatomic, weak) IBOutlet UIPickerView *pickerView;

@end

@implementation IRGetOptionViewController
@synthesize options = options_;

#pragma mark - Methods
#pragma mark Methods (Private)

- (void)setOptions:(NSArray *)options {
    if (options_ != options) {
        options_ = options;
    }

    if (self.isViewLoaded) {
        [self.pickerView reloadAllComponents];
    }
}

#pragma mark Methods (Overloaded)

- (id)currentParameterValue {
    NSUInteger selectedRow = [self.pickerView selectedRowInComponent:0];
    return self.options[selectedRow];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSUInteger selectedRow = [self.options indexOfObject:self.initialParameterValue];
    if (selectedRow != NSNotFound) {
        [self.pickerView selectRow:selectedRow inComponent:0 animated:NO];
    }
}

#pragma mark - Protocols
#pragma mark Protocols (UIPickerViewDataSource)

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.options.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.options[row];
}

@end
