//
//  GZTableViewCell.m
//  GZTableViewManager
//
//  Created by GR on 2018/9/24.
//  Copyright © 2018年 Harry. All rights reserved.
//

#import "GZTableViewCell.h"
#import "GZTableViewSection.h"
#import "GZTableViewItem.h"
#import "GZTableViewCell+Private.h"

@interface GZTableViewCell () <GZActionBarDelegate>

@property (assign, nonatomic) BOOL loaded;
@property (strong, nonatomic) GZActionBar *actionBar;

@end

@implementation GZTableViewCell

- (GZTableViewCellType)cellType {
    NSUInteger rowIndex     = self.indexPath.row;
    NSUInteger itemCount    = self.section.items.count;
    
    if (rowIndex == 0 && itemCount == 1) {
        return GZTableViewCellTypeSingle;
    }
    else if (rowIndex == 0 && itemCount > 1) {
        return GZTableViewCellTypeFirst;
    }
    else if (rowIndex > 0 && rowIndex < itemCount - 1 && itemCount > 2) {
        return GZTableViewCellTypeMiddle;
    }
    else if (rowIndex == itemCount - 1 && itemCount > 1) {
        return GZTableViewCellTypeLast;
    }
    
    return GZTableViewCellTypeAny;
}

- (void)setEnabled:(BOOL)enabled {
    
    _enabled = enabled;
    
    [self enableDidChanged:enabled];
}

- (void)setItem:(GZTableViewItem *)item {
    
    if (_item) {
        [_item removeObserver:self forKeyPath:@"enabled"];
    }
    
    _item = item;
    
    [_item addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:NULL];
}


@end


@implementation GZTableViewCell (Override)

- (void)cellDidLoad {
    
    self.loaded = YES;
    
    CGFloat width   = CGRectGetWidth(self.contentView.frame);
    CGFloat height  = 35.f;
    
    self.actionBar = [[GZActionBar alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    self.actionBar.actionBarDelegate = self;
}

- (void)cellWillAppear {
    
    GZTableViewItem *tableViewItem = (GZTableViewItem *)self.item;
    
    self.selectionStyle             = tableViewItem.selectionStyle;
    
    self.userInteractionEnabled     = tableViewItem.enabled;
    
    self.textLabel.textAlignment    = tableViewItem.textAlignment;
    self.textLabel.text             = tableViewItem.text;
    self.detailTextLabel.text       = tableViewItem.detailText;
    
    self.imageView.image            = tableViewItem.image;
    self.imageView.highlightedImage = tableViewItem.highlightImage;
    
    self.accessoryType              = tableViewItem.accessorType;
    
    self.enabled                    = tableViewItem.enabled;
}

- (void)cellDidDisappear {
    
}



+ (CGFloat)heightWithItem:(GZTableViewItem *)item tableViewManager:(GZTableViewManager *)tableViewManager {
    return item.height ? item.height : 44;
}

- (void)enableDidChanged:(BOOL)enabled {
    
    self.userInteractionEnabled = enabled;
    
    self.textLabel.enabled       = enabled;
    self.detailTextLabel.enabled = enabled;
}

- (void)dealloc {
    [self.item removeObserver:self forKeyPath:@"enabled"];
}

#pragma mark - observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([object isKindOfClass:[self.item class]] && [keyPath isEqualToString:@"enabled"]) {
        BOOL enabled = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        self.enabled = enabled;
    }
    
}

@end

@implementation GZTableViewCell (Frame)

- (CGRect)calculateFrameWithMinimumWidth:(CGFloat)minmumWidth {
    
    CGFloat celloffset  = 10.f;
    CGFloat fieldoffset = 10.f;
    
    CGRect frame = CGRectMake(0, self.textLabel.frame.origin.y, 0, self.textLabel.frame.size.height);
    
    if (self.item.text.length) {
        
        CGRect textLabelFrame = self.textLabel.frame;
        textLabelFrame.size.width   = [self.item.text
                                       sizeWithAttributes:@{ NSFontAttributeName: self.textLabel.font }].width + 5;
        self.textLabel.frame        = textLabelFrame;
        
        frame.origin.x = CGRectGetMaxX(self.textLabel.frame) + fieldoffset;
    }
    else {
        frame.origin.x = celloffset;
    }
    
    CGFloat width = CGRectGetWidth(self.contentView.frame) - frame.origin.x - celloffset;
    
    if (width < minmumWidth) {
        CGFloat diff        = minmumWidth - width;
        frame.origin.x      -= diff;
        frame.size.width    = minmumWidth;
    }
    else {
        frame.size.width    = width;
    }
    
    return frame;
}

@end

@implementation GZTableViewCell (ActionBar)

- (void)actionBar:(GZActionBar *)actionBar doneButtonPressed:(UIBarButtonItem *)doneButtonItem {
    
    [self endEditing:YES];
}

@end
