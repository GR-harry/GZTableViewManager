//
//  GZTableViewSection.m
//  GZTableViewManager
//
//  Created by GR on 2018/9/23.
//  Copyright © 2018年 Harry. All rights reserved.
//

#import "GZTableViewSection.h"
#import "GZTableViewItem.h"
#import "GZTableViewManager.h"

CGFloat const GZTableViewSectionHeaderHeightAutomatic = MAXFLOAT;
CGFloat const GZTableViewSectionFooterHeightAutomatic = MAXFLOAT;

@interface GZTableViewSection ()

@property (strong, nonatomic) NSMutableArray<GZTableViewItem *> *mutableItems;

@end

@implementation GZTableViewSection

/// Initialize
- (instancetype)init {
    
    if (self = [super init]) {
        self.mutableItems = [NSMutableArray array];
        self.headerHeight = GZTableViewSectionHeaderHeightAutomatic;
        self.footerHeight = GZTableViewSectionFooterHeightAutomatic;
    }
    
    return self;
}

+ (instancetype)section {
    
    return [[self alloc] init];
}

+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle {
    return [[self alloc] initWithHeaderTitle:headerTitle];
}

+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle {
    return [[self alloc] initWithHeaderTitle:headerTitle footerTitle:footerTitle];
}

+ (instancetype)sectionWithHeaderView:(UIView *)headerView {
    return [[self alloc] initWithHeaderView:headerView];
}

+ (instancetype)sectionWithHeaderView:(UIView *)headerView footerView:(UIView *)footerView {
    return [[self alloc] initWithHeaderView:headerView footerView:footerView];
}

- (instancetype)initWithHeaderTitle:(NSString *)headerTitle {
    return [self initWithHeaderTitle:headerTitle footerTitle:nil];
}

- (instancetype)initWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle {
    
    if (self = [self init]) {
        self.headerTitle = headerTitle;
        self.footerTitle = footerTitle;
    }
    return self;
}

- (instancetype)initWithHeaderView:(UIView *)headerView {
    return [self initWithHeaderView:headerView footerView:nil];
}

- (instancetype)initWithHeaderView:(UIView *)headerView footerView:(UIView *)footerView {
    
    if (self = [self init]) {
        self.headerView = headerView;
        self.footerView = footerView;
    }
    return self;
}

- (NSUInteger)index {
    
    return [self.tableViewManager.sections indexOfObject:self];
}

@end

@implementation GZTableViewSection (ManageItems)
- (NSArray<GZTableViewItem *> *)items {
    return self.mutableItems.copy;
}


#pragma mark - Add
- (void)addItem:(GZTableViewItem *)item {
    
    item.section = self;
    
    [self.mutableItems addObject:item];
}

- (void)addItemsFromArray:(NSArray<GZTableViewItem *> *)items {
    
    for (GZTableViewItem *item in items) {
        item.section = self;
    }
    
    [self.mutableItems addObjectsFromArray:items];
}

- (void)insertItem:(GZTableViewItem *)item atIndex:(NSUInteger)index {
    
    item.section = self;
    [self.mutableItems insertObject:item atIndex:index];
}

- (void)insertItems:(NSArray<GZTableViewItem *> *)items atIndexs:(NSIndexSet *)indexs {
    
    for (GZTableViewItem *item in items) {
        item.section = self;
    }
    [self.mutableItems insertObjects:items atIndexes:indexs];
}

#pragma mark - Remove
- (void)removeItem:(GZTableViewItem *)item {
    
    [self.mutableItems removeObject:item];
}

- (void)reomveItem:(GZTableViewItem *)item inRange:(NSRange)range {
    
    [self.mutableItems removeObject:item inRange:range];
}

- (void)removeItemIdenticalTo:(GZTableViewItem *)item {
    
    [self.mutableItems removeObjectIdenticalTo:item];
}

- (void)removeItemIdenticalTo:(GZTableViewItem *)item inRange:(NSRange)range {
    
    [self.mutableItems removeObjectIdenticalTo:item inRange:range];
}

- (void)removeItemAtIndex:(NSUInteger)index {
    
    [self.mutableItems removeObjectAtIndex:index];
}

- (void)removeItemsAtIndexs:(NSIndexSet *)indexs {
    
    [self.mutableItems removeObjectsAtIndexes:indexs];
}

- (void)removeItemsInArray:(NSArray<GZTableViewItem *> *)items {
    
    [self.mutableItems removeObjectsInArray:items];
}

- (void)removeItemsInRange:(NSRange)range {
    
    [self.mutableItems removeObjectsInRange:range];
}

- (void)removeLastItem {
    
    [self.mutableItems removeLastObject];
}

- (void)removeAllItems {
    
    [self.mutableItems removeAllObjects];
}

#pragma mark - Replace
- (void)replaceItemAtIndex:(NSUInteger)index withItem:(GZTableViewItem *)item {
    
    item.section = self;
    [self.mutableItems replaceObjectAtIndex:index withObject:item];
}

- (void)replaceItemsWithItemsFromArray:(NSArray *)otherArray
{
    [self removeAllItems];
    [self addItemsFromArray:otherArray];
}

- (void)replaceItemsInRange:(NSRange)range withItemsFromArray:(NSArray<GZTableViewItem *> *)otherArray range:(NSRange)otherRange {
    
    for (GZTableViewItem *item in otherArray) {
        item.section = self;
    }
    [self.mutableItems replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
}

- (void)replaceItemsInRange:(NSRange)range withItemsFromArray:(NSArray<GZTableViewItem *> *)otherArray {
    for (GZTableViewItem *item in otherArray) {
        item.section = self;
    }
    
    [self.mutableItems replaceObjectsInRange:range withObjectsFromArray:otherArray];
}

- (void)replaceItemsAtIndexes:(NSIndexSet *)indexes withItems:(NSArray<GZTableViewItem *> *)items {
    
    for (GZTableViewItem *item in items) {
        item.section = self;
    }
    [self.mutableItems replaceObjectsAtIndexes:indexes withObjects:items];
}

#pragma mark - Exchange
- (void)exchangeItemAtIndex:(NSUInteger)idx1 withItemAtIndex:(NSUInteger)idx2 {
    
    [self.mutableItems exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
}

#pragma mark - Sort
- (void)sortItemsUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context {
    
    [self.mutableItems sortUsingFunction:compare context:context];
}

- (void)sortItemsUsingSelector:(SEL)comparator {
    
    [self.mutableItems sortUsingSelector:comparator];
}
@end


@implementation GZTableViewSection (Manipulating_Section)

- (void)reloadSectionWithAnimation:(UITableViewRowAnimation)animation {
    
    [self.tableViewManager.tableView reloadSections:[NSIndexSet indexSetWithIndex:self.index] withRowAnimation:animation];
}

- (void)deleteSectionWithAnimation:(UITableViewRowAnimation)animation {
    
    NSInteger sectionIndex = self.index;
    [self.tableViewManager removeSectionAtIndex:sectionIndex];
    
    [self.tableViewManager.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:animation];
}

@end
