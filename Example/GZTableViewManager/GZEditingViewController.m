//
//  GZEditingViewController.m
//  GZTableViewManager_Example
//
//  Created by GR Harry on 2020/2/2.
//  Copyright © 2020 GuoRui. All rights reserved.
//

#import "GZEditingViewController.h"
#import <GZTableViewManager/GZTableViewManager.h>

@interface GZEditingViewController ()
@property (nonatomic, strong) GZTableViewManager *tableViewManager;
@end

@implementation GZEditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"Editing";
    
    self.tableViewManager = [[GZTableViewManager alloc] initWithTableView:self.tableView];
    
    [self setupDeletableSection];
    [self setupDeletableWithConfirmationSection];
    [self setupMovableSection];
    [self setupDeletableAndMovableSection];
    [self setupInsertSection];
    
    [self.tableView reloadData];
}

- (void)setupDeletableSection {
    
    GZTableViewSection *section = [GZTableViewSection sectionWithHeaderTitle:@"Deletable"];
    [self.tableViewManager addSection:section];
    
    
    for (NSInteger i = 1; i <= 5; i++) {
        GZTableViewItem *item = [GZTableViewItem itemWithText:[NSString stringWithFormat:@"Section 0, Item %li", (long) i] selectionHandler:nil];
        item.editingStyle = UITableViewCellEditingStyleDelete;
        item.deleteHandler = ^(GZTableViewItem *item) {
            NSLog(@"Item removed: %@", item.text);
        };
        [section addItem:item];
    }
}

- (void)setupDeletableWithConfirmationSection {
    
    GZTableViewSection *section = [GZTableViewSection sectionWithHeaderTitle:@"Deletable with confirmation"];
    [self.tableViewManager addSection:section];
    
    __typeof(self) __weak  weakSelf = self;
    
    for (NSInteger i = 1; i <= 5; i++) {
        GZTableViewItem *item = [GZTableViewItem itemWithText:[NSString stringWithFormat:@"Section 1, Item %li", (long) i] selectionHandler:nil];
        item.editingStyle = UITableViewCellEditingStyleDelete;
        item.deleteWithOperateHandler = ^(GZTableViewItem *item, void (^completion)(void)) {
            
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"Confiramtion"
                                                                        message:[NSString stringWithFormat:@"Are you sure you want to delete %@", item.text]
                                                                 preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *ok     = [UIAlertAction actionWithTitle:@"OK"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                if (completion) {
                    completion();
                }
                
                NSLog(@"Item removed: %@", item.text);
            }];
            
            [vc addAction:cancel];
            [vc addAction:ok];
            
            [weakSelf presentViewController:vc animated:YES completion:nil];
        };
        [section addItem:item];
    }
}

- (void)setupMovableSection {

    GZTableViewSection *section = [GZTableViewSection sectionWithHeaderTitle:@"Movable"];
    [self.tableViewManager addSection:section];
    
    for (NSInteger i = 1; i <= 5; i++) {
        GZTableViewItem *item = [GZTableViewItem itemWithText:[NSString stringWithFormat:@"Section 2, Item %li", (long) i] selectionHandler:nil];
        item.moveHandler = ^(GZTableViewItem *item, NSIndexPath *sourecIndexPath, NSIndexPath *destinationIndexPath) {
            NSLog(@"Moved item: %@ from [%li,%li] to [%li,%li]", item.text, (long)sourecIndexPath.section, (long)sourecIndexPath.row, (long) destinationIndexPath.section, (long) destinationIndexPath.row);
        };
        
        item.selectionHandler = ^(GZTableViewItem *item) {
            NSLog(@"Select item at index %d", (int)item.indexPath.row);
        };
        
        [section addItem:item];
    }
}

- (void)setupDeletableAndMovableSection {

    GZTableViewSection *section = [GZTableViewSection sectionWithHeaderTitle:@"Deletable & Movable"];
    [self.tableViewManager addSection:section];
    
    for (NSInteger i = 1; i <= 5; i++) {
        GZTableViewItem *item = [GZTableViewItem itemWithText:[NSString stringWithFormat:@"Section 3, Item %li", (long) i] selectionHandler:nil];
        
        item.editingStyle = UITableViewCellEditingStyleDelete;
        item.moveHandler = ^(GZTableViewItem *item, NSIndexPath *sourecIndexPath, NSIndexPath *destinationIndexPath) {
            NSLog(@"Moved item: %@ from [%li,%li] to [%li,%li]", item.text, (long)sourecIndexPath.section, (long)sourecIndexPath.row, (long) destinationIndexPath.section, (long) destinationIndexPath.row);
        };
        
        item.selectionHandler = ^(GZTableViewItem *item) {
            NSLog(@"Select item at index %d", (int)item.indexPath.row);
        };
        
        [section addItem:item];
    }
}

- (void)setupInsertSection {
    
    GZTableViewSection *section = [GZTableViewSection sectionWithHeaderTitle:@"Insert"];
    [self.tableViewManager addSection:section];
    
    GZTableViewItem *item = [GZTableViewItem itemWithText:[NSString stringWithFormat:@"Section 6, Item %i", 1] selectionHandler:nil];
    item.insertWithOperateHandler = ^NSArray<GZTableViewItem *> *(GZTableViewItem *item) {
      
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:5];
        for (int i = 0; i < 5; i++) {
            GZTableViewItem *it = [GZTableViewItem itemWithText:[NSString stringWithFormat:@"Section 6, Item %d", 1 + i] selectionHandler:nil];
            it.selectionHandler = ^(GZTableViewItem *item) {
                NSLog(@"Select at index %d", (int)item.indexPath.row);
            };
            
            [array addObject:it];
        }
        
        return array.copy;
    };
    item.editingStyle = UITableViewCellEditingStyleInsert;
    [section addItem:item];
}

@end
