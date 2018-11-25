//
//  GZInlinPickerItem.m
//  GZTableViewManager
//
//  Created by GR on 2018/10/28.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZInlinePickerItem.h"
#import "GZPickerItem.h"

@interface GZInlinePickerItem ()

@property (strong, nonatomic)   NSArray <NSArray *>* options;

@end

@implementation GZInlinePickerItem

- (instancetype)initWithText:(NSString *)text
                       value:(NSArray<id<GZPickerItemRow>> *)value
                     options:(NSArray<NSArray *> *)options
      valueDidChangedHandler:(void (^)(GZInlinePickerItem *))handler {
    
    if (self = [super initWithText:text]) {
        
        self.value                              = value;
        self.options                            = options;
        self.valueDidChangedHandler             = handler;
        self.height                             = 150.f;
    }
    
    return self;
}

+ (instancetype)itemWithText:(NSString *)text
                       value:(NSArray<id<GZPickerItemRow>> *)value
                     options:(NSArray<NSArray *> *)options
      valueDidChangedHandler:(void (^)(GZInlinePickerItem *))handler {
    
    return [[self alloc] initWithText:text
                                value:value
                              options:options
               valueDidChangedHandler:handler];
}

@end
