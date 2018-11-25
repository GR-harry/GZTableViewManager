//
//  GZPlaceholderTextView.m
//  GZTableViewManager
//
//  Created by GR on 2018/10/26.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZPlaceholderTextView.h"

@interface GZPlaceholderTextView ()

@property (strong, nonatomic) UILabel *placeholderLabel;

@end

@implementation GZPlaceholderTextView

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.placeholderColor = [UIColor lightGrayColor];
        
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(textDidChanged:)
         name:UITextViewTextDidChangeNotification
         object:nil];
    }
    
    return self;
}

- (void)setText:(NSString *)text {
    
    [super setText:text];
    
    [self textDidChanged:nil];
}

#pragma mark - Actions
- (void)textDidChanged:(NSNotification *)notification {
    
    if (!self.placeholder.length) {
        return;
    }
    
    self.placeholderLabel.hidden = ( self.text.length ? YES : NO );
}

- (void)drawRect:(CGRect)rect {
    
    if (self.placeholder.length) {
        
        self.placeholderLabel.text      = self.placeholder;
        self.placeholderLabel.font      = self.font;
        self.placeholderLabel.textColor = self.placeholderColor;
        
        [self.placeholderLabel sizeToFit];
        
        CGFloat x = 8;
        CGFloat y = 8;
        CGFloat h = CGRectGetHeight(self.placeholderLabel.frame);
        CGFloat w = CGRectGetWidth(self.frame) - 2 * x;
        self.placeholderLabel.frame     = CGRectMake(x, y, w, h);
        
        self.placeholderLabel.hidden    = self.text.length;
    }
    else {
        
        self.placeholderLabel.hidden = YES;
    }
}

#pragma mark - Lazy
- (UILabel *)placeholderLabel {
    
    if (!_placeholderLabel) {
        _placeholderLabel               = [[UILabel alloc] init];
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_placeholderLabel];
    }
    return _placeholderLabel;
}

@end
