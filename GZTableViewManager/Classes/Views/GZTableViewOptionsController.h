//
//  GZTableViewOptionsController.h
//  GZTableViewManager
//
//  Created by GR Harry on 2020/1/23.
//

#import <UIKit/UIKit.h>
#import "GZTableViewManager.h"


@interface GZTableViewOptionsController : UITableViewController<GZTableViewManagerDelegate>

@property (weak, readwrite, nonatomic) GZOptionItem *item;
@property (strong, readwrite, nonatomic) NSArray<GZTableViewItem *> *options;
@property (assign, readwrite, nonatomic) BOOL multipleChoice;
@property (copy, readwrite, nonatomic) void (^completionHandler)(GZTableViewItem *item);

- (id)initWithItem:(GZTableViewItem *)item options:(NSArray *)options multipleChoice:(BOOL)multipleChoice completionHandler:(void(^)(GZTableViewItem *item))completionHandler;

@end

