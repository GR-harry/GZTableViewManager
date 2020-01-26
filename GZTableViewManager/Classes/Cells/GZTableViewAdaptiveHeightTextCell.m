//
//  GZTableViewAdaptiveHeightTextCell.m
//  GZTableViewManager
//
//  Created by GR Harry on 2020/1/26.
//

#import "GZTableViewAdaptiveHeightTextCell.h"
#import "GZTableViewCell+Private.h"

@interface GZTableViewAdaptiveHeightTextCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation GZTableViewAdaptiveHeightTextCell

@synthesize item = _item;

- (void)cellDidLoad {
    
    [super cellDidLoad];
    
    UILabel *titleLabel                                     = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.font                                         = [UIFont systemFontOfSize:17];
    titleLabel.textColor                                    = [UIColor blackColor];
    titleLabel.numberOfLines                                = 1;
    titleLabel.translatesAutoresizingMaskIntoConstraints    = NO;
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    
    UILabel *contentLabel                                   = [[UILabel alloc] initWithFrame:CGRectZero];
    contentLabel.textColor                                  = [UIColor lightGrayColor];
    contentLabel.numberOfLines                              = 0;
    contentLabel.translatesAutoresizingMaskIntoConstraints  = NO;
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

- (void)updateConstraints {
    
    switch (self.item.cellStyle) {
        case UITableViewCellStyleValue1: {
            
            {
                NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                        attribute:NSLayoutAttributeLeading
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.contentView
                                                                        attribute:NSLayoutAttributeLeading
                                                                       multiplier:1
                                                                         constant:15];
                
                NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.contentView
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:10];
                
                NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1
                                                                         constant:120];
                
                [self.contentView addConstraints:@[ left, top, width ]];
            }
            
            {
                NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.contentLabel
                                                                        attribute:NSLayoutAttributeLeading
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.titleLabel
                                                                        attribute:NSLayoutAttributeTrailing
                                                                       multiplier:1
                                                                         constant:10];

                NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.contentLabel
                                                                        attribute:NSLayoutAttributeTrailing
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.contentView
                                                                        attribute:NSLayoutAttributeTrailing
                                                                       multiplier:1
                                                                         constant:-15];

                NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.contentLabel
                                                                        attribute:NSLayoutAttributeTop
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.titleLabel
                                                                        attribute:NSLayoutAttributeTop
                                                                       multiplier:1
                                                                         constant:0];

                NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.contentLabel
                                                                          attribute:NSLayoutAttributeBottom
                                                                          relatedBy:NSLayoutRelationLessThanOrEqual
                                                                             toItem:self.contentView
                                                                          attribute:NSLayoutAttributeBottom
                                                                         multiplier:1
                                                                           constant:-10];

                [self.contentView addConstraints:@[ left, right, top, bottom ]];
            }
            
            break;
        }
        case UITableViewCellStyleSubtitle: {
            
            {
                NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                        attribute:NSLayoutAttributeLeading
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.contentView
                                                                        attribute:NSLayoutAttributeLeading
                                                                       multiplier:1
                                                                         constant:15];
                
                NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                        attribute:NSLayoutAttributeTrailing
                                                                        relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.contentView
                                                                         attribute:NSLayoutAttributeTrailing
                                                                        multiplier:1
                                                                          constant:-15];
                
                NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.contentView
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:10];
                
                [self.contentView addConstraints:@[ left, right, top ]];
            }
            
            {
                NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.contentLabel
                                                                        attribute:NSLayoutAttributeLeading
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.titleLabel
                                                                        attribute:NSLayoutAttributeLeading
                                                                       multiplier:1
                                                                         constant:0];

                NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.contentLabel
                                                                        attribute:NSLayoutAttributeTrailing
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.contentView
                                                                        attribute:NSLayoutAttributeTrailing
                                                                       multiplier:1
                                                                         constant:-15];

                NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.contentLabel
                                                                        attribute:NSLayoutAttributeTop
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.titleLabel
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1
                                                                         constant:10];

                NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.contentLabel
                                                                          attribute:NSLayoutAttributeBottom
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.contentView
                                                                          attribute:NSLayoutAttributeBottom
                                                                         multiplier:1
                                                                           constant:-10];

                [self.contentView addConstraints:@[ left, right, top, bottom ]];
            }
            break;
        }
        default:
            NSLog(@"Adaptive height cell don't support for %d cell style.", (int)self.item.cellStyle);
            break;
    }
    

    [super updateConstraints];
}


- (void)cellWillAppear {
    
    self.selectionStyle             = self.item.selectionStyle;
    
    self.userInteractionEnabled     = self.item.enabled;
    
    self.titleLabel.textAlignment   = self.item.textAlignment;
    self.titleLabel.text            = self.item.text;
    
    self.contentLabel.text          = self.item.detailText;
    
    self.enabled                    = self.item.enabled;
    
    switch (self.item.cellStyle) {
        case UITableViewCellStyleValue1:
            self.contentLabel.font = [UIFont systemFontOfSize:15];
            break;
        case UITableViewCellStyleSubtitle:
            self.contentLabel.font = [UIFont systemFontOfSize:13];
            break;
        default:
            break;
    }
    
    [self updateConstraints];
}

@end
