//
//  GZTableViewOptionCell.h
//  GZTableViewManager
//
//  Created by GR Harry on 2020/1/23.
//

#import "GZTableViewCell.h"
#import "GZRadioItem.h"

@interface GZTableViewOptionCell : GZTableViewCell

@property (strong, nonatomic) GZRadioItem *item;
@property (readonly) UILabel *valueLabel;

@end


