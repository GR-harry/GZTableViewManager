//
//  GZTableViewManager.m
//  GZTableViewManager
//
//  Created by GR on 2018/9/23.
//  Copyright © 2018年 Harry. All rights reserved.
//

#import "GZTableViewManager.h"

#import <objc/runtime.h>

#import "GZTableViewSection.h"
#import "GZTableViewItem.h"
#import "GZTableViewCell.h"

#import "GZTextItem.h"
#import "GZTableViewTextCell.h"

#import "GZBoolItem.h"
#import "GZTableviewBoolCell.h"

#import "GZFloatItem.h"
#import "GZTableViewFloatCell.h"

#import "GZNumberItem.h"
#import "GZTableViewNumberCell.h"

#import "GZLongTextItem.h"
#import "GZTableViewLongTextCell.h"

#import "GZPickerItem.h"
#import "GZTableViewPickerCell.h"

#import "GZInlinePickerItem.h"
#import "GZTableViewInlinePickerCell.h"

#import "GZDatePickerItem.h"
#import "GZTableViewDatePickerCell.h"

#import "GZInlineDatePickerItem.h"
#import "GZTableViewInlineDatePickerCell.h"

@interface GZTableViewManager ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) id<GZTableViewManagerDelegate> delegate;
@property (weak, nonatomic) UITableView *tableView;

// key: ItemClass, value: CellClass
@property (strong, nonatomic) NSMutableDictionary<id, Class> *registeredClasses;
@property (strong, nonatomic) NSMutableArray *mutableSections;
@end

@implementation GZTableViewManager

- (instancetype)initWithTableView:(UITableView *)tableView delegate:(id<GZTableViewManagerDelegate>)delegate {
    if (self = [self initWithTableView:tableView]) {
        self.delegate = delegate;
    }

    return self;
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    
    if (self = [super init]) {
        tableView.delegate = self;
        tableView.dataSource = self;

        self.tableView = tableView;
        self.mutableSections = [NSMutableArray array];
        self.registeredClasses = [NSMutableDictionary dictionary];
        
        [self registerDefaultItem];
    }

    return self;
}

- (Class)objectAtKeyedSubscript:(id<NSCopying>)key {
    return self.registeredClasses[key];
}

- (void)setObject:(NSString *)obj forKeyedSubscript:(NSString *)key {
    
    NSAssert(NSClassFromString(key), ([NSString stringWithFormat:@"Item class %@ does not exsits", key]));
    NSAssert(NSClassFromString(obj), ([NSString stringWithFormat:@"Cell class %@ does not exsits", obj]));

    Class itemClass = NSClassFromString(key);
    Class cellClass = NSClassFromString(obj);
    self.registeredClasses[(id<NSCopying>)itemClass] = cellClass;
}

- (Class)cellForClassAtIndexPath:(NSIndexPath *)indexPath
{
    GZTableViewSection *section = self.mutableSections[indexPath.section];
    GZTableViewItem *item = section.items[indexPath.row];

    return self.registeredClasses[item.class];
}

- (void)registerDefaultItem {
    self[NSStringFromClass(GZTableViewItem.class)]          = NSStringFromClass(GZTableViewCell.class);
    self[NSStringFromClass(GZTextItem.class)]               = NSStringFromClass(GZTableViewTextCell.class);
    self[NSStringFromClass(GZBoolItem.class)]               = NSStringFromClass(GZTableViewBoolCell.class);
    self[NSStringFromClass(GZFloatItem.class)]              = NSStringFromClass(GZTableViewFloatCell.class);
    self[NSStringFromClass(GZNumberItem.class)]             = NSStringFromClass(GZTableViewNumberCell.class);
    self[NSStringFromClass(GZLongTextItem.class)]           = NSStringFromClass(GZTableViewLongTextCell.class);
    self[NSStringFromClass(GZPickerItem.class)]             = NSStringFromClass(GZTableViewPickerCell.class);
    self[NSStringFromClass(GZInlinePickerItem.class)]       = NSStringFromClass(GZTableViewInlinePickerCell.class);
    self[NSStringFromClass(GZDatePickerItem.class)]         = NSStringFromClass(GZTableViewDatePickerCell.class);
    self[NSStringFromClass(GZInlineDatePickerItem.class)]   = NSStringFromClass(GZTableViewInlineDatePickerCell.class);
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.mutableSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if (sectionIndex >= self.mutableSections.count) {
        return 0;
    }

    GZTableViewSection *section = self.mutableSections[sectionIndex];
    return section.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section >= self.mutableSections.count) {
        NSAssert(NO, @"sectionIndex great than or equal to mutableSections.count");
        return nil;
    }

    GZTableViewSection *section = self.mutableSections[indexPath.section];

    if (indexPath.row >= section.items.count) {
        NSAssert(NO, @"rowIndex great than or equal to section.items.count");
        return nil;
    }

    GZTableViewItem *item = section.items[indexPath.row];

    UITableViewCellStyle style = item.cellStyle;

    Class cellCalss = [self cellForClassAtIndexPath:indexPath];
    NSString *cellIdentifer = item.cellIdentifier;

    if (!cellIdentifer.length) {
        cellIdentifer = [NSString stringWithFormat:@"GZTableViewManager_%@_%zd", cellCalss, style];
    }

    GZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];

    void (^ loadCell)(GZTableViewCell *cell) = ^(GZTableViewCell *cell) {
        cell.tableViewManager = self;

        [cell cellDidLoad];
    };

    if (!cell) {
        cell = [[cellCalss alloc] initWithStyle:style reuseIdentifier:cellIdentifer];

        NSAssert([cell isKindOfClass:[GZTableViewCell class]], @"cell is not a GZTableViewCell subclass");
        if (![cell isKindOfClass:[GZTableViewCell class]]) {
            return nil;
        }

        loadCell(cell);
    }

    if (!cell.loaded) {
        loadCell(cell);
    }

    cell.tableViewManager   = self;
    cell.section            = section;
    cell.item               = item;
    cell.indexPath          = indexPath;

    cell.textLabel.text = item.text.length ? item.text : nil;
    cell.detailTextLabel.text = item.detailText.length ? item.detailText : nil;

    [cell cellWillAppear];

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex >= self.mutableSections.count) {
        NSAssert(NO, @"sectionIndex grate than or queal to mtableSections.cout");
        return nil;
    }

    GZTableViewSection *section = self.mutableSections[sectionIndex];
    return section.headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)sectionIndex
{
    if (sectionIndex >= self.mutableSections.count) {
        NSAssert(NO, @"sectionIndex grate than or queal to mtableSections.cout");
        return nil;
    }

    GZTableViewSection *section = self.mutableSections[sectionIndex];
    return section.footerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex >= self.mutableSections.count) {
        NSAssert(NO, @"sectionIndex grate than or queal to mtableSections.cout");
        return nil;
    }

    GZTableViewSection *section = self.mutableSections[sectionIndex];
    return section.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)sectionIndex
{
    if (sectionIndex >= self.mutableSections.count) {
        NSAssert(NO, @"sectionIndex grate than or queal to mtableSections.cout");
        return nil;
    }
    GZTableViewSection *section = self.mutableSections[sectionIndex];
    return section.footerTitle;
}

#pragma mark - UITableViewDelegate
// Variable height support
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZTableViewSection *section = self.mutableSections[indexPath.section];
    GZTableViewItem *item = section.items[indexPath.row];

    if (item.height == UITableViewAutomaticDimension) {
        return UITableViewAutomaticDimension;
    } 

    return [[self cellForClassAtIndexPath:indexPath] heightWithItem:item tableViewManager:self];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZTableViewSection *section = self.mutableSections[indexPath.section];
    GZTableViewItem *item = section.items[indexPath.row];

    return [[self cellForClassAtIndexPath:indexPath] heightWithItem:item tableViewManager:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex >= self.mutableSections.count) {
        NSAssert(NO, @"sectionIndex grate than or queal to mtableSections.cout");
        return 0.01f;
    }

    GZTableViewSection *section = self.mutableSections[sectionIndex];

    if (section.headerHeight != GZTableViewSectionHeaderHeightAutomatic) {
        return section.headerHeight;
    }
    
    if (section.headerView) {
        CGFloat height = section.headerView.frame.size.height;
        return height ? : UITableViewAutomaticDimension;
    }
    else if (section.headerTitle.length) {
        CGFloat headerWidth = CGRectGetWidth(tableView.frame) - 2 * 20;

        CGSize size = [section.headerTitle
                       boundingRectWithSize:CGSizeMake(headerWidth, GZTableViewSectionHeaderHeightAutomatic)
                                    options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                 attributes:@{ NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline] }
                                    context:nil].size;
        return size.height + 20;
    }

    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex >= self.mutableSections.count) {
        NSAssert(NO, @"sectionIndex grate than or queal to mtableSections.cout");
        return UITableViewAutomaticDimension;
    }

    GZTableViewSection *section = self.mutableSections[sectionIndex];
    // estimatedHeaderHeight = 0时，不会调用tableView:heightForHeaderInSection:，所以需要设置默认值
    return section.estimatedHeaderHeight ? : 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)sectionIndex
{
    if (sectionIndex >= self.mutableSections.count) {
        NSAssert(NO, @"sectionIndex grate than or queal to mtableSections.cout");
        return 0.01f;
    }

    GZTableViewSection *section = self.mutableSections[sectionIndex];

    if (section.footerHeight != GZTableViewSectionFooterHeightAutomatic) {
        return section.footerHeight;
    }

    if (section.footerView) {
        CGFloat height = section.footerView.frame.size.height;
        return height ? : UITableViewAutomaticDimension;
    }

    if (section.footerTitle.length) {
        CGFloat headerWidth = CGRectGetWidth(tableView.frame) - 2 * 20;

        CGSize size = [section.footerTitle
                       boundingRectWithSize:CGSizeMake(headerWidth, GZTableViewSectionFooterHeightAutomatic)
                                    options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                 attributes:@{ NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline] }
                                    context:nil].size;
        return size.height + 20;
    }

    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)sectionIndex {
    if (sectionIndex >= self.mutableSections.count) {
        NSAssert(NO, @"sectionIndex grate than or queal to mtableSections.cout");
        return UITableViewAutomaticDimension;
    }

    GZTableViewSection *section = self.mutableSections[sectionIndex];
    // estimatedHeaderHeight = 0时，不会调用tableView:heightForHeaderInSection:，所以需要设置默认值
    return section.estimatedFooterHeight ? : 44.f;
}

// Display customization

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(GZTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert([cell isKindOfClass:GZTableViewCell.class], @"cell is not a GZTableViewCell subclass");

    [cell cellDidDisappear];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
{
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSParameterAssert(indexPath.section < self.mutableSections.count);
    if (indexPath.section >= self.mutableSections.count) {
        NSLog(@"sectionIndex grate than or queal to mtableSections.cout");
        return;
    }
    
    GZTableViewSection *section = self.sections[indexPath.section];
    
    NSParameterAssert(indexPath.row < section.items.count);
    if (indexPath.row >= section.items.count) {
        NSLog(@"rowIndex grate than or queal to section.item.count");
        return;
    }
    
    GZTableViewItem *item = section.items[indexPath.row];
    
    if (item.selectionHandler) {
        item.selectionHandler(item);
    }
}


// Editing
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSParameterAssert(indexPath.section < self.mutableSections.count);
    
    if (indexPath.section >= self.mutableSections.count) {
        return NO;
    }
    
    GZTableViewSection *section = self.mutableSections[indexPath.section];
    
    NSParameterAssert(indexPath.row < section.items.count);
    
    if (indexPath.row >= section.items.count) {
        return NO;
    }
    
    GZTableViewItem *item       = section.items[indexPath.row];
    
    BOOL canEidt =
    item.editingStyle != UITableViewCellEditingStyleNone ||
    item.moveHandler ||
    item.deleteHandler || item.deleteWithOperateHandler ||
    item.insertWithOperateHandler;
    return canEidt;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSParameterAssert(indexPath.section < self.mutableSections.count);
    
    if (indexPath.section >= self.mutableSections.count) {
        return NO;
    }
    
    GZTableViewSection *section = self.mutableSections[indexPath.section];
    
    NSParameterAssert(indexPath.row < section.items.count);
    
    if (indexPath.row >= section.items.count) {
        return NO;
    }
    
    GZTableViewItem *item       = section.items[indexPath.row];
    
    if (item.deleteHandler || item.deleteWithOperateHandler) {
        return UITableViewCellEditingStyleDelete;
    }
    else if (item.insertWithOperateHandler) {
        return UITableViewCellEditingStyleInsert;
    }
    
    return item.editingStyle;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSParameterAssert(indexPath.section < self.mutableSections.count);
    
    if (indexPath.section >= self.mutableSections.count) {
        return NO;
    }
    
    GZTableViewSection *section = self.mutableSections[indexPath.section];
    
    NSParameterAssert(indexPath.row < section.items.count);
    
    if (indexPath.row >= section.items.count) {
        return NO;
    }
    
    GZTableViewItem *item       = section.items[indexPath.row];
    
    return item.shouldIndentWhileEditing;
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert(indexPath.section < self.mutableSections.count);
    
    if (indexPath.section >= self.mutableSections.count) {
        return NO;
    }
    
    GZTableViewSection *section = self.mutableSections[indexPath.section];
    
    NSParameterAssert(indexPath.row < section.items.count);
    
    if (indexPath.row >= section.items.count) {
        return NO;
    }
    
    GZTableViewItem *item       = section.items[indexPath.row];
    
    return item.moveHandler ? YES : NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert(indexPath.section < self.mutableSections.count);
    
    if (indexPath.section >= self.mutableSections.count) {
        return;
    }
    
    GZTableViewSection *section = self.mutableSections[indexPath.section];
    
    NSParameterAssert(indexPath.row < section.items.count);
    
    if (indexPath.row >= section.items.count) {
        return;
    }
    
    GZTableViewItem *item = section.items[indexPath.row];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        __weak typeof(self) weakself = self;
        void (^deleteBlock)(NSIndexPath *) = ^(NSIndexPath *indexPath) {
            // 删除
            [section removeItemAtIndex:indexPath.row];
            [weakself.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
            
            // 修改 cell 位序
            for (NSInteger i = indexPath.row; i < section.items.count; i++) {
                
                GZTableViewCell *cell = [weakself.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section.index]];
                cell.indexPath        = [NSIndexPath indexPathForRow:i inSection:section.index];
            }
        };
        
        if (item.deleteWithOperateHandler) {
            
            item.deleteWithOperateHandler(item, ^{
                
                deleteBlock(indexPath);
            });
            
            return;
        }
        
        
        if (item.deleteHandler) {
            
            item.deleteHandler(item);
        }
        
        deleteBlock(indexPath);
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        if (item.insertWithOperateHandler) {
            NSArray *insertItems = item.insertWithOperateHandler(item);
            
            for (int index = 0; index < insertItems.count; index++) {
                
                GZTableViewItem *insertItem = insertItems[index];
                
                [section insertItem:insertItem atIndex:indexPath.row + index + 1];
                [self.tableView insertRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:indexPath.row + index + 1 inSection:indexPath.section] ]
                                      withRowAnimation:UITableViewRowAnimationMiddle];
                
                for (NSInteger i = indexPath.row + index + 1; i < section.items.count; i++) {
                    GZTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section.index]];
                    cell.indexPath        = [NSIndexPath indexPathForRow:i inSection:section.index];
                }
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    NSParameterAssert(sourceIndexPath.section < self.mutableSections.count &&
                      destinationIndexPath.section < self.mutableSections.count);
    
    if (sourceIndexPath.section >= self.mutableSections.count ||
        destinationIndexPath.section >= self.mutableSections.count) {
        return;
    }
    
    GZTableViewSection *sourceSection       = self.mutableSections[sourceIndexPath.section];
    GZTableViewSection *destinateSection    = self.mutableSections[destinationIndexPath.section];
    
    NSParameterAssert(sourceIndexPath.row < sourceSection.items.count &&
                      destinationIndexPath.row < destinateSection.items.count);
    
    if (sourceIndexPath.row >= sourceSection.items.count ||
        destinationIndexPath.row >= destinateSection.items.count) {
        return;
    }
    
    GZTableViewItem *sourceItem     = sourceSection.items[sourceIndexPath.row];
    
    [sourceSection removeItem:sourceItem];
    [destinateSection insertItem:sourceItem atIndex:destinationIndexPath.row];
    
    
    // 修改位序
    for (NSInteger i = sourceIndexPath.row + 1; i < sourceSection.items.count; i++) {

        GZTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:sourceSection.index]];
        cell.indexPath        = [NSIndexPath indexPathForRow:i - 1 inSection:sourceSection.index];
    }

    
    // 修改位序
    for (NSInteger i = destinationIndexPath.row + 1; i < destinateSection.items.count; i++) {
        GZTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:destinateSection.index]];
        cell.indexPath        = [NSIndexPath indexPathForRow:i inSection:destinateSection.index];
    }
    
    GZTableViewCell *sourceCell = [self.tableView cellForRowAtIndexPath:sourceIndexPath];
    sourceCell.indexPath        = destinationIndexPath;
    
    if (sourceItem.moveHandler) {
        sourceItem.moveHandler(sourceItem, sourceIndexPath, destinationIndexPath);
    }
}

// Accessories (disclosures).

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    NSParameterAssert(indexPath.section < self.mutableSections.count);
    if (indexPath.section >= self.mutableSections.count) {
        NSLog(@"sectionIndex grate than or queal to mtableSections.cout");
        return;
    }
    
    GZTableViewSection *section = self.sections[indexPath.section];
    
    NSParameterAssert(indexPath.row < section.items.count);
    if (indexPath.row >= section.items.count) {
        NSLog(@"rowIndex grate than or queal to section.item.count");
        return;
    }
    
    GZTableViewItem *item = section.items[indexPath.row];
    
    if (item.accessoryButtonTapHandler) {
        item.accessoryButtonTapHandler(item);
    }
}

@end

@implementation GZTableViewManager (Editing)

- (void)setEditing:(BOOL)editing {
    
    self.tableView.editing = editing;
}

- (BOOL)editing {
    return self.tableView.isEditing;
}

@end

@implementation GZTableViewManager (ManageSections)

- (NSArray<GZTableViewSection *> *)sections {
    return self.mutableSections.copy;
}

#pragma mark - Add
- (void)addSection:(GZTableViewSection *)section {
    
    section.tableViewManager = self;
    [self.mutableSections addObject:section];
}

- (void)addSections:(NSArray<GZTableViewSection *> *)sections {
    for (GZTableViewSection *section in sections) {
        section.tableViewManager = self;
    }

    [self.mutableSections addObjectsFromArray:sections];
}

- (void)insertSection:(GZTableViewSection *)section atIndex:(NSUInteger)index {
    section.tableViewManager = self;
    [self.mutableSections insertObject:section atIndex:index];
}

- (void)insertSections:(NSArray<GZTableViewSection *> *)sections atIndexs:(NSIndexSet *)indexs {
    for (GZTableViewSection *section in sections) {
        section.tableViewManager = self;
    }

    [self.mutableSections insertObjects:sections atIndexes:indexs];
}

#pragma mark - Remove
- (void)removeSection:(GZTableViewSection *)section {
    [self removeSectionAtIndex:section.index];
}

- (void)removeSection:(GZTableViewSection *)section inRange:(NSRange)range {
    [self.mutableSections removeObject:section inRange:range];
}

- (void)removeSectionIdenticalTo:(GZTableViewSection *)section {
    [self.mutableSections removeObjectIdenticalTo:section];
}

- (void)reomveSectionIdenticalTo:(GZTableViewSection *)section inRange:(NSRange)range {
    [self.mutableSections removeObjectIdenticalTo:section inRange:range];
}

- (void)removeSectionsAtIndexs:(NSIndexSet *)indexs {
    [self.mutableSections removeObjectsAtIndexes:indexs];
}

- (void)removeSectionAtIndex:(NSUInteger)index {
    if (index >= self.mutableSections.count) {
        return;
    }

    [self.mutableSections removeObjectAtIndex:index];
}

- (void)removeSectionsInArray:(NSArray<GZTableViewSection *> *)sections {
    [self.mutableSections removeObjectsInArray:sections];
}

- (void)removeSectionsInRange:(NSRange)range {
    [self.mutableSections removeObjectsInRange:range];
}

- (void)removeLastSection {
    [self.mutableSections removeLastObject];
}

- (void)reomveAllSections {
    [self.mutableSections removeAllObjects];
}

#pragma mark - Replace
- (void)replaceSectionAtIndex:(NSUInteger)index withSection:(GZTableViewSection *)section {
    section.tableViewManager = self;
    [self.mutableSections replaceObjectAtIndex:index withObject:section];
}

- (void)replaceSectionsAtIndexs:(NSIndexSet *)indexs withSections:(NSArray<GZTableViewSection *> *)sections {
    for (GZTableViewSection *section in sections) {
        section.tableViewManager = self;
    }
    [self.mutableSections replaceObjectsAtIndexes:indexs withObjects:sections];
}

- (void)replaceSectionsInRange:(NSRange)range withSectionsFromArray:(NSArray<GZTableViewSection *> *)otherArray range:(NSRange)otherRange {
    for (GZTableViewSection *section in otherArray) {
        section.tableViewManager = self;
    }
    [self.mutableSections replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
}

- (void)replaceSectionsInRange:(NSRange)range withSectionsFromArray:(NSArray<GZTableViewSection *> *)sections {
    for (GZTableViewSection *section in sections) {
        section.tableViewManager = self;
    }
    [self.mutableSections replaceObjectsInRange:range withObjectsFromArray:sections];
}

- (void)replaceSectionsWithSectionsFromArray:(NSArray<GZTableViewSection *> *)sections {
    [self reomveAllSections];
    [self addSections:sections];
}

#pragma mark - Exchage
- (void)exchangeSectionAtIndex:(NSUInteger)idx1 withSectionAtIndex:(NSUInteger)idx2 {
    [self.mutableSections exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
}

#pragma mark - Sort
- (void)sortSectionsUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context {
    [self.mutableSections sortUsingFunction:compare context:context];
}

- (void)sortSectionsUsingSelector:(SEL)comparator {
    [self.mutableSections sortedArrayUsingSelector:comparator];
}

@end
