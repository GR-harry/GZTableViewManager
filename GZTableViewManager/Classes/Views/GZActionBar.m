//
//  GZActionBar.m
//  GZTableViewManager
//
//  Created by GR Harry on 2020/1/26.
//

#import "GZActionBar.h"

@interface GZActionBar ()

@end

@implementation GZActionBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                       target:self
                                       action:@selector(handleActionBarDone:)];
        
        UIBarButtonItem *flexible   = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                       target:nil
                                       action:nil];
        
        [self setItems:[NSArray arrayWithObjects:flexible, doneButton, nil]];
    }
    
    return self;
}

- (void)handleActionBarDone:(UIBarButtonItem *)doneButtonItem
{
    if ([self.actionBarDelegate respondsToSelector:@selector(actionBar:doneButtonPressed:)]) {
        [self.actionBarDelegate actionBar:self doneButtonPressed:doneButtonItem];
    }
}

@end
