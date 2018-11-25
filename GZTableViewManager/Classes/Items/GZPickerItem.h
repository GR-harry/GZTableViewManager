//
//  GZPickerItem.h
//  GZTableViewManager
//
//  Created by GR on 2018/10/28.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZTableViewItem.h"
#import "NSString+GZTableViewItem.h"

@protocol GZPickerItemRow <NSObject>

@property (readonly) NSString *title;

@end

@interface GZPickerItem : GZTableViewItem

@property (strong, nonatomic)   NSArray <id<GZPickerItemRow>> *value;
@property (readonly)            NSArray <NSArray *>* options;
@property (readonly)            NSString *placeholder;

@property (assign, nonatomic)   BOOL inlinePicker;

@property (copy, nonatomic)     void (^valueDidChangedHandler)(GZPickerItem *item);
@property (copy, nonatomic)     NSString * (^stringWithValueComponentsHandler)(NSArray<id<GZPickerItemRow>> *value);

- (instancetype)initWithText:(NSString *)text
                       value:(NSArray <id<GZPickerItemRow>> *)value
                     options:(NSArray <NSArray *>*)options
      stringWithValueComponentsHandler:(NSString *(^)(NSArray<id<GZPickerItemRow>> *value))valueComponentsHandler
      valueDidChangedHandler:(void (^)(GZPickerItem *item))handler;

- (instancetype)initWithText:(NSString *)text
                 placeholder:(NSString *)placeholder
                     options:(NSArray <NSArray *>*)options
    stringWithValueComponentsHandler:(NSString *(^)(NSArray<id<GZPickerItemRow>> *value))valueComponentsHandler
      valueDidChangedHandler:(void (^)(GZPickerItem *item))handler;

+ (instancetype)itemWithText:(NSString *)text
                       value:(NSArray <id<GZPickerItemRow>> *)value
                     options:(NSArray <NSArray *>*)options
      stringWithValueComponentsHandler:(NSString *(^)(NSArray <id<GZPickerItemRow>> *value))valueComponentsHandler
      valueDidChangedHandler:(void (^)(GZPickerItem *item))handler;

+ (instancetype)itemWithText:(NSString *)text
                 placeholder:(NSString *)placeholder
                     options:(NSArray <NSArray *>*)options
      stringWithValueComponentsHandler:(NSString *(^)(NSArray <id<GZPickerItemRow>> *value))valueComponentsHandler
      valueDidChangedHandler:(void (^)(GZPickerItem *item))handler;

@end

