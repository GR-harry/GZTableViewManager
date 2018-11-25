//
//  GZTableViewFloatCell.m
//  GZTableViewManager
//
//  Created by GR on 2018/10/26.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZTableViewFloatCell.h"
#import "GZFloatItem.h"

@interface GZTableViewFloatCell ()

@property (strong, nonatomic) UISlider *sliderView;

@end

@implementation GZTableViewFloatCell

- (void)enableDidChanged:(BOOL)enabled {
    
    self.userInteractionEnabled = enabled;
    self.textLabel.enabled      = enabled;
    self.sliderView.enabled     = enabled;
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.sliderView = [[UISlider alloc] init];
    [self.sliderView addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.sliderView];
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    self.textLabel.text             = self.item.text;
    self.sliderView.minimumValue    = self.item.valueRange.location;
    self.sliderView.maximumValue    = self.item.valueRange.location + self.item.valueRange.length;
    
    
    CGFloat value = 0;
    if (NSLocationInRange(self.item.value, self.item.valueRange)) {
        value = self.item.value;
    }
    else if (self.item.value <= self.item.valueRange.location) {
        value = self.item.valueRange.location;
    }
    else {
        value = self.item.valueRange.location + self.item.valueRange.length;
    }
    
    [self.sliderView setValue:value animated:NO];
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
    
    CGFloat sliderX         = CGRectGetMaxX(self.textLabel.frame) + 40.f;
    CGFloat sliderW         = CGRectGetWidth(self.contentView.frame) - textLabelX - sliderX;
    CGFloat sliderH         = CGRectGetHeight(self.textLabel.frame);
    CGFloat sliderY         = (CGRectGetHeight(self.contentView.frame) - sliderH) * 0.5;
    self.sliderView.frame   = CGRectMake(sliderX, sliderY, sliderW, sliderH);
}


- (void)valueChanged:(UISlider *)slider {
    
    self.item.value = slider.value;
    
    if (self.item.valueChangedHandler) {
        self.item.valueChangedHandler(self.item);
    }
}
@end
