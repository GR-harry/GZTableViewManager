//
//  GZIndexesViewController.m
//  GZTableViewManager_Example
//
//  Created by GR Harry on 2020/1/29.
//  Copyright © 2020 GuoRui. All rights reserved.
//

#import "GZIndexesViewController.h"
#import <GZTableViewManager/GZTableViewManager.h>

@interface GZIndexesViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GZTableViewManager *tableViewManager;
@end

@implementation GZIndexesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView                  = [[UITableView alloc] initWithFrame:self.view.bounds
                                                                   style:UITableViewStyleGrouped];
    self.tableView.tableFooterView  = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    
    self.tableViewManager = [[GZTableViewManager alloc] initWithTableView:self.tableView];
 
    NSArray *sectionTitles = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M",
                               @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];

    for (NSString *sectionTitle in sectionTitles) {
        GZTableViewSection *section = [GZTableViewSection sectionWithHeaderTitle:sectionTitle];
        section.indexTitle = sectionTitle; // assign index title
        
        //
        for (NSInteger i = 1; i <= 5; i++) {
            [section addItem:[NSString stringWithFormat:@"%@%li", sectionTitle, (long) i].tableViewItem];
        }
        
        [self.tableViewManager addSection:section];
    }
    
    [self.tableView reloadData];
}


@end
