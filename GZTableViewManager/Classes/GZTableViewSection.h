//
//  GZTableViewSection.h
//  GZTableViewManager
//
//  Created by GR on 2018/9/23.
//  Copyright © 2018年 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GZTableViewManager, GZTableViewItem;

extern CGFloat const GZTableViewSectionHeaderHeightAutomatic;
extern CGFloat const GZTableViewSectionFooterHeightAutomatic;

@interface GZTableViewSection : NSObject

@property (weak, nonatomic) GZTableViewManager *tableViewManager;
@property (readonly) NSUInteger index;

@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSString *footerTitle;
@property (nonatomic, copy) NSString *indexTitle;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat footerHeight;
@property (nonatomic, assign) CGFloat estimatedHeaderHeight;
@property (nonatomic, assign) CGFloat estimatedFooterHeight;



+ (instancetype)section;
+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle;
+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;
+ (instancetype)sectionWithHeaderView:(UIView *)headerView;
+ (instancetype)sectionWithHeaderView:(UIView *)headerView footerView:(UIView *)footerView;

- (instancetype)initWithHeaderTitle:(NSString *)headerTitle;
- (instancetype)initWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;
- (instancetype)initWithHeaderView:(UIView *)headerView;
- (instancetype)initWithHeaderView:(UIView *)headerView footerView:(UIView *)footerView;


@end


@interface GZTableViewSection (ManageItems)
@property (strong, nonatomic, readonly) NSArray<GZTableViewItem *> *items;

- (void)addItem:(GZTableViewItem *)item;
- (void)addItemsFromArray:(NSArray<GZTableViewItem *>*)items;
- (void)insertItem:(GZTableViewItem *)item atIndex:(NSUInteger)index;
- (void)insertItems:(NSArray<GZTableViewItem *> *)items atIndexs:(NSIndexSet *)indexs;

- (void)removeItem:(GZTableViewItem *)item;
- (void)reomveItem:(GZTableViewItem *)item inRange:(NSRange)range;
- (void)removeItemIdenticalTo:(GZTableViewItem *)item;
- (void)removeItemIdenticalTo:(GZTableViewItem *)item inRange:(NSRange)range;
- (void)removeItemAtIndex:(NSUInteger)index;
- (void)removeItemsAtIndexs:(NSIndexSet *)indexs;
- (void)removeItemsInArray:(NSArray<GZTableViewItem *>*)items;
- (void)removeItemsInRange:(NSRange)range;
- (void)removeLastItem;
- (void)removeAllItems;

- (void)replaceItemAtIndex:(NSUInteger)index withItem:(GZTableViewItem *)item;
- (void)replaceItemsWithItemsFromArray:(NSArray<GZTableViewItem *> *)otherArray;
- (void)replaceItemsAtIndexes:(NSIndexSet *)indexes withItems:(NSArray<GZTableViewItem *> *)items;
- (void)replaceItemsInRange:(NSRange)range withItemsFromArray:(NSArray<GZTableViewItem *> *)otherArray range:(NSRange)otherRange;
- (void)replaceItemsInRange:(NSRange)range withItemsFromArray:(NSArray<GZTableViewItem *> *)otherArray;

- (void)exchangeItemAtIndex:(NSUInteger)idx1 withItemAtIndex:(NSUInteger)idx2;

- (void)sortItemsUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context;
- (void)sortItemsUsingSelector:(SEL)comparator;
@end


@interface GZTableViewSection (Manipulating_Section)

- (void)reloadSectionWithAnimation:(UITableViewRowAnimation)animation;
- (void)deleteSectionWithAnimation:(UITableViewRowAnimation)animation;

@end
