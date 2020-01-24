//
//  GZSegmentedItem.h
//  GZTableViewManager
//
//  Created by GR Harry on 2020/1/24.
//

#import "GZTableViewItem.h"

@interface GZSegmentedItem : GZTableViewItem

@property (assign, readwrite, nonatomic) NSInteger value;
@property (copy, readwrite, nonatomic) NSArray *segmentedControlTitles;
@property (copy, readwrite, nonatomic) NSArray *segmentedControlImages;
@property (strong, readwrite, nonatomic) UIColor *tintColor;
@property (copy, readwrite, nonatomic) void (^switchValueChangeHandler)(GZSegmentedItem *item);

+ (instancetype)itemWithText:(NSString *)text
      segmentedControlTitles:(NSArray *)titles
                       value:(NSInteger)value
    switchValueChangeHandler:(void(^)(GZSegmentedItem *item))switchValueChangeHandler;

- (id)initWithText:(NSString *)text
segmentedControlTitles:(NSArray *)titles
             value:(NSInteger)value
switchValueChangeHandler:(void(^)(GZSegmentedItem *item))switchValueChangeHandler;

+ (instancetype)itemWithText:(NSString *)text
      segmentedControlImages:(NSArray *)images
                       value:(NSInteger)value
    switchValueChangeHandler:(void(^)(GZSegmentedItem *item))switchValueChangeHandler;

- (id)initWithText:(NSString *)text
segmentedControlImages:(NSArray *)images
             value:(NSInteger)value
switchValueChangeHandler:(void(^)(GZSegmentedItem *item))switchValueChangeHandler;

@end
