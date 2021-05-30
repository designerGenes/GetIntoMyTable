//
//  NSAttributedString+AddAttributes.m
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/29/21.
//

#import "NSAttributedString+AddAttributes.h"

@implementation NSAttributedString (AddAttributes)

- (NSAttributedString *)withFont:(UIFont *)font  {
    NSMutableAttributedString *wrapper = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    [wrapper addAttribute:NSFontAttributeName
                    value:font
                    range:NSMakeRange(0, wrapper.length)
     ];
    return wrapper;
}

- (NSAttributedString *)withPrimaryColor:(UIColor *)primaryColor {
    NSMutableAttributedString *wrapper = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    [wrapper addAttribute:NSForegroundColorAttributeName
                    value:primaryColor
                    range:NSMakeRange(0, wrapper.length)];
    return wrapper;
}

@end
