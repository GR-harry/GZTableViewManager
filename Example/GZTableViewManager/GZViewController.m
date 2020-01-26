//
//  GZViewController.m
//  GZTableViewManager
//
//  Created by GuoRui on 11/25/2018.
//  Copyright (c) 2018 GuoRui. All rights reserved.
//

#import "GZViewController.h"
#import <GZTableViewManager/GZTableViewManager.h>
#import <GZTableViewOptionsController.h>

@interface GZViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GZTableViewManager *tableViewManager;

@end

@implementation GZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView                  = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStyleGrouped];
    self.tableView.tableFooterView  = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    
    self.tableViewManager = [[GZTableViewManager alloc] initWithTableView:self.tableView];
    
    [self setupGeneralSectionAndItems];
    
    [self setupCopySectionAndItems];
    
    [self.tableView reloadData];
}

- (void)setupCopySectionAndItems {
    
    GZTableViewSection *section = [GZTableViewSection sectionWithHeaderTitle:@"Copy / pasting"
                                                                 footerTitle:@"This section holds items that support copy and pasting. You can tap on an item to copy it, while you can tap on another one to paste it."];
    [self.tableViewManager addSection:section];
    
    {
        GZTableViewItem *item = [GZTableViewItem itemWithText:@"Long tap to copy this item"
                                             selectionHandler:^(GZTableViewItem *item) {
            [item deselectRowWithAnimated:YES];
        }];
        
        item.copyHandler = ^(GZTableViewItem *item) {
            
            [UIPasteboard generalPasteboard].string = @"Copied item #1";
        };
        
        [section addItem:item];
    }
    
    {
        GZTableViewItem *item = [GZTableViewItem itemWithText:@"Long tap to paste into this item"
                                             selectionHandler:^(GZTableViewItem *item) {
            [item deselectRowWithAnimated:YES];
        }];
        
        item.pasteHandler = ^(GZTableViewItem *item) {
            item.text = [UIPasteboard generalPasteboard].string;
            [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
        };
        
        [section addItem:item];
    }
    
    {
        GZTableViewItem *item = [GZTableViewItem itemWithText:@"Long tap to cut / copy / paste"
                                             selectionHandler:^(GZTableViewItem *item) {
            [item deselectRowWithAnimated:YES];
        }];
        
        item.copyHandler = ^(GZTableViewItem *item) {
            [UIPasteboard generalPasteboard].string = @"Copied item #3";
        };
        item.pasteHandler = ^(GZTableViewItem *item) {
            item.text = [UIPasteboard generalPasteboard].string;
            [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
        };
        item.cutHandler = ^(GZTableViewItem *item) {
            item.text = @"(Empty)";
            [UIPasteboard generalPasteboard].string = @"Copied item #3";
            [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
        };
        
        [section addItem:item];
    }
}

- (void)setupGeneralSectionAndItems {
    
    GZTableViewSection *section = [GZTableViewSection section];
    [self.tableViewManager addSection:section];
    
    
    {
        GZTableViewItem *item = @"Common".tableViewItem;
        item.selectionHandler = ^(GZTableViewItem *item) {
            [item deselectRowWithAnimated:YES];
            NSLog(@"common");
        };
        [section addItem:item];
    }
    
    {
        GZTableViewItem *item = @"Custom".tableViewItem;
        item.selectionHandler = ^(GZTableViewItem *item) {
            [item deselectRowWithAnimated:YES];
            NSLog(@"Custom");
        };
        [section addItem:item];
    }
    
    {
        GZTableViewItem *item = @"Eidt".tableViewItem;
        item.selectionHandler = ^(GZTableViewItem *item) {
            [item deselectRowWithAnimated:YES];
            NSLog(@"Eidt");
        };
        [section addItem:item];
    }
    
    {
#warning TODO: 1. GZTableViewOptionsController选择时出现警告。
        __typeof (self) __weak weakSelf = self;
        GZOptionItem<NSString *> *radioItem = [GZOptionItem itemWithText:@"Radio" value:@"option 4" selectionHandler:^(GZOptionItem *item) {
            [item deselectRowWithAnimated:YES];
            
            NSMutableArray *options = [NSMutableArray array];
            for (int i = 0; i < 10; i++) {
                NSString *string = [NSString stringWithFormat:@"option %d", i];
                [options addObject:string.tableViewItem];
            }
            
            
            GZTableViewOptionsController *optionsVc = [[GZTableViewOptionsController alloc]
                                                       initWithItem:item
                                                       options:options
                                                       multipleChoice:NO
                                                       completionHandler:^(GZTableViewItem *selectedItem) {
                
                NSLog(@"%@", item.value);
                [weakSelf.navigationController popViewControllerAnimated:YES];
                [item reloadRowWithAnimation:UITableViewRowAnimationNone];
            }];
            
            [weakSelf.navigationController pushViewController:optionsVc animated:YES];
        }];
        [section addItem:radioItem];
    }
    
    {
        __typeof (self) __weak weakSelf = self;
        GZOptionItem<NSArray *> *radioItem = [GZOptionItem itemWithText:@"Multiple Choice" value:@[@"option 4", @"option 5"] selectionHandler:^(GZOptionItem *item) {
            [item deselectRowWithAnimated:YES];

            NSMutableArray *options = [NSMutableArray array];
            for (int i = 0; i < 10; i++) {
                NSString *string = [NSString stringWithFormat:@"option %d", i];
                [options addObject:string.tableViewItem];
            }


            
            GZTableViewOptionsController *optionsVc = [[GZTableViewOptionsController alloc]
                                                       initWithItem:item
                                                       options:options
                                                       multipleChoice:YES
                                                       completionHandler:^(GZTableViewItem *selectedItem) {

                [item reloadRowWithAnimation:UITableViewRowAnimationNone];
                NSLog(@"parent: %@, child: %@", item.value, selectedItem.text);
            }];

            [weakSelf.navigationController pushViewController:optionsVc animated:YES];
        }];
        [section addItem:radioItem];
    }
    
    {
        GZSegmentedItem *item = [GZSegmentedItem
                                 itemWithText:@"Segmented"
                                 segmentedControlTitles:@[@"One", @"Two", @"Three"]
                                 value:0
                                 switchValueChangeHandler:^(GZSegmentedItem *item) {
            NSLog(@"Value: %li", (long)item.value);
        }];
        [section addItem:item];
    }
    
    {
        GZSegmentedItem *item = [GZSegmentedItem
                                 itemWithText:nil
                                 segmentedControlImages:@[[UIImage imageNamed:@"Heart"], [UIImage imageNamed:@"Heart_Highlighted"]]
                                 value:0
                                 switchValueChangeHandler:^(GZSegmentedItem *item) {
            NSLog(@"Value: %li", (long)item.value);
        }];
        
        item.tintColor = [UIColor clearColor];
        
        [section addItem:item];
    }
}

@end
