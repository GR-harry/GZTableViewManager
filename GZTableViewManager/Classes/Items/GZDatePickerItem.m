//
//  GZDatePickerItem.m
//  GZTableViewManager
//
//  Created by GR on 2018/10/30.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZDatePickerItem.h"

@interface GZDatePickerItem ()

@property (copy, nonatomic) NSString *dateFormat;
@property (copy, nonatomic) NSString *placeholder;

@end

@implementation GZDatePickerItem

- (UITableViewCellStyle)cellStyle {
    return UITableViewCellStyleSubtitle;
}

- (instancetype)initWithText:(NSString *)text value:(NSDate *)value dateFormat:(NSString *)dateFormat placeholder:(NSString *)placeholder onChange:(void (^)(GZDatePickerItem *))onChange {
    
    if (self = [super initWithText:text]) {
        
        self.datePickerMode = UIDatePickerModeDateAndTime;
        self.value          = value ? : [NSDate date];
        self.dateFormat     = dateFormat;
        self.placeholder    = placeholder;
        self.onChange       = onChange;
    }
    
    return self;
}

- (instancetype)initWithText:(NSString *)text value:(NSDate *)value placeholder:(NSString *)placeholder onChange:(void (^)(GZDatePickerItem *))onChange {
    
    return [self initWithText:text value:value dateFormat:@"yyyy-MM-dd HH:mm:ss" placeholder:placeholder onChange:onChange];
}

+ (instancetype)itemWithText:(NSString *)text value:(NSDate *)value dateFormat:(NSString *)dateFormat placeholder:(NSString *)placeholder onChange:(void (^)(GZDatePickerItem *))onChange {
    
    return [[self alloc] initWithText:text value:value dateFormat:dateFormat placeholder:placeholder onChange:onChange];
}


+ (instancetype)itemWithText:(NSString *)text value:(NSDate *)value placeholder:(NSString *)placeholder onChange:(void (^)(GZDatePickerItem *))onChange {
    
    return [[self alloc] initWithText:text value:value placeholder:placeholder onChange:onChange];
}
@end
