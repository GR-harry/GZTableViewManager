//
//  GZNumberItem.m
//  GZTableViewManager
//
//  Created by GR on 2018/10/26.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZNumberItem.h"

@interface GZNumberItem ()


@end

@implementation GZNumberItem

- (NSUInteger)charactersLimit {
    return 0;
}

- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeNumberPad;
}


- (instancetype)initWithText:(NSString *)text value:(NSString *)value format:(NSString *)format placeholder:(NSString *)placeholder {
    
    if (self = [super initWithText:text value:value placeholder:placeholder]) {
        
        self.format = format;
    }
    
    return self;
}

+ (instancetype)itemWithText:(NSString *)text value:(NSString *)value format:(NSString *)format placeholder:(NSString *)placeholder {
    return [[self alloc] initWithText:text value:value format:format placeholder:placeholder];
}

@end
