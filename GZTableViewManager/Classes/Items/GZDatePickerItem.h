//
//  GZDatePickerItem.h
//  GZTableViewManager
//
//  Created by GR on 2018/10/30.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZTableViewItem.h"


@interface GZDatePickerItem : GZTableViewItem

@property (strong, nonatomic) NSDate            *value; // default [NSDate date]

@property (assign, nonatomic) UIDatePickerMode  datePickerMode; // default UIDatePickerModeDateAndTime
@property (strong, nonatomic) NSLocale          *locale;
@property (strong, nonatomic) NSCalendar        *calendar;
@property (strong, nonatomic) NSTimeZone        *timeZone;
@property (strong, nonatomic) NSDate            *minimumDate;
@property (strong, nonatomic) NSDate            *maximumDate;
@property (assign, nonatomic) NSInteger         minuteInterval; // default 1

@property (assign, nonatomic) BOOL              inlineDatePicker;

@property (readonly) NSString *dateFormat;      // default yyyy-MM-dd HH:mm:ss
@property (readonly) NSString *placeholder;

@property (copy, nonatomic) void (^onChange)(GZDatePickerItem *item);

- (instancetype)initWithText:(NSString *)text
                       value:(NSDate *)value
                  dateFormat:(NSString *)dateFormat
                 placeholder:(NSString *)placeholder
                    onChange:(void(^)(GZDatePickerItem *item))onChange;

- (instancetype)initWithText:(NSString *)text
                       value:(NSDate *)value
                 placeholder:(NSString *)placeholder
                    onChange:(void(^)(GZDatePickerItem *item))onChange;

+ (instancetype)itemWithText:(NSString *)text
                       value:(NSDate *)value
                  dateFormat:(NSString *)dateFormat
                 placeholder:(NSString *)placeholder
                    onChange:(void(^)(GZDatePickerItem *item))onChange;

+ (instancetype)itemWithText:(NSString *)text
                       value:(NSDate *)value
                 placeholder:(NSString *)placeholder
                    onChange:(void(^)(GZDatePickerItem *item))onChange;


@end

