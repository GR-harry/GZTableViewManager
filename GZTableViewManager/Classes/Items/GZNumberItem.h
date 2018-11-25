//
//  GZNumberItem.h
//  GZTableViewManager
//
//  Created by GR on 2018/10/26.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZTableViewItem.h"
#import "GZTextItem.h"

@interface GZNumberItem : GZTextItem

@property (nonatomic, copy) NSString *format;

- (instancetype)initWithText:(NSString *)text
                       value:(NSString *)value
                      format:(NSString *)format
                 placeholder:(NSString *)placeholder;

+ (instancetype)itemWithText:(NSString *)text
                       value:(NSString *)value
                      format:(NSString *)format
                 placeholder:(NSString *)placeholder;

@end

