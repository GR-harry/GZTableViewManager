//
//  GZTableViewInlineDatePickerCell.h
//  GZTableViewManager
//
//  Created by GR on 2018/10/30.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZTableViewCell.h"

@class GZInlineDatePickerItem;
@interface GZTableViewInlineDatePickerCell : GZTableViewCell

@property (weak, nonatomic) GZInlineDatePickerItem *item;

@end
