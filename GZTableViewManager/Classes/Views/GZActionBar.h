//
//  GZActionBar.h
//  GZTableViewManager
//
//  Created by GR Harry on 2020/1/26.
//

#import <UIKit/UIKit.h>

@class GZActionBar;

@protocol GZActionBarDelegate <NSObject>

@optional
- (void)actionBar:(GZActionBar *)actionBar doneButtonPressed:(UIBarButtonItem *)doneButtonItem;

@end

@interface GZActionBar : UIToolbar

@property (weak, nonatomic) id<GZActionBarDelegate> actionBarDelegate;

@end

