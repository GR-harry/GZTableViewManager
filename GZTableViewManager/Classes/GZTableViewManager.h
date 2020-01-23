//
//  GZTableViewManager.h
//  GZTableViewManager
//
//  Created by GR on 2018/9/23.
//  Copyright © 2018年 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "GZTableViewSection.h"

#import "GZTableViewItem.h"
#import "GZTableViewCell.h"

#import "GZTextItem.h"
#import "GZTableViewTextCell.h"

#import "GZBoolItem.h"
#import "GZTableViewBoolCell.h"

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

#import "NSString+GZTableViewItem.h"

#import "GZOptionItem.h"
#import "GZTableViewOptionCell.h"

@protocol GZTableViewManagerDelegate;

@interface GZTableViewManager : NSObject

@property (weak, nonatomic, readonly) UITableView *tableView;

- (instancetype)initWithTableView:(UITableView *)tableView;
- (instancetype)initWithTableView:(UITableView *)tableView
                         delegate:(id<GZTableViewManagerDelegate>)delegate;

- (void)setObject:(NSString *)obj forKeyedSubscript:(NSString *)key;
- (Class)objectAtKeyedSubscript:(id<NSCopying>)key;

@end

@interface GZTableViewManager (Editing)

@property (assign, nonatomic) BOOL editing;

@end

@interface GZTableViewManager (ManageSections)

@property (strong, nonatomic, readonly) NSArray<GZTableViewSection *> *sections;

- (void)addSection:(GZTableViewSection *)section;
- (void)addSections:(NSArray<GZTableViewSection *>*)sections;
- (void)insertSection:(GZTableViewSection *)section atIndex:(NSUInteger)index;
- (void)insertSections:(NSArray<GZTableViewSection *>*)sections atIndexs:(NSIndexSet *)indexs;

- (void)removeSection:(GZTableViewSection *)section;
- (void)removeSection:(GZTableViewSection *)section inRange:(NSRange)range;
// 删除和 section address 相同的对象
- (void)removeSectionIdenticalTo:(GZTableViewSection *)section;
- (void)reomveSectionIdenticalTo:(GZTableViewSection *)section inRange:(NSRange)range;
- (void)removeSectionsInArray:(NSArray<GZTableViewSection *>*)sections;
- (void)removeSectionsInRange:(NSRange)range;
- (void)removeSectionAtIndex:(NSUInteger)index;
- (void)removeSectionsAtIndexs:(NSIndexSet *)indexs;
- (void)reomveAllSections;
- (void)removeLastSection;

- (void)replaceSectionAtIndex:(NSUInteger)index withSection:(GZTableViewSection *)section;
- (void)replaceSectionsAtIndexs:(NSIndexSet *)indexs withSections:(NSArray<GZTableViewSection *>*)sections;
// sectionsA中 range元素 用 sectionsB 中的 range 元素替换
- (void)replaceSectionsInRange:(NSRange)range withSectionsFromArray:(NSArray<GZTableViewSection *>*)otherArray range:(NSRange)otherRange;
// sectionsA 中 ragne元素 用sections替换
- (void)replaceSectionsInRange:(NSRange)range withSectionsFromArray:(NSArray<GZTableViewSection *>*)sections;
- (void)replaceSectionsWithSectionsFromArray:(NSArray<GZTableViewSection *>*)sections;

- (void)exchangeSectionAtIndex:(NSUInteger)idx1 withSectionAtIndex:(NSUInteger)idx2;

- (void)sortSectionsUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context;
- (void)sortSectionsUsingSelector:(SEL)comparator;
@end

@protocol GZTableViewManagerDelegate<NSObject>

@end
