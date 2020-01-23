//
//  GZRadioItem.h
//  GZTableViewManager
//
//  Created by GR Harry on 2020/1/23.
//

#import "GZTableViewItem.h"


@interface GZRadioItem : GZTableViewItem

@property (copy, readwrite, nonatomic) NSString *value;

+ (instancetype)itemWithText:(NSString *)text value:(NSString *)value selectionHandler:(void(^)(GZRadioItem *item))selectionHandler;
- (id)initWithText:(NSString *)text value:(NSString *)value selectionHandler:(void(^)(GZRadioItem *item))selectionHandler;

@end

