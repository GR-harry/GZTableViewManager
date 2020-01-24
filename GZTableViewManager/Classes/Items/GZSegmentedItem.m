//
//  GZSegmentedItem.m
//  GZTableViewManager
//
//  Created by GR Harry on 2020/1/24.
//

#import "GZSegmentedItem.h"

@implementation GZSegmentedItem

+ (instancetype)itemWithText:(NSString *)text
      segmentedControlTitles:(NSArray *)titles
                       value:(NSInteger)value
    switchValueChangeHandler:(void(^)(GZSegmentedItem *item))switchValueChangeHandler {
    
    return [[self alloc] initWithText:text segmentedControlTitles:titles value:value switchValueChangeHandler:switchValueChangeHandler];
}

- (id)initWithText:(NSString *)text
segmentedControlTitles:(NSArray *)titles
             value:(NSInteger)value
switchValueChangeHandler:(void(^)(GZSegmentedItem *item))switchValueChangeHandler {
    
    self = [super init];
    if (!self)
        return nil;
    
    self.text = text;
    self.segmentedControlTitles = titles;
    self.value = value;
    self.switchValueChangeHandler = switchValueChangeHandler;
    
    return self;
}

+ (instancetype)itemWithText:(NSString *)text
      segmentedControlImages:(NSArray *)images
                       value:(NSInteger)value
    switchValueChangeHandler:(void(^)(GZSegmentedItem *item))switchValueChangeHandler {
    
    return [[self alloc] initWithText:text segmentedControlImages:images value:value switchValueChangeHandler:switchValueChangeHandler];
}

- (id)initWithText:(NSString *)text
segmentedControlImages:(NSArray *)images
             value:(NSInteger)value
switchValueChangeHandler:(void(^)(GZSegmentedItem *item))switchValueChangeHandler {
    
    self = [super init];
    if (!self)
        return nil;
    
    self.text = text;
    self.segmentedControlImages = images;
    self.value = value;
    self.switchValueChangeHandler = switchValueChangeHandler;
    
    return self;
}

@end
