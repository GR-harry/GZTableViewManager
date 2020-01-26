//
//  GZTableViewDatePickerCell.m
//  GZTableViewManager
//
//  Created by GR on 2018/10/30.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZTableViewDatePickerCell.h"
#import "GZTableViewManager.h"
#import "GZInlineDatePickerItem.h"
#import "GZTableViewSection.h"

@interface GZTableViewDatePickerCell ()<UITextFieldDelegate>

@property (strong, nonatomic) UIDatePicker              *datePicker;
@property (strong, nonatomic) UITextField               *textField;
@property (strong, nonatomic) NSDateFormatter           *dateFormatter;
@property (strong, nonatomic) GZInlineDatePickerItem    *inlineDatePickerItem;
@property (assign, nonatomic) BOOL                      datePickerDidPresented;

@end

@implementation GZTableViewDatePickerCell

@synthesize item = _item;

#pragma mark - Life Cycle
- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.datePicker             = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [self.datePicker addTarget:self action:@selector(datePickerDidChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.textField              = [[UITextField alloc] initWithFrame:CGRectZero];
    self.textField.delegate     = self;
    self.textField.inputView    = self.datePicker;
    self.textField.inputAccessoryView = self.actionBar;
    [self.contentView addSubview:self.textField];
    
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
    
    if (self.item.placeholder.length) {
        self.detailTextLabel.text       = self.item.placeholder;
    }
    else {
        self.detailTextLabel.text       = [self.dateFormatter stringFromDate:self.item.value];
    }
    
    self.detailTextLabel.textAlignment  = self.item.text.length ? NSTextAlignmentRight : NSTextAlignmentCenter;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat textLabelX = CGRectGetMinX(self.textLabel.frame);
    if (self.item.text.length) {
        
        CGFloat width           = [self.item.text
                                   sizeWithAttributes:@{ NSFontAttributeName : self.textLabel.font }].width;
        
        CGRect frame            = self.textLabel.frame;
        frame.size.width        = width;
        frame.origin.y          = (CGRectGetHeight(self.contentView.frame) - CGRectGetHeight(self.textLabel.frame)) * 0.5f;
        self.textLabel.frame    = frame;
    }
    
    CGFloat x                   = self.item.text.length ? (CGRectGetMaxX(self.textLabel.frame) + 20.f) : textLabelX;
    CGFloat y                   = CGRectGetMinY(self.textLabel.frame);
    CGFloat w                   = CGRectGetWidth(self.contentView.frame) - x - textLabelX;
    CGFloat h                   = CGRectGetHeight(self.contentView.frame) - 2 * y;
    self.detailTextLabel.frame  = CGRectMake(x, y, w, h);
}

- (void)enableDidChanged:(BOOL)enabled {
    
    [super enableDidChanged:enabled];
    
    self.textLabel.enabled                  = enabled;
    self.detailTextLabel.enabled            = enabled;
    self.datePicker.userInteractionEnabled  = enabled;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected && !self.item.inlineDatePicker) {
        [self.item deselectRowWithAnimated:NO];
        
        if (!self.datePickerDidPresented) {
            [self.textField becomeFirstResponder];
            self.datePickerDidPresented = YES;
        }
        else {
            [self.textField resignFirstResponder];
            self.datePickerDidPresented = NO;
        }
        
        return;
    }
    
    if (selected && self.item.inlineDatePicker) {
        
        [self.item deselectRowWithAnimated:NO];
        
        if (_inlineDatePickerItem) {
            NSIndexPath *indexPath  = _inlineDatePickerItem.indexPath;
            [self.section removeItem:_inlineDatePickerItem];
            
            [self.tableViewManager.tableView
             deleteRowsAtIndexPaths:@[indexPath]
             withRowAnimation:UITableViewRowAnimationFade];
            
            _inlineDatePickerItem   = nil;
        }
        else {
            [self.section insertItem:self.inlineDatePickerItem atIndex:self.item.indexPath.row + 1];
            
            [self.tableViewManager.tableView
             insertRowsAtIndexPaths:@[self.inlineDatePickerItem.indexPath]
             withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    
}


- (GZInlineDatePickerItem *)inlineDatePickerItem {
    
    if (!_inlineDatePickerItem) {
        
        __weak typeof(self) weakself = self;
        _inlineDatePickerItem = [GZInlineDatePickerItem itemWithValue:self.item.value dateFormat:self.item.dateFormat onChange:^(GZInlineDatePickerItem *item) {
            [weakself dateDidChanged:item.value];
        }];
    }
    return _inlineDatePickerItem;
}

#pragma mark - Actions
- (void)datePickerDidChanged:(UIDatePicker *)datePicker {
    
    [self dateDidChanged:datePicker.date];
}

- (void)dateDidChanged:(NSDate *)date {
    
    self.item.value             = date;
    self.detailTextLabel.text   = [self.dateFormatter stringFromDate:self.item.value];
    
    if (self.item.onChange) {
        self.item.onChange(self.item);
    }
}

#pragma mark - UITextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [self.tableViewManager.tableView scrollToRowAtIndexPath:self.item.indexPath
                                           atScrollPosition:UITableViewScrollPositionTop
                                                   animated:YES];
    
    return YES;
}



@end
