//
//  GZOptionItem.m
//  GZTableViewManager
//
//  Created by GR Harry on 2020/1/23.
//

#import "GZOptionItem.h"
#import "GZTableViewManager.h"

@implementation GZOptionItem

+ (instancetype)itemWithText:(NSString *)text value:(id)value selectionHandler:(void(^)(GZOptionItem *item))selectionHandler
{
    return [[self alloc] initWithText:text value:value selectionHandler:selectionHandler];
}

- (id)initWithText:(NSString *)text value:(id)value selectionHandler:(void(^)(GZOptionItem *item))selectionHandler
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
            selectionHandler((GZOptionItem *)item);
    };
    
    return self;
}

- (void)setValue:(id)value
{
    _value = value;
    
    if ([value isKindOfClass:[NSString class]]) {
        self.detailText = value;
        return;
    }
    
    if ([value isKindOfClass:[NSArray class]]) {
        
        NSArray *array = (NSArray *)value;
        
        if (array.count == 0) {
           self.detailText = @"";
        }
        else if (array.count == 1) {
           self.detailText = array[0];
        }
        else {
           self.detailText = [NSString stringWithFormat:@"%d selected", (int)array.count];
        }
        
        return;
    }
}

@end
