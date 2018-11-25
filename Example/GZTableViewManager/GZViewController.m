//
//  GZViewController.m
//  GZTableViewManager
//
//  Created by GuoRui on 11/25/2018.
//  Copyright (c) 2018 GuoRui. All rights reserved.
//

#import "GZViewController.h"
#import <GZTableViewManager/GZTableViewManager.h>

@interface GZViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GZTableViewManager *tableViewManager;

@end

@implementation GZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView                  = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
    self.tableView.tableFooterView  = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    
    self.tableViewManager = [[GZTableViewManager alloc] initWithTableView:self.tableView];
    
    [self setupItems];
}

- (void)setupItems {
    
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
    
    
    [self.tableView reloadData];
}

@end
