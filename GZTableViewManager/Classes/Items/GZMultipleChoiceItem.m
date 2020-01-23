//
//  GZMultipleChoiceItem.m
//  GZTableViewManager
//
//  Created by GR Harry on 2020/1/23.
//

#import "GZMultipleChoiceItem.h"
#import "GZTableViewManager.h"

@implementation GZMultipleChoiceItem

+ (instancetype)itemWithText:(NSString *)title value:(NSArray *)value selectionHandler:(void(^)(GZMultipleChoiceItem *item))selectionHandler
{
    return [[self alloc] initWithText:title value:value selectionHandler:selectionHandler];
}

- (id)initWithText:(NSString *)title value:(NSArray *)value selectionHandler:(void(^)(GZMultipleChoiceItem *item))selectionHandler
{
    self = [super init];
    if (!self)
        return nil;
    
    self.text               = title;
    self.accessorType       = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionHandler   = ^(GZTableViewItem *item) {
        [item.section.tableViewManager.tableView endEditing:YES];
        if (selectionHandler)
            selectionHandler((GZMultipleChoiceItem *)item);
    };
    self.value      = value;
    self.cellStyle  = UITableViewCellStyleValue1;
    
    return self;
}

- (void)setValue:(NSArray *)value
{
    _value = value;
    
    if (value.count == 0) {
        self.detailText = @"";
    }
    else if (value.count == 1) {
        self.detailText = value[0];
    }
    else {
        self.detailText = [NSString stringWithFormat:@"%d selected", (int)value.count];
    }
}

@end
