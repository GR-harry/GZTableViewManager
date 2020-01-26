//
//  GZTableViewInlinPickerCell.m
//  GZTableViewManager
//
//  Created by GR on 2018/10/28.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZTableViewInlinePickerCell.h"
#import "GZPickerItem.h"

@interface GZTableViewInlinePickerCell ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UIPickerView  *pickerView;

@end

@implementation GZTableViewInlinePickerCell

@synthesize item = _item;

- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.pickerView             = [[UIPickerView alloc] initWithFrame:CGRectZero];
    self.pickerView.delegate    = self;
    self.pickerView.dataSource  = self;
    [self.contentView addSubview:self.pickerView];
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    [self.item.options enumerateObjectsUsingBlock:^(NSArray * _Nonnull values, NSUInteger compoentIdx, BOOL * _Nonnull stop) {
        NSInteger rowIdx = [values indexOfObject:self.item.value[compoentIdx]];
        
        if (rowIdx == NSNotFound) {
            rowIdx = 0;
        }
        
        [self.pickerView selectRow:rowIdx inComponent:compoentIdx animated:NO];
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.pickerView.frame = self.contentView.bounds;
}



#pragma mark - UIPickerViewDeleage & UIPickerViewDataSource
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

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40.f;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSArray *rowObjs            = self.item.options[component];
    id<GZPickerItemRow> rowObj  = rowObjs[row];
    
    // 更新 data
    NSMutableArray *valueCopy   = [NSMutableArray arrayWithArray:self.item.value];
    [valueCopy replaceObjectAtIndex:component withObject:rowObj];
    self.item.value  = [NSArray arrayWithArray:valueCopy];
    
    if (self.item.valueDidChangedHandler) {
        self.item.valueDidChangedHandler(self.item);
    }
}
@end
