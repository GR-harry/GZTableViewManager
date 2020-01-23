//
//  GZTableViewOptionsController.m
//  GZTableViewManager
//
//  Created by GR Harry on 2020/1/23.
//

#import "GZTableViewOptionsController.h"
#import "GZOptionItem.h"
//#import "GZMultipleChoiceItem.h"

@interface GZTableViewOptionsController ()

@property (strong, readwrite, nonatomic) GZTableViewManager *tableViewManager;
@property (strong, readwrite, nonatomic) GZTableViewSection *mainSection;

@end

@implementation GZTableViewOptionsController

- (id)initWithItem:(GZOptionItem *)item options:(NSArray *)options multipleChoice:(BOOL)multipleChoice completionHandler:(void(^)(GZTableViewItem *item))completionHandler
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self)
        return nil;
    
    self.item               = item;
    self.options            = options;
    self.title              = item.text;
    self.multipleChoice     = multipleChoice;
    self.completionHandler  = completionHandler;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableViewManager   = [[GZTableViewManager alloc] initWithTableView:self.tableView delegate:self];
    self.mainSection        = [[GZTableViewSection alloc] init];
    [self.tableViewManager addSection:self.mainSection];
    
    
    __typeof (&*self) __weak weakSelf = self;
    void (^refreshItems)(void) = ^{
        GZOptionItem<NSArray *> * __weak item = weakSelf.item;
        NSMutableArray *results = [[NSMutableArray alloc] init];
        for (GZTableViewItem *sectionItem in weakSelf.mainSection.items) {
            for (NSString *strValue in item.value) {
                if ([strValue isEqualToString:sectionItem.text])
                    [results addObject:sectionItem.text];
            }
        }
        item.value = results;
    };
    
    void (^addItem)(NSString *title) = ^(NSString *title) {
        UITableViewCellAccessoryType accessoryType = UITableViewCellAccessoryNone;
        if (!weakSelf.multipleChoice) {
            if ([title isEqualToString:self.item.detailText])
                accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            GZOptionItem<NSArray *> * item = weakSelf.item;
            
//            GZMultipleChoiceItem * __weak item = (GZMultipleChoiceItem *)weakSelf.item;
            for (NSString *value in item.value) {
                if ([value isEqualToString:title]) {
                    accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }
        }
        
        GZTableViewItem *item = [GZTableViewItem
                                 itemWithText:title
                                 selectionHandler:^(GZTableViewItem *selectedItem) {
            
            UITableViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:selectedItem.indexPath];
            
            if (!weakSelf.multipleChoice) {
                for (NSIndexPath *indexPath in [weakSelf.tableView indexPathsForVisibleRows]) {
                    UITableViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:indexPath];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                for (GZTableViewItem *item in weakSelf.mainSection.items) {
                    item.accessorType = UITableViewCellAccessoryNone;
                }
                selectedItem.accessorType = UITableViewCellAccessoryCheckmark;
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                weakSelf.item.value = selectedItem.text;
                if (weakSelf.completionHandler)
                    weakSelf.completionHandler(selectedItem);
            }
            else { // Multiple choice item
                GZOptionItem<NSArray *> * __weak item = weakSelf.item;
                [weakSelf.tableView deselectRowAtIndexPath:selectedItem.indexPath animated:YES];
                if (selectedItem.accessorType == UITableViewCellAccessoryCheckmark) {
                    selectedItem.accessorType = UITableViewCellAccessoryNone;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    NSMutableArray *items = [[NSMutableArray alloc] init];
                    for (NSString *val in item.value) {
                        if (![val isEqualToString:selectedItem.text])
                            [items addObject:val];
                    }

                    item.value = items;
                } else {
                    selectedItem.accessorType = UITableViewCellAccessoryCheckmark;
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:item.value];
                    [items addObject:selectedItem.text];
                    item.value = items;
                    refreshItems();
                }
                if (weakSelf.completionHandler)
                    weakSelf.completionHandler(selectedItem);
            }
        }];
        
        item.accessorType = accessoryType;
        [self.mainSection addItem:item];
    };
    
    for (GZTableViewItem *item in self.options) {
        addItem(item.text);
    }
}

@end
