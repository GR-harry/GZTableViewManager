//
//  GZTableViewTextItem.h
//  GZTableViewManager
//
//  Created by GR on 2018/10/23.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "GZTableViewItem.h"

@interface GZTextItem : GZTableViewItem

// Data
@property (copy, nonatomic) NSString *value;
@property (copy, nonatomic) NSString *placeholder;

// TextField Setting
@property (assign, nonatomic) UITextFieldViewMode clearButtonMode;                              // default is UITextFieldViewModeNever
@property (assign, nonatomic) BOOL                clearsOnBeginEditing;                         // default is NO which moves cursor to location clicked. if YES, all text cleared
@property (assign, nonatomic) NSUInteger          charactersLimit;

// Apperance
@property (assign, nonatomic) UITextBorderStyle     borderStyle;
@property (strong, nonatomic) UIColor               *valueColor;
@property (strong, nonatomic) UIFont                *valueFont;

// Keyboard Setting
@property (assign, nonatomic) UITextAutocapitalizationType  autocapitalizationType;
@property (assign, nonatomic) UITextAutocorrectionType      autocorrectionType ;
@property (assign, nonatomic) UITextSpellCheckingType       spellCheckingType;
@property (assign, nonatomic) UIKeyboardType                keyboardType;
@property (assign, nonatomic) UIKeyboardAppearance          keyboardAppearance;
@property (assign, nonatomic) UIReturnKeyType               returnKeyType;
@property (assign, nonatomic) BOOL                          enablesReturnKeyAutomatically;
@property (assign, nonatomic) BOOL                          secureTextEntry;


// Actions
@property (copy, nonatomic) BOOL (^onBeginEditing)(GZTextItem *item);
@property (copy, nonatomic) BOOL (^onEndEditing)(GZTextItem *item);
@property (copy, nonatomic) void (^onChange)(GZTextItem *item);
@property (copy, nonatomic) BOOL (^onReturn)(GZTextItem *item);
@property (copy, nonatomic) BOOL (^onChangeCharacterInRange)(GZTextItem *item, NSRange range, NSString *replacementString);

// Init
+ (instancetype)itemWithText:(NSString *)text
                       value:(NSString *)value;

+ (instancetype)itemWithText:(NSString *)text
                        value:(NSString *)value
                  placeholder:(NSString *)placeholder;

- (instancetype)initWithText:(NSString *)text
             value:(NSString *)value;

- (instancetype)initWithText:(NSString *)text
             value:(NSString *)value
       placeholder:(NSString *)placeholder;

@end
