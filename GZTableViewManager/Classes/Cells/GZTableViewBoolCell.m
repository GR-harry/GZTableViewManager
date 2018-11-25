//
//  GZTableViewBoolCell.m
//  GZTableViewManager
//
//  Created by GR on 2018/10/24.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZTableViewBoolCell.h"
#import "GZBoolItem.h"

@interface GZTableViewBoolCell ()

@property (nonatomic, strong) UISwitch *switchView;

@end

@implementation GZTableViewBoolCell

- (void)enableDidChanged:(BOOL)enabled {
    
    self.userInteractionEnabled = enabled;
    self.textLabel.enabled      = enabled;
    self.switchView.enabled     = enabled;
}

#pragma mark - Life cycle
- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.switchView = [[UISwitch alloc] init];
    [self.contentView addSubview:self.switchView];
    
    [self.switchView sizeToFit];
    [self.switchView addTarget:self
                        action:@selector(switchDidChanged:)
              forControlEvents:UIControlEventValueChanged];
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    self.textLabel.text     = self.item.text;
    self.switchView.on      = self.item.on;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat textLabelX          = CGRectGetMinX(self.textLabel.frame);
    
    if (self.item.text.length) {
        CGFloat textWidth       = [self.item.text
                                   sizeWithAttributes:@{ NSFontAttributeName : self.textLabel.font }].width;
        
        CGRect frame            = self.textLabel.frame;
        frame.size.width        = textWidth;
        self.textLabel.frame    = frame;
    }
    
    CGFloat switchW         = CGRectGetWidth(self.switchView.frame);
    CGFloat switchH         = CGRectGetHeight(self.switchView.frame);
    CGFloat switchX         = CGRectGetWidth(self.contentView.frame) - textLabelX - switchW;
    CGFloat switchY         = (CGRectGetHeight(self.contentView.frame) - switchH) * 0.5;
    self.switchView.frame   = CGRectMake(switchX, switchY, switchW, switchH);
}

#pragma mark - Actions
- (void)switchDidChanged:(UISwitch *)switchView {
    
    self.item.on = switchView.isOn;
    
    if (self.item.swithValueChangedHandler) {
        self.item.swithValueChangedHandler(self.item);
    }
}

@end
