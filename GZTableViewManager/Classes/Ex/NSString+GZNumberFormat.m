//
//  NSString+GZNumberFormat.m
//  GZTableViewManager
//
//  Created by GR on 2018/10/26.
//  Copyright © 2018 Harry. All rights reserved.
//

#import "NSString+GZNumberFormat.h"

@implementation NSString (GZNumberFormat)

- (NSString *)gz_stringWithNumberFormat:(NSString *)format {
    
    if (self.length == 0 || format.length == 0)
        return self;
    
    format = [format stringByAppendingString:@"X"];
    NSString *string = [self stringByAppendingString:@"0"];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\D" options:NSRegularExpressionCaseInsensitive error:NULL];
    NSString *stripped = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, string.length) withTemplate:@""];
    
    NSMutableArray *patterns = [[NSMutableArray alloc] init];
    NSMutableArray *separators = [[NSMutableArray alloc] init];
    [patterns addObject:@0];
    
    NSInteger maxLength = 0;
    for (NSInteger i = 0; i < [format length]; i++) {
        NSString *character = [format substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"X"]) {
            maxLength++;
            NSNumber *number = [patterns objectAtIndex:patterns.count - 1];
            number = @(number.integerValue + 1);
            [patterns replaceObjectAtIndex:patterns.count - 1 withObject:number];
        } else {
            [patterns addObject:@0];
            [separators addObject:character];
        }
    }
    
    if (stripped.length > maxLength)
        stripped = [stripped substringToIndex:maxLength];
    
    NSString *match = @"";
    NSString *replace = @"";
    
    NSMutableArray *expressions = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < patterns.count; i++) {
        NSString *currentMatch = [match stringByAppendingString:@"(\\d+)"];
        match = [match stringByAppendingString:[NSString stringWithFormat:@"(\\d{%ld})", (long)((NSNumber *)patterns[i]).integerValue]];
        
        NSString *template;
        if (i == 0) {
            template = [NSString stringWithFormat:@"$%li", (long)i+1];
        } else {
            unichar separatorCharacter = [separators[i-1] characterAtIndex:0];
            template = [NSString stringWithFormat:@"\\%C$%li", separatorCharacter, (long)i+1];
            
        }
        replace = [replace stringByAppendingString:template];
        [expressions addObject:@{@"match": currentMatch, @"replace": replace}];
    }
    
    NSString *result = [stripped copy];
    
    for (NSDictionary *exp in expressions) {
        NSString *match = exp[@"match"];
        NSString *replace = exp[@"replace"];
        NSString *modifiedString = [stripped stringByReplacingOccurrencesOfString:match
                                                                       withString:replace
                                                                          options:NSRegularExpressionSearch
                                                                            range:NSMakeRange(0, stripped.length)];
        
        if (![modifiedString isEqualToString:stripped])
            result = modifiedString;
    }
    
    return [result substringWithRange:NSMakeRange(0, result.length - 1)];
}

@end