//
//  GZTableViewNumberCell.m
//  GZTableViewManager
//
//  Created by GR on 2018/10/26.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZTableViewNumberCell.h"
#import "GZNumberItem.h"
#import "GZNumberFormatTextField.h"
#import "NSString+GZNumberFormat.h"
#import "GZTableViewManager.h"

@interface GZTableViewNumberCell ()<UITextFieldDelegate>

@property (strong, nonatomic) GZNumberFormatTextField *textField;

@end

@implementation GZTableViewNumberCell
@synthesize item = _item;

#pragma mark - Life cycle
- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.textField          = [[GZNumberFormatTextField alloc] initWithFrame:CGRectZero];
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [self.contentView addSubview:self.textField];
    
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.textLabel.text = self.item.text;
    
    self.textField.borderStyle                      = self.item.borderStyle;
    self.textField.textColor                        = self.item.valueColor;
    self.textField.placeholder                      = self.item.placeholder;
    self.textField.font                             = self.item.valueFont;
    self.textField.autocapitalizationType           = self.item.autocapitalizationType;
    self.textField.autocorrectionType               = self.item.autocorrectionType;
    self.textField.spellCheckingType                = self.item.spellCheckingType;
    self.textField.keyboardType                     = self.item.keyboardType;
    self.textField.keyboardAppearance               = self.item.keyboardAppearance;
    self.textField.returnKeyType                    = self.item.returnKeyType;
    self.textField.enablesReturnKeyAutomatically    = self.item.enablesReturnKeyAutomatically;
    self.textField.secureTextEntry                  = self.item.secureTextEntry;
    self.textField.clearButtonMode                  = self.item.clearButtonMode;
    self.textField.clearsOnBeginEditing             = self.item.clearsOnBeginEditing;
    self.textField.format                           = self.item.format;
    self.textField.text                             = [self.item.value gz_stringWithNumberFormat:self.item.format];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textField.frame = [self calculateFrameWithMinimumWidth:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        [self.textField becomeFirstResponder];
    }
}

- (void)enableDidChanged:(BOOL)enabled {
    
    self.userInteractionEnabled = enabled;
    self.textField.enabled      = enabled;
    self.textLabel.enabled      = enabled;
}

#pragma mark - Actions
- (void)textDidChanged:(GZNumberFormatTextField *)textField {
    self.item.value = textField.unformattedText;
    
    if (self.item.onChange) {
        self.item.onChange(self.item);
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [self.tableViewManager.tableView scrollToRowAtIndexPath:self.item.indexPath
                                           atScrollPosition:UITableViewScrollPositionTop
                                                   animated:YES];
    
    if (self.item.onBeginEditing) {
        return self.item.onBeginEditing(self.item);
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if (self.item.onEndEditing) {
        self.item.onEndEditing(self.item);
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self endEditing:YES];
    
    if (self.item.onReturn) {
        return self.item.onReturn(self.item);
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (self.item.onChangeCharacterInRange) {
        return self.item.onChangeCharacterInRange(self.item, range, string);
    }
    
    return YES;
}
@end
