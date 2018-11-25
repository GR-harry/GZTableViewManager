//
//  NSString+GZTableViewItem.m
//  GZTableViewManager
//
//  Created by GR on 2018/10/23.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "NSString+GZTableViewItem.h"
#import "GZTableViewItem.h"

@implementation NSString (GZTableViewItem)

- (GZTableViewItem *)tableViewItem {
    GZTableViewItem *item = [GZTableViewItem itemWithText:self];
    return item;
}

@end

@implementation NSString (GZPickerItem)

- (NSString *)title {
    return self;
}

@end
