//
//  GZTableViewPickerCell.h
//  GZTableViewManager
//
//  Created by GR on 2018/10/28.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZTableViewCell.h"

@class GZPickerItem;

@interface GZTableViewPickerCell : GZTableViewCell

@property (strong, nonatomic) GZPickerItem *item;

@end
