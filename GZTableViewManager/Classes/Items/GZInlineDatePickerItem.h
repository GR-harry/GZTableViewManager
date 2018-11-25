//
//  GZInlineDatePickerItem.h
//  GZTableViewManager
//
//  Created by GR on 2018/10/30.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZTableViewItem.h"


@interface GZInlineDatePickerItem : GZTableViewItem

@property (strong, nonatomic) NSDate            *value; // default [NSDate date]

@property (assign, nonatomic) UIDatePickerMode  datePickerMode; // default UIDatePickerModeDateAndTime
@property (strong, nonatomic) NSLocale          *locale;
@property (strong, nonatomic) NSCalendar        *calendar;
@property (strong, nonatomic) NSTimeZone        *timeZone;
@property (strong, nonatomic) NSDate            *minimumDate;
@property (strong, nonatomic) NSDate            *maximumDate;
@property (assign, nonatomic) NSInteger         minuteInterval; // default 1

@property (readonly) NSString *dateFormat;      // default yyyy-MM-dd HH:mm:ss

@property (copy, nonatomic) void (^onChange)(GZInlineDatePickerItem *item);

- (instancetype)initWithValue:(NSDate *)value
                  dateFormat:(NSString *)dateFormat
                    onChange:(void(^)(GZInlineDatePickerItem *item))onChange;

+ (instancetype)itemWithValue:(NSDate *)value
                  dateFormat:(NSString *)dateFormat
                    onChange:(void(^)(GZInlineDatePickerItem *item))onChange;

@end

