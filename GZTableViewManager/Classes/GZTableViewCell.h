//
//  GZTableViewCell.h
//  GZTableViewManager
//
//  Created by GR on 2018/9/24.
//  Copyright © 2018年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GZTableViewCellType) {
    GZTableViewCellTypeAny,
    GZTableViewCellTypeSingle,
    GZTableViewCellTypeFirst,
    GZTableViewCellTypeMiddle,
    GZTableViewCellTypeLast
};

@class GZTableViewManager, GZTableViewSection, GZTableViewItem;

@interface GZTableViewCell : UITableViewCell

@property (readonly) BOOL loaded;
@property (readonly) BOOL enabled;

@property (weak, nonatomic) GZTableViewManager  *tableViewManager;
@property (weak, nonatomic) GZTableViewSection  *section;
@property (weak, nonatomic) GZTableViewItem     *item;
@property (readonly) GZTableViewCellType        cellType;

@property (strong, nonatomic) NSIndexPath *indexPath;


@end

@interface GZTableViewCell (Override)

- (void)cellDidLoad;
- (void)cellWillAppear;
- (void)cellDidDisappear;

- (void)enableDidChanged:(BOOL)enabled;

+ (CGFloat)heightWithItem:(GZTableViewItem *)item tableViewManager:(GZTableViewManager *)tableViewManager;
@end

@interface GZTableViewCell (Frame)

- (CGRect)calculateFrameWithMinimumWidth:(CGFloat)minmumWidth;

@end

