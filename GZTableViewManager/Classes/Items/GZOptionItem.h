//
//  GZOptionItem.h
//  GZTableViewManager
//
//  Created by GR Harry on 2020/1/23.
//

#import "GZTableViewItem.h"


@interface GZOptionItem<T> : GZTableViewItem

@property (copy, nonatomic) T value;

+ (instancetype)itemWithText:(NSString *)text value:(T)value selectionHandler:(void(^)(GZOptionItem *item))selectionHandler;
- (id)initWithText:(NSString *)text value:(T)value selectionHandler:(void(^)(GZOptionItem *item))selectionHandler;

@end

