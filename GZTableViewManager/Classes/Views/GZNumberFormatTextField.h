//
//  GZNumberFormatTextField.h
//  GZTableViewManager
//
//  Created by GR on 2018/10/26.
//  Copyright © 2018 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GZNumberFormatTextField : UITextField

@property (nonatomic, copy) NSString *format;

@property (readonly) NSString *unformattedText;

@end

