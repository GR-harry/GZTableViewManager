//
//  GZPickerItem.m
//  GZTableViewManager
//
//  Created by GR on 2018/10/28.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZPickerItem.h"

@interface GZPickerItem ()

@property (strong, nonatomic)   NSArray <NSArray *>* options;
@property (copy, nonatomic)     NSString *placeholder;

@end

@implementation GZPickerItem

- (instancetype)initWithText:(NSString *)text
                       value:(NSArray<id<GZPickerItemRow>> *)value
                     options:(NSArray<NSArray *> *)options
                 placeholder:(NSString *)placeholder
      stringWithValueComponentsHandler:(NSString *(^)(NSArray<id<GZPickerItemRow>> *value))valueComponentsHandler
      valueDidChangedHandler:(void (^)(GZPickerItem *))handler {
    
    if (self = [super initWithText:text]) {
        
        self.value                              = value;
        self.options                            = options;
        self.placeholder                        = placeholder;
        self.valueDidChangedHandler             = handler;
        self.stringWithValueComponentsHandler   = valueComponentsHandler;
        self.inlinePicker                       = NO;
    }
    
    return self;
}

- (instancetype)initWithText:(NSString *)text
                       value:(NSArray <id<GZPickerItemRow>>*)value
                     options:(NSArray<NSArray *> *)options
      stringWithValueComponentsHandler:(NSString *(^)(NSArray<id<GZPickerItemRow>> *value))valueComponentsHandler
      valueDidChangedHandler:(void (^)(GZPickerItem *))handler {
    
    NSAssert(options.count, @"options can't be nil");
    NSAssert(value.count == options.count, @"value.count != options.count");
    
    return [self initWithText:text
                        value:value
                      options:options
                  placeholder:nil
       stringWithValueComponentsHandler:valueComponentsHandler
       valueDidChangedHandler:handler];
}

- (instancetype)initWithText:(NSString *)text
                 placeholder:(NSString *)placeholder
                     options:(NSArray<NSArray *> *)options
      stringWithValueComponentsHandler:(NSString *(^)(NSArray<id<GZPickerItemRow>> *value))valueComponentsHandler
      valueDidChangedHandler:(void (^)(GZPickerItem *))handler {
    
    NSMutableArray *value = [NSMutableArray arrayWithCapacity:options.count];
    
    for (NSArray *rowobjs in options) {
        [value addObject:rowobjs.firstObject];
    }
    
    return [self initWithText:text
                        value:value.copy
                      options:options
                  placeholder:placeholder
       stringWithValueComponentsHandler:valueComponentsHandler
       valueDidChangedHandler:handler];
}

+ (instancetype)itemWithText:(NSString *)text
                       value:(NSArray<id<GZPickerItemRow>> *)value
                     options:(NSArray<NSArray *> *)options
      stringWithValueComponentsHandler:(NSString *(^)(NSArray<id<GZPickerItemRow>> *value))valueComponentsHandler
      valueDidChangedHandler:(void (^)(GZPickerItem *))handler {
    
    return [[self alloc] initWithText:text
                                value:value
                              options:options
               stringWithValueComponentsHandler:valueComponentsHandler
               valueDidChangedHandler:handler];
}

+ (instancetype)itemWithText:(NSString *)text
                 placeholder:(NSString *)placeholder
                     options:(NSArray<NSArray *> *)options
      stringWithValueComponentsHandler:(NSString *(^)(NSArray<id<GZPickerItemRow>> *value))valueComponentsHandler
      valueDidChangedHandler:(void (^)(GZPickerItem *))handler {
    
    return [[self alloc] initWithText:text
                          placeholder:placeholder
                              options:options
               stringWithValueComponentsHandler:valueComponentsHandler
               valueDidChangedHandler:handler];
}

- (UITableViewCellStyle)cellStyle {
    return UITableViewCellStyleSubtitle;
}

@end
