//
//  GZFloatItem.m
//  GZTableViewManager
//
//  Created by GR on 2018/10/26.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZFloatItem.h"

@interface GZFloatItem ()

@end

@implementation GZFloatItem

- (instancetype)initWithText:(NSString *)text value:(CGFloat)value valueChangedHandler:(void (^)(GZFloatItem *))handler {
    
    if (self = [super initWithText:text]) {
        
        self.valueRange             = NSMakeRange(0, 1);
        
        self.value                  = value;
        self.valueChangedHandler    = handler;
    }
    
    return self;
}

- (instancetype)initWithText:(NSString *)text value:(CGFloat)value {
    
    return [self initWithText:text value:value valueChangedHandler:nil];
}

+ (instancetype)itemWithText:(NSString *)text value:(CGFloat)value valueChangedHandler:(void (^)(GZFloatItem *))handler {
    
    return [[self alloc] initWithText:text value:value valueChangedHandler:handler];
}

+ (instancetype)itemWithText:(NSString *)text value:(CGFloat)value {
    
    return [self itemWithText:text value:value valueChangedHandler:nil];
}

@end
