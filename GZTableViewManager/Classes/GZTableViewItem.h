//
//  GZTableViewItem.h
//  GZTableViewManager
//
//  Created by GR on 2018/9/23.
//  Copyright © 2018年 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GZTableViewSection;

@interface GZTableViewItem : NSObject

@property (weak, nonatomic)     GZTableViewSection *section;

@property (assign, nonatomic)   BOOL enabled;
@property (assign, nonatomic)   CGFloat height;
@property (assign, nonatomic)   NSTextAlignment textAlignment;
@property (assign, nonatomic)   UITableViewCellStyle cellStyle;
@property (assign, nonatomic)   UITableViewCellAccessoryType accessorType;
@property (assign, nonatomic)   UITableViewCellSelectionStyle selectionStyle;

@property (copy, nonatomic)     NSString *cellIdentifier;
@property (copy, nonatomic)     NSString *text;
@property (copy, nonatomic)     NSString *detailText;

@property (strong, nonatomic)   UIImage *image;
@property (strong, nonatomic)   UIImage *highlightImage;


@property (copy, nonatomic)     void (^selectionHandler)(GZTableViewItem *item);
@property (copy, nonatomic)     void (^accessoryButtonTapHandler)(GZTableViewItem *item);

@property (readonly) NSIndexPath *indexPath;

// Eiditing
@property (assign, nonatomic)   UITableViewCellEditingStyle editingStyle; // Default UITableViewCellEditingStyleDelete
@property (assign, nonatomic)   BOOL shouldIndentWhileEditing; // Default YES
@property (copy, nonatomic)     void (^deleteWithOperateHandler)(GZTableViewItem *item, void (^)(void));
@property (copy, nonatomic)     void (^deleteHandler)(GZTableViewItem *item);
@property (copy, nonatomic)     NSArray<GZTableViewItem *> * (^insertWithOperateHandler)(GZTableViewItem *item);
//@property (copy, nonatomic)     void (^moveWithOperateHandler)(GZTableViewItem *item);
@property (copy, nonatomic)     void (^moveHandler)(GZTableViewItem *item, NSIndexPath *sourecIndexPath, NSIndexPath *destinationIndexPath);


+ (instancetype)item;
+ (instancetype)itemWithText:(NSString *)text;
+ (instancetype)itemWithText:(NSString *)text
            selectionHandler:(void(^)(GZTableViewItem *item))selectionHandler;


- (instancetype)initWithText:(NSString *)text;
- (instancetype)initWithText:(NSString *)text
            selectionHandler:(void(^)(GZTableViewItem *item))selectionHandler;
@end

@interface GZTableViewItem (Manipulating_Row)

- (void)selectRowWithAnimated:(BOOL)animated;
- (void)selectRowWithAnimated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition;
- (void)deselectRowWithAnimated:(BOOL)animated;
- (void)reloadRowWithAnimation:(UITableViewRowAnimation)animation;
- (void)deleteRowWithAnimation:(UITableViewRowAnimation)animation;

@end
