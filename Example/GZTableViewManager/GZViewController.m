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
    [self setupAccessoriesSecionAndItems];
    
    [self.tableView reloadData];
}

- (void)setupAccessoriesSecionAndItems {
    
    GZTableViewSection *section = [GZTableViewSection sectionWithHeaderTitle:@"Accessories"
                                                                 footerTitle:@"This section holds items with accessories."];
    [self.tableViewManager addSection:section];
    
    {
        GZTableViewItem *item = [GZTableViewItem itemWithText:@"Accessory 1" selectionHandler:^(GZTableViewItem *item) {
            [item deselectRowWithAnimated:YES];
        }];
        
        item.accessorType = UITableViewCellAccessoryDisclosureIndicator;
        
        [section addItem:item];
    }
    
    {
        GZTableViewItem *item = [GZTableViewItem itemWithText:@"Accessory 2" selectionHandler:^(GZTableViewItem *item) {
            [item deselectRowWithAnimated:YES];
        }];
        
        
        item.accessoryButtonTapHandler = ^(GZTableViewItem *item) {
            NSLog(@"Accessory button in accessoryItem2 was tapped");
        };
        
        item.accessorType = UITableViewCellAccessoryDetailDisclosureButton;
        
        [section addItem:item];
    }
    
    
    {
        GZTableViewItem *item = [GZTableViewItem itemWithText:@"Accessory 3" selectionHandler:^(GZTableViewItem *item) {
            [item deselectRowWithAnimated:YES];
        }];
        
        
        item.accessoryButtonTapHandler = ^(GZTableViewItem *item) {
            NSLog(@"Accessory button in accessoryItem3 was tapped");
        };
        
        item.accessorType = UITableViewCellAccessoryDetailButton;
        
        [section addItem:item];
    }
    
    {
        GZTableViewItem *item = [GZTableViewItem itemWithText:@"Accessory 4" selectionHandler:^(GZTableViewItem *item) {
            
            item.accessorType = (item.accessorType == UITableViewCellAccessoryCheckmark ? UITableViewCellAccessoryNone : UITableViewCellAccessoryCheckmark);
            
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
        }];
        
        item.accessorType = UITableViewCellAccessoryCheckmark;
        
        [section addItem:item];
    }
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
    
    __typeof (self) __weak weakSelf = self;
    {
        GZTableViewItem *item = @"Value1 cell style".tableViewItem;
        item.selectionHandler = ^(GZTableViewItem *item) {
            [item deselectRowWithAnimated:YES];
        };
        item.detailText = @"detail";
        item.height     = UITableViewAutomaticDimension;
        item.cellStyle  = UITableViewCellStyleValue1;
        [section addItem:item];
    }
    
    {
        GZTableViewItem *item = @"Value2 cell style".tableViewItem;
        item.selectionHandler = ^(GZTableViewItem *item) {
            [item deselectRowWithAnimated:YES];
        };
        item.detailText = @"detail";
        item.height     = UITableViewAutomaticDimension;
        item.cellStyle  = UITableViewCellStyleValue2;
        [section addItem:item];
    }
    
    {
        GZTableViewItem *item = @"Default cell style".tableViewItem;
        item.selectionHandler = ^(GZTableViewItem *item) {
            [item deselectRowWithAnimated:YES];
        };
        item.detailText = @"detail";
        item.height     = UITableViewAutomaticDimension;
        item.cellStyle  = UITableViewCellStyleDefault;
        [section addItem:item];
    }
    
    {
        GZTableViewItem *item = @"Subtitle cell style".tableViewItem;
        item.selectionHandler = ^(GZTableViewItem *item) {
            [item deselectRowWithAnimated:YES];
        };
        
        item.detailText = @"detail";
        item.cellStyle  = UITableViewCellStyleSubtitle;
        [section addItem:item];
    }
    
    {
        GZAdaptiveHeightTextItem *item = [GZAdaptiveHeightTextItem itemWithText:@"Adaptive Height"];
        
        item.selectionHandler = ^(GZTableViewItem *item) {
            [item deselectRowWithAnimated:YES];
        };
        
        item.detailText = @"Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text";
//        item.cellStyle  = UITableViewCellStyleValue1;
        [section addItem:item];
    }
    
    {
        GZTableViewItem *item = @"Image and Text".tableViewItem;
        item.selectionHandler = ^(GZTableViewItem *item) {
            [item deselectRowWithAnimated:YES];
        };
        
        item.image          = [UIImage imageNamed:@"Heart"];
        item.highlightImage = [UIImage imageNamed:@"Heart_Highlighted"];
        
        [section addItem:item];
    }
    
    
    {
        GZBoolItem *item = [GZBoolItem itemWithText:@"Bool Item" on:YES swithValueChangedHandler:^(GZBoolItem *item) {
            NSLog(@"Switch state is %@", item.on ? @"ON" : @"OFF");
        }];
        [section addItem:item];
    }
    
    {
        GZFloatItem *item = [GZFloatItem itemWithText:@"Float Item" value:50 valueChangedHandler:^(GZFloatItem *item) {
            NSLog(@"Track value is %lf", item.value);
        }];
        
        item.valueRange = NSMakeRange(0, 100);
        
        [section addItem:item];
    }
    
    {
        GZPickerItem *item = [GZPickerItem itemWithText:@"Picker" value:@[@"Single"] options:@[@[@"Single", @"Mutil"]] stringWithValueComponentsHandler:^NSString *(NSArray<id<GZPickerItemRow>> *value) {
            
            NSMutableString *string = [NSMutableString string];
            
            for (id<GZPickerItemRow> row in value) {
                [string appendFormat:@"%@|", row.title];
            }
            
            return string.copy;
        } valueDidChangedHandler:^(GZPickerItem *item) {
            NSLog(@"Select is %@", item.value);
        }];
        
//        item.inlinePicker = YES;
        
        [section addItem:item];
    }
    
    {
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:- 10 * 24 * 3600];
        
        GZDatePickerItem *item = [GZDatePickerItem itemWithText:@"Date" value:date dateFormat:@"YYYY-MM-dd hh:mm:ss" placeholder:@"xxx" onChange:^(GZDatePickerItem *item) {
            NSLog(@"Select date is %@", item.value);
            [weakSelf.view endEditing:YES];
        }];
        
        item.datePickerMode = UIDatePickerModeDate;
        
        item.inlineDatePicker = YES;
        
        [section addItem:item];
    }
    
    {
#warning TODO: 1. GZTableViewOptionsController选择时出现警告。
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
