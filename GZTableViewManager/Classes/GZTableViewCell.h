//
//  GZTableViewCell.h
//  GZTableViewManager
//
//  Created by GR on 2018/9/24.
//  Copyright © 2018年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZActionBar.h"

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

/**
 修饰item, 必须用strong，不能用weak。
 
 因为item上增加了当前cell作为监听器，用weak的话会导致，item先被释放，但是item上的监听器(当前cell并没有被释放)，会导致崩溃。所以，必须用strong，当cell被释放时，item才会被释放。这样就合理了。
 
 这个问题好像会在iOS10系统上表现出来。iOS12没有此问题。
 */
@property (strong, nonatomic) GZTableViewItem     *item;
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

@interface GZTableViewCell (ActionBar)

@property (readonly) GZActionBar *actionBar;

@end
