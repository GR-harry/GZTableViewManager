//
//  GZTableViewLongTextCell.m
//  GZTableViewManager
//
//  Created by GR on 2018/10/26.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZTableViewLongTextCell.h"
#import "GZPlaceholderTextView.h"
#import "GZLongTextItem.h"
#import "GZTableViewManager.h"

@interface GZTableViewLongTextCell ()<UITextViewDelegate>

@property (strong, nonatomic) GZPlaceholderTextView *textView;

@end

@implementation GZTableViewLongTextCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    if (selected) {
        [self.textView becomeFirstResponder];
    }
}

- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.textView           = [[GZPlaceholderTextView alloc] init];
    self.textView.delegate  = self;
    [self.contentView addSubview:self.textView];
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    self.selectionStyle                         = UITableViewCellSelectionStyleNone;
    
    self.textView.text                          = self.item.value;
    self.textView.placeholder                   = self.item.placeholder;
    self.textView.placeholderColor              = self.item.placeholderColor;
    self.textView.font                          = self.item.valueFont;
    self.textView.autocapitalizationType        = self.item.autocapitalizationType;
    self.textView.autocorrectionType            = self.item.autocorrectionType;
    self.textView.spellCheckingType             = self.item.spellCheckingType;
    self.textView.keyboardType                  = self.item.keyboardType;
    self.textView.keyboardAppearance            = self.item.keyboardAppearance;
    self.textView.returnKeyType                 = self.item.returnKeyType;
    self.textView.secureTextEntry               = self.item.secureTextEntry;
    self.textView.enablesReturnKeyAutomatically = self.item.enablesReturnKeyAutomatically;
    
    [self.textView setNeedsDisplay];
    
//    self.enabled = self.item.enabled;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x = 7;
    CGFloat y = 2;
    CGFloat w = CGRectGetWidth(self.contentView.frame) - 2 * x;
    CGFloat h = CGRectGetHeight(self.contentView.frame) - 2 * y;
    self.textView.frame = CGRectMake(x, y, w, h);
}

#pragma mark UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    [self.tableViewManager.tableView
     scrollToRowAtIndexPath:self.item.indexPath
     atScrollPosition:UITableViewScrollPositionTop
     animated:YES];
    
    if (self.item.onBeginEditing) {
        return self.item.onBeginEditing(self.item);
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    
    if (self.item.onEndEditing) {
        return self.item.onEndEditing(self.item);
    }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if (self.item.onReturn && [text isEqualToString:@"\n"]) {
        
        if (self.item.onReturn) {
            self.item.onReturn(self.item);
        }
        
        [textView resignFirstResponder];
        
        return NO;
    }
    
    if (self.item.onChangeCharacterInRange) {
        return self.item.onChangeCharacterInRange(self.item, range, text);
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    
    self.item.value = textView.text;
    
    if (self.item.onChange)
        self.item.onChange(self.item);
}
@end
