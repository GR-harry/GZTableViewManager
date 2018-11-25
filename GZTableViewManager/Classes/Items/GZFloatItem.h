//
//  GZFloatItem.h
//  GZTableViewManager
//
//  Created by GR on 2018/10/26.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZTableViewItem.h"


@interface GZFloatItem : GZTableViewItem

@property (assign, nonatomic) CGFloat value;

@property (assign, nonatomic) NSRange valueRange; // default (0, 1)

@property (copy, nonatomic) void (^valueChangedHandler)(GZFloatItem *item);

- (instancetype)initWithText:(NSString *)text value:(CGFloat)value;
- (instancetype)initWithText:(NSString *)text value:(CGFloat)value valueChangedHandler:(void (^)(GZFloatItem *item))handler;

+ (instancetype)itemWithText:(NSString *)text value:(CGFloat)value;
+ (instancetype)itemWithText:(NSString *)text value:(CGFloat)value valueChangedHandler:(void (^)(GZFloatItem *item))handler;

@end

