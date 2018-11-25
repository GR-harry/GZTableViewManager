//
//  GZInlineDatePickerItem.m
//  GZTableViewManager
//
//  Created by GR on 2018/10/30.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZInlineDatePickerItem.h"

@interface GZInlineDatePickerItem ()

@property (copy, nonatomic) NSString *dateFormat;

@end

@implementation GZInlineDatePickerItem

- (UITableViewCellStyle)cellStyle {
    return UITableViewCellStyleSubtitle;
}

- (instancetype)initWithValue:(NSDate *)value dateFormat:(NSString *)dateFormat onChange:(void (^)(GZInlineDatePickerItem *))onChange {
    
    if (self = [super init]) {
        
        self.datePickerMode = UIDatePickerModeDateAndTime;
        self.value          = value ? : [NSDate date];
        self.dateFormat     = dateFormat;
        self.onChange       = onChange;
        self.height         = 150.f;
    }
    
    return self;
}


+ (instancetype)itemWithValue:(NSDate *)value dateFormat:(NSString *)dateFormat onChange:(void (^)(GZInlineDatePickerItem *))onChange {
    
    return [[self alloc] initWithValue:value dateFormat:dateFormat onChange:onChange];
}

@end

