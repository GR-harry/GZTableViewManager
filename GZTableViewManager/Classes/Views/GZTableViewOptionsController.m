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
    
    [self setupItems];
}

- (void)setupItems {
    
    for (GZTableViewItem *item in self.options) {
        
        NSString *title = item.text;
        
        UITableViewCellAccessoryType accessoryType = UITableViewCellAccessoryNone;
        
        if (!self.multipleChoice) {
            
            if ([title isEqualToString:self.item.detailText]) {
                accessoryType = UITableViewCellAccessoryCheckmark;
            }
            
        } else {
            
            GZOptionItem<NSArray *> * item = self.item;
            
            if ([item.value containsObject:title]) {
                accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
        
        __typeof (self) __weak weakSelf = self;
        GZTableViewItem *item = [GZTableViewItem
                                 itemWithText:title
                                 selectionHandler:^(GZTableViewItem *selectedItem) {
            
            if (!weakSelf.multipleChoice) {
                
                [weakSelf.mainSection.items makeObjectsPerformSelector:@selector(setAccessorType:)
                                                            withObject:@(UITableViewCellAccessoryNone)];
                selectedItem.accessorType = UITableViewCellAccessoryCheckmark;
                
                [weakSelf.mainSection reloadSectionWithAnimation:UITableViewRowAnimationNone];
                
                weakSelf.item.value = selectedItem.text;
                
                if (weakSelf.completionHandler) {
                    weakSelf.completionHandler(selectedItem);
                }
            }
            else { // Multiple choice
                
                GZOptionItem<NSArray *> *item = weakSelf.item;
                
                [selectedItem deselectRowWithAnimated:YES];
                
                NSMutableSet *set = [NSMutableSet setWithArray:item.value];
                
                if (selectedItem.accessorType == UITableViewCellAccessoryCheckmark) {
                    selectedItem.accessorType = UITableViewCellAccessoryNone;
                    [set removeObject:selectedItem.text];
                }
                else {
                    selectedItem.accessorType = UITableViewCellAccessoryCheckmark;
                    [set addObject:selectedItem.text];
                }
                
                item.value = [set allObjects];
                
                [selectedItem reloadRowWithAnimation:UITableViewRowAnimationNone];
                
                if (weakSelf.completionHandler) {
                    weakSelf.completionHandler(selectedItem);
                }
            }
        }];
        
        item.accessorType = accessoryType;
        [self.mainSection addItem:item];
    }
}

@end
