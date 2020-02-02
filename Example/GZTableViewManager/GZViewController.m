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
#import "GZFormsViewController.h"
#import "GZIndexesViewController.h"
#import "GZEditingViewController.h"

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
    
    GZTableViewSection *section = [GZTableViewSection section];
    [self.tableViewManager addSection:section];
    
    __typeof (self) __weak weakSelf = self;
    {
        GZTableViewItem *item = @"Forms".tableViewItem;
        
        item.selectionHandler = ^(GZTableViewItem *item) {
            
            [item deselectRowWithAnimated:YES];
            
            GZFormsViewController *vc = [[GZFormsViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        [section addItem:item];
    }
    
    {
        GZTableViewItem *item = @"Indexes".tableViewItem;
        
        item.selectionHandler = ^(GZTableViewItem *item) {
            
            [item deselectRowWithAnimated:YES];
            
            GZIndexesViewController *vc = [[GZIndexesViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        [section addItem:item];
    }
    
    {
        GZTableViewItem *item = @"Editing".tableViewItem;
        
        item.selectionHandler = ^(GZTableViewItem *item) {
            
            [item deselectRowWithAnimated:YES];
            
            GZEditingViewController *vc = [[GZEditingViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        [section addItem:item];
    }
    
    [self.tableView reloadData];
}



@end
