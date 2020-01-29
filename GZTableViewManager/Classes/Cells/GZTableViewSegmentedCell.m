//
//  GZTableViewSegmentedCell.m
//  GZTableViewManager
//
//  Created by GR Harry on 2020/1/24.
//

#import "GZTableViewSegmentedCell.h"


@interface GZTableViewSegmentedCell ()

@property (strong, readwrite, nonatomic) UISegmentedControl *segmentedControl;
@property (strong, nonatomic) NSArray *horizontalConstraints;

@end

@implementation GZTableViewSegmentedCell

@dynamic item;

#pragma mark -
#pragma mark Lifecycle
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:self.item.segmentedControlTitles];
    self.segmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.segmentedControl addTarget:self action:@selector(segmentValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.segmentedControl];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentedControl
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1.0
                                                                  constant:0]];
}

- (void)cellWillAppear {
    
    self.textLabel.text = self.item.text;
    [self.segmentedControl removeAllSegments];

    if (self.horizontalConstraints) {
        // Clears previous constraints.
        [self.contentView removeConstraints:self.horizontalConstraints];
    }
    CGFloat margin =  15.0;
    NSDictionary *metrics = @{@"margin": @(margin)};
    if (self.item.text.length > 0) {
        self.horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_segmentedControl(>=140)]-margin-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_segmentedControl)];
    } else {
        self.horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_segmentedControl]-margin-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_segmentedControl)];
    }
    [self.contentView addConstraints:self.horizontalConstraints];
    
    if (self.item.segmentedControlTitles.count > 0) {
        [self.item.segmentedControlTitles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
            [self.segmentedControl insertSegmentWithTitle:title atIndex:idx animated:NO];
        }];
    }
    else if (self.item.segmentedControlImages.count > 0) {
        [self.item.segmentedControlImages enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL *stop) {
            [self.segmentedControl insertSegmentWithImage:image atIndex:idx animated:NO];
        }];
    }
    self.segmentedControl.tintColor = self.item.tintColor;
    self.segmentedControl.selectedSegmentIndex = self.item.value;

    [self.segmentedControl setNeedsDisplay];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, self.textLabel.frame.size.width - self.segmentedControl.frame.size.width - 0 - 10.0, self.textLabel.frame.size.height);
    self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
}

#pragma mark -
#pragma mark Handle state

- (void)enableDidChanged:(BOOL)enabled {
    [super enableDidChanged:enabled];
    
    self.segmentedControl.enabled = enabled;
}


#pragma mark -
#pragma mark Handle events

- (void)segmentValueDidChange:(UISegmentedControl *)segmentedControlView
{
    self.item.value = segmentedControlView.selectedSegmentIndex;
    if (self.item.switchValueChangeHandler)
        self.item.switchValueChangeHandler(self.item);
}

@end
