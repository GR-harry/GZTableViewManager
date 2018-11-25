//
//  GZTableViewPickerCell.m
//  GZTableViewManager
//
//  Created by GR on 2018/10/28.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZTableViewPickerCell.h"
#import "GZPickerItem.h"
#import "GZTableViewManager.h"
#import "GZInlinePickerItem.h"
#import "GZTableViewSection.h"

@interface GZTableViewPickerCell ()<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UITextField           *textFieldWithBlank;
@property (strong, nonatomic) UIPickerView          *pickerView;
@property (strong, nonatomic) GZInlinePickerItem    *inlinePickerItem;
@property (assign, nonatomic) BOOL                  pickerDidPresented;

@end

@implementation GZTableViewPickerCell

- (void)cellDidLoad {
    [super cellDidLoad];

    self.pickerView             = [[UIPickerView alloc] initWithFrame:CGRectZero];
    self.pickerView.delegate    = self;
    self.pickerView.dataSource  = self;
    
    self.textFieldWithBlank             = [[UITextField alloc] initWithFrame:CGRectZero];
    self.textFieldWithBlank.delegate    = self;
    self.textFieldWithBlank.inputView   = self.pickerView;
    [self.contentView addSubview:self.textFieldWithBlank];
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    self.textLabel.text             = self.item.text;
    
    if (self.item.placeholder.length) {
        self.detailTextLabel.text   = self.item.placeholder;
    }
    else {
        self.detailTextLabel.text   = self.item.stringWithValueComponentsHandler(self.item.value);
    }
    
    self.detailTextLabel.textAlignment  = self.item.text.length ? NSTextAlignmentRight : NSTextAlignmentCenter;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat textLabelX = CGRectGetMinX(self.textLabel.frame);
    if (self.item.text.length) {
        
        CGFloat width           = [self.item.text
                                   sizeWithAttributes:@{ NSFontAttributeName : self.textLabel.font }].width;
        
        CGRect frame            = self.textLabel.frame;
        frame.size.width        = width;
        frame.origin.y          = (CGRectGetHeight(self.contentView.frame) - CGRectGetHeight(self.textLabel.frame)) * 0.5f;
        self.textLabel.frame    = frame;
    }
    
    CGFloat x                   = self.item.text.length ? (CGRectGetMaxX(self.textLabel.frame) + 20.f) : textLabelX;
    CGFloat y                   = CGRectGetMinY(self.textLabel.frame);
    CGFloat w                   = CGRectGetWidth(self.contentView.frame) - x - textLabelX;
    CGFloat h                   = CGRectGetHeight(self.contentView.frame) - 2 * y;
    self.detailTextLabel.frame  = CGRectMake(x, y, w, h);
}

- (void)enableDidChanged:(BOOL)enabled {
    
    [super enableDidChanged:enabled];
    
    self.textLabel.enabled                  = enabled;
    self.detailTextLabel.enabled            = enabled;
    self.pickerView.userInteractionEnabled  = enabled;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected && !self.item.inlinePicker) {
        
        [self.item deselectRowWithAnimated:NO];
        
        if (!self.pickerDidPresented) {
            
            [self.textFieldWithBlank becomeFirstResponder];
            
            [self.item.options enumerateObjectsUsingBlock:^(NSArray * _Nonnull values, NSUInteger compoentIdx, BOOL * _Nonnull stop) {
                NSInteger rowIdx = [values indexOfObject:self.item.value[compoentIdx]];
                rowIdx           = (rowIdx == NSNotFound) ? 0 : rowIdx;
                
                [self.pickerView selectRow:rowIdx inComponent:compoentIdx animated:NO];
            }];
            
            self.pickerDidPresented = YES;
        }
        else {
            [self.textFieldWithBlank resignFirstResponder];
            self.pickerDidPresented = NO;
        }
        
        return;
    }
    
    if (selected && self.item.inlinePicker) {
        
        [self.item deselectRowWithAnimated:NO];
        
        if (_inlinePickerItem) {
        
            NSIndexPath *indexPath = _inlinePickerItem.indexPath;
            
            [self.section removeItem:_inlinePickerItem];
            
            [self.tableViewManager.tableView
             deleteRowsAtIndexPaths:@[ indexPath ]
             withRowAnimation:UITableViewRowAnimationFade];
            
            _inlinePickerItem = nil;
        }
        else {
            
            [self.section insertItem:self.inlinePickerItem
                             atIndex:self.item.indexPath.row + 1];
            
            [self.tableViewManager.tableView
             insertRowsAtIndexPaths:@[self.inlinePickerItem.indexPath]
             withRowAnimation:UITableViewRowAnimationFade];
        }
        
        return;
    }
}

#pragma mark - Lazy
- (GZInlinePickerItem *)inlinePickerItem {
    
    if (!_inlinePickerItem) {
        
        __weak typeof(self) weakself = self;
        _inlinePickerItem =
        [GZInlinePickerItem
         itemWithText:nil
         value:self.item.value
         options:self.item.options
         valueDidChangedHandler:^(GZInlinePickerItem *item) {
             
             weakself.item.value            = item.value;
             
             // 更新 ui
             weakself.detailTextLabel.text  = weakself.item.stringWithValueComponentsHandler(weakself.item.value);
             
             if (weakself.item.valueDidChangedHandler) {
                 weakself.item.valueDidChangedHandler(weakself.item);
             }
         }];
    }
    return _inlinePickerItem;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [self.tableViewManager.tableView scrollToRowAtIndexPath:self.item.indexPath
                                           atScrollPosition:UITableViewScrollPositionTop
                                                   animated:YES];
    
    return YES;
}

#pragma mark - UIPickerDelegate & UIPickerDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.item.options.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *rowObjs = self.item.options[component];
    return rowObjs.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSArray *rowObjs            = self.item.options[component];
    id<GZPickerItemRow> rowObj  = rowObjs[row];
    
    return rowObj.title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSArray *rowObjs            = self.item.options[component];
    id<GZPickerItemRow> rowObj  = rowObjs[row];
    
    // 更新 data
    NSMutableArray *valueCopy   = [NSMutableArray arrayWithArray:self.item.value];
    [valueCopy replaceObjectAtIndex:component withObject:rowObj];
    self.item.value             = [NSArray arrayWithArray:valueCopy];
    
    // 更新 ui
    self.detailTextLabel.text   = self.item.stringWithValueComponentsHandler(self.item.value);
    
    if (self.item.valueDidChangedHandler) {
        self.item.valueDidChangedHandler(self.item);
    }
}

@end
