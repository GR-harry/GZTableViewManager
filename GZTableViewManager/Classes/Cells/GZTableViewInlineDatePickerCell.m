//
//  GZTableViewInlineDatePickerCell.m
//  GZTableViewManager
//
//  Created by GR on 2018/10/30.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZTableViewInlineDatePickerCell.h"

@interface GZTableViewInlineDatePickerCell ()

@property (strong, nonatomic) UIDatePicker      *datePicker;
@property (strong, nonatomic) NSDateFormatter   *dateFormatter;

@end

@implementation GZTableViewInlineDatePickerCell

@dynamic item;

#pragma mark - Life Cycle
- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.datePicker             = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [self.datePicker addTarget:self action:@selector(dateDidChanged:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.datePicker];
    
    self.dateFormatter          = [[NSDateFormatter alloc] init];
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    self.textLabel.text             = self.item.text;
    
    self.datePicker.date            = self.item.value;
    self.datePicker.datePickerMode  = self.item.datePickerMode;
    self.datePicker.locale          = self.item.locale;
    self.datePicker.calendar        = self.item.calendar;
    self.datePicker.timeZone        = self.item.timeZone;
    self.datePicker.minimumDate     = self.item.minimumDate;
    self.datePicker.maximumDate     = self.item.maximumDate;
    self.datePicker.minuteInterval  = self.item.minuteInterval;
    
    self.dateFormatter.dateFormat   = self.item.dateFormat;
    self.dateFormatter.locale       = self.item.locale;
    self.dateFormatter.calendar     = self.item.calendar;
    self.dateFormatter.timeZone     = self.item.timeZone;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.datePicker.frame = self.contentView.bounds;
}

#pragma mark - Actions
- (void)dateDidChanged:(UIDatePicker *)datePicker {
    
    self.item.value             = datePicker.date;
    
    if (self.item.onChange) {
        self.item.onChange(self.item);
    }
}
@end
