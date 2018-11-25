//
//  GZTableViewTextCell.h
//  GZTableViewManager
//
//  Created by GR on 2018/10/23.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZTableViewCell.h"

@class GZTextItem;
@interface GZTableViewTextCell : GZTableViewCell

@property (weak, nonatomic) GZTextItem *item;

@end
