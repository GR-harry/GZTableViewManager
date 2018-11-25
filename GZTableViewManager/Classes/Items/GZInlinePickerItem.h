//
//  GZInlinPickerItem.h
//  GZTableViewManager
//
//  Created by GR on 2018/10/28.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZTableViewItem.h"

@protocol GZPickerItemRow;
@interface GZInlinePickerItem : GZTableViewItem

@property (strong, nonatomic)   NSArray <id<GZPickerItemRow>> *value;
@property (readonly)            NSArray <NSArray *>* options;


@property (copy, nonatomic)     void (^valueDidChangedHandler)(GZInlinePickerItem *item);

- (instancetype)initWithText:(NSString *)text
                       value:(NSArray <id<GZPickerItemRow>> *)value
                     options:(NSArray <NSArray *>*)options
      valueDidChangedHandler:(void (^)(GZInlinePickerItem *item))handler;

+ (instancetype)itemWithText:(NSString *)text
                       value:(NSArray <id<GZPickerItemRow>> *)value
                     options:(NSArray <NSArray *>*)options
      valueDidChangedHandler:(void (^)(GZInlinePickerItem *item))handler;


@end
