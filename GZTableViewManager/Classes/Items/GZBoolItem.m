//
//  GZBoolItem.m
//  GZTableViewManager
//
//  Created by GR on 2018/10/24.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZBoolItem.h"

@interface GZBoolItem ()

@end

@implementation GZBoolItem

- (instancetype)initWithText:(NSString *)text on:(BOOL)on swithValueChangedHandler:(void (^)(GZBoolItem *item))handler {
    
    if (self = [super initWithText:text]) {
     
        self.on                         = on;
        self.swithValueChangedHandler   = handler;
    }
    
    return self;
}

- (instancetype)initWithText:(NSString *)text on:(BOOL)on {
    
    return [self initWithText:text on:on swithValueChangedHandler:nil];
}

+ (instancetype)itemWithText:(NSString *)text on:(BOOL)on {
    return [[self alloc] initWithText:text on:on];
}

+ (instancetype)itemWithText:(NSString *)text on:(BOOL)on swithValueChangedHandler:(void (^)(GZBoolItem *item))handler {
    return [[self alloc] initWithText:text on:on swithValueChangedHandler:handler];
}

@end
