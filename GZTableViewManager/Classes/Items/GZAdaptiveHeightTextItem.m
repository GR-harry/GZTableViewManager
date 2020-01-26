//
//  GZAdaptiveHeightItem.m
//  GZTableViewManager
//
//  Created by GR Harry on 2020/1/26.
//

#import "GZAdaptiveHeightTextItem.h"

@implementation GZAdaptiveHeightTextItem

- (CGFloat)height {
    return UITableViewAutomaticDimension;
}

- (UITableViewCellStyle)cellStyle {
    
    UITableViewCellStyle style = [super cellStyle];
    
    switch (style) {
        case UITableViewCellStyleSubtitle:
        case UITableViewCellStyleValue1:
            return style;
        default:
            return UITableViewCellStyleSubtitle;
    }
}

@end
