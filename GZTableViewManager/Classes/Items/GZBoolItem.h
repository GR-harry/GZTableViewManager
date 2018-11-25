//
//  GZBoolItem.h
//  GZTableViewManager
//
//  Created by GR on 2018/10/24.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZTableViewItem.h"

@interface GZBoolItem : GZTableViewItem

@property (assign, nonatomic, getter=isOn) BOOL on;

@property (copy, nonatomic) void (^swithValueChangedHandler)(GZBoolItem *item);

- (instancetype)initWithText:(NSString *)text on:(BOOL)on;
- (instancetype)initWithText:(NSString *)text on:(BOOL)on swithValueChangedHandler:(void(^)(GZBoolItem *item))handler;

+ (instancetype)itemWithText:(NSString *)text on:(BOOL)on;
+ (instancetype)itemWithText:(NSString *)text on:(BOOL)on swithValueChangedHandler:(void(^)(GZBoolItem *item))handler;

@end
