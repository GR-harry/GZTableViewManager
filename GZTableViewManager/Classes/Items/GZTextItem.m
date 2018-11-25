//
//  GZTableViewTextItem.m
//  GZTableViewManager
//
//  Created by GR on 2018/10/23.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZTextItem.h"

@implementation GZTextItem

- (instancetype)initWithText:(NSString *)text value:(NSString *)value placeholder:(NSString *)placeholder {
    
    if (self = [super init]) {
        self.text           = text;
        self.value          = value;
        self.placeholder    = placeholder;
        
        self.valueFont      = [UIFont systemFontOfSize:16];
        self.valueColor     = [UIColor blackColor];
    }
    
    return self;
}

- (instancetype)initWithText:(NSString *)text value:(NSString *)value {
    return [self initWithText:text value:value placeholder:nil];
}

+ (instancetype)itemWithText:(NSString *)text value:(NSString *)value {
    return [[self alloc] initWithText:text value:value];
}

+ (instancetype)itemWithText:(NSString *)text value:(NSString *)value placeholder:(NSString *)placeholder {
    return [[self alloc] initWithText:text value:value placeholder:placeholder];
}

@end
