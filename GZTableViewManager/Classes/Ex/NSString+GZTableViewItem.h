//
//  NSString+GZTableViewItem.h
//  GZTableViewManager
//
//  Created by GR on 2018/10/23.
//  Copyright © 2018 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GZPickerItem.h"

@class GZTableViewItem;
@interface NSString (GZTableViewItem)

@property (readonly) GZTableViewItem *tableViewItem;

@end

@interface NSString (GZPickerItem)<GZPickerItemRow>

@end
