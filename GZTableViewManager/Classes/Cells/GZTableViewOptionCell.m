//
//  GZTableViewOptionCell.m
//  GZTableViewManager
//
//  Created by GR Harry on 2020/1/23.
//

#import "GZTableViewOptionCell.h"

@interface GZTableViewOptionCell ()

@property (strong, readwrite, nonatomic) UILabel *valueLabel;

@property (assign, nonatomic) BOOL enabled;

@end

@implementation GZTableViewOptionCell

@synthesize item = _item;
@synthesize enabled = _enabled;

#pragma mark -
#pragma mark Lifecycle

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.accessoryType                      = UITableViewCellAccessoryDisclosureIndicator;
    
    self.valueLabel                         = [[UILabel alloc] initWithFrame:CGRectZero];
    self.valueLabel.font                    = [UIFont systemFontOfSize:17];
    self.valueLabel.backgroundColor         = [UIColor clearColor];
    self.valueLabel.textColor               = self.detailTextLabel.textColor;
    self.valueLabel.highlightedTextColor    = [UIColor whiteColor];
    self.valueLabel.textAlignment           = NSTextAlignmentRight;
    [self.contentView addSubview:self.valueLabel];
}

- (void)cellWillAppear
{
    //[super cellWillAppear];
    self.accessoryType              = self.item.accessorType;
    self.textLabel.backgroundColor  = [UIColor clearColor];
    self.textLabel.text             = self.item.text.length > 0 ? self.item.text : @"";
    self.detailTextLabel.text       = @"";
    self.valueLabel.text            = self.item.detailText;
    
    if (!self.item.text) {
        self.valueLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    self.enabled = self.item.enabled;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat minWidth        = [self.valueLabel.text sizeWithAttributes:@{ NSFontAttributeName: self.valueLabel.font }].width;
    CGRect frame            = [self calculateFrameWithMinimumWidth:minWidth];
    
    frame.size.width        += 10.0;
    self.valueLabel.frame   = frame;
}

#pragma mark -
#pragma mark Handle state
- (void)enableDidChanged:(BOOL)enabled {
    [super enableDidChanged:enabled];
    
    self.valueLabel.enabled = enabled;
}

@end
