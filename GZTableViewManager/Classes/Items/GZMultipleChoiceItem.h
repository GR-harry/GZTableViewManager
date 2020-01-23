//
//  GZMultipleChoiceItem.h
//  GZTableViewManager
//
//  Created by GR Harry on 2020/1/23.
//

#import "GZTableViewItem.h"

@interface GZMultipleChoiceItem : GZTableViewItem

@property (strong, readwrite, nonatomic) NSArray *value;

+ (instancetype)itemWithText:(NSString *)title value:(NSArray *)value selectionHandler:(void(^)(GZMultipleChoiceItem *item))selectionHandler;
- (id)initWithText:(NSString *)title value:(NSArray *)value selectionHandler:(void(^)(GZMultipleChoiceItem *item))selectionHandler;

@end
