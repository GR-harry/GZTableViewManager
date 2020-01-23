//
//  GZRadioItem.m
//  GZTableViewManager
//
//  Created by GR Harry on 2020/1/23.
//

#import "GZRadioItem.h"
#import "GZTableViewManager.h"

@implementation GZRadioItem

+ (instancetype)itemWithText:(NSString *)text value:(NSString *)value selectionHandler:(void(^)(GZRadioItem *item))selectionHandler
{
    return [[self alloc] initWithText:text value:value selectionHandler:selectionHandler];
}

- (id)initWithText:(NSString *)text value:(NSString *)value selectionHandler:(void(^)(GZRadioItem *item))selectionHandler
{
    self = [super init];
    if (!self)
        return nil;
    
    self.text               = text;
    self.accessorType       = UITableViewCellAccessoryDisclosureIndicator;
    self.value              = value;
    self.cellStyle          = UITableViewCellStyleValue1;
    self.selectionHandler   = ^(GZTableViewItem *item) {
        [item.section.tableViewManager.tableView endEditing:YES];
        if (selectionHandler)
            selectionHandler((GZRadioItem *)item);
    };
    
    return self;
}

- (void)setValue:(NSString *)value
{
    _value = value;
    self.detailText = value;
}

@end
