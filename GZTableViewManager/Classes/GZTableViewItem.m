//
//  GZTableViewItem.m
//  GZTableViewManager
//
//  Created by GR on 2018/9/23.
//  Copyright © 2018年 Harry. All rights reserved.
//

#import "GZTableViewItem.h"
#import "GZTableViewSection.h"
#import "GZTableViewCell.h"
#import "GZTableViewManager.h"

@implementation GZTableViewItem

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.enabled                    = YES;
        self.height                     = 44.f;
        self.cellStyle                  = UITableViewCellStyleDefault;
        self.accessorType               = UITableViewCellAccessoryNone;
        self.selectionStyle             = UITableViewCellSelectionStyleDefault;
        self.editingStyle               = UITableViewCellEditingStyleNone;
        self.shouldIndentWhileEditing   = YES;
    }
    
    return self;
}

+ (instancetype)item {
    return [[self alloc] init];
}

+ (instancetype)itemWithText:(NSString *)text {
    return [[self alloc] initWithText:text];
}

+ (instancetype)itemWithText:(NSString *)text selectionHandler:(void (^)(GZTableViewItem *))selectionHandler {
    return [[self alloc] initWithText:text selectionHandler:selectionHandler];
}

- (instancetype)initWithText:(NSString *)text {
    return [self initWithText:text selectionHandler:nil];
}

- (instancetype)initWithText:(NSString *)text selectionHandler:(void (^)(GZTableViewItem *))selectionHandler {
    
    if (self = [self init]) {
        self.text               = text;
        self.selectionHandler   = selectionHandler;
    }
    return self;
}


- (NSIndexPath *)indexPath {
    return [NSIndexPath indexPathForRow:[self.section.items indexOfObject:self] inSection:self.section.index];
}

@end

@implementation GZTableViewItem (Manipulating_Row)

- (void)selectRowWithAnimated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition {
    
    [self.section.tableViewManager.tableView selectRowAtIndexPath:self.indexPath
                                                         animated:animated
                                                   scrollPosition:scrollPosition];
}

- (void)selectRowWithAnimated:(BOOL)animated {
    
    [self selectRowWithAnimated:animated scrollPosition:UITableViewScrollPositionNone];
}

- (void)deselectRowWithAnimated:(BOOL)animated {
    
    [self.section.tableViewManager.tableView deselectRowAtIndexPath:self.indexPath
                                                           animated:animated];
}

- (void)reloadRowWithAnimation:(UITableViewRowAnimation)animation {
    
    [self.section.tableViewManager.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:animation];
}

- (void)deleteRowWithAnimation:(UITableViewRowAnimation)animation {
    
    NSInteger sectionIndex  = self.section.index;
    NSInteger rowIndex      = self.indexPath.row;
    [self.section removeItemAtIndex:rowIndex];
    
    [self.section.tableViewManager.tableView
     deleteRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex] ]
     withRowAnimation:animation];
    
    // 修改 cell 位序
    for (NSInteger i = rowIndex; i < self.section.items.count; i++) {
        
        GZTableViewCell *cell = [self.section.tableViewManager.tableView
                                 cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i
                                                                          inSection:sectionIndex]];
        cell.indexPath        = [NSIndexPath indexPathForRow:i inSection:sectionIndex];
    }
}

@end
