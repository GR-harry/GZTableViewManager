//
//  GZTableViewDatePickerCell.h
//  GZTableViewManager
//
//  Created by GR on 2018/10/30.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZTableViewCell.h"


@class GZDatePickerItem;
@interface GZTableViewDatePickerCell : GZTableViewCell

@property (weak, nonatomic) GZDatePickerItem *item;

@end

