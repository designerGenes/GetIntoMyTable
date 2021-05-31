//
//  NSAttributedString+AddAttributes.m
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/29/21.
//

#import "NSAttributedString+AddAttributes.h"


@implementation NSAttributedString (AddAttributes)

- (NSMutableAttributedString *)mutableCopyOrSelf {
    if ([self isKindOfClass:NSMutableAttributedString.class]) {
        return (NSMutableAttributedString *) self;
    } else {
        return [[NSMutableAttributedString alloc] initWithAttributedString:self];
    }
}

- (NSAttributedString *)withFont:(UIFont *)font  {
    NSMutableAttributedString *mut = self.mutableCopyOrSelf;
    [mut addAttribute:NSFontAttributeName
                    value:font
                    range:NSMakeRange(0, self.string.length)
    ];
    return mut;
}

- (NSAttributedString *)withPrimaryColor:(UIColor *)primaryColor {
    NSMutableAttributedString *mut = self.mutableCopyOrSelf;
    [mut addAttribute:NSForegroundColorAttributeName
                    value:primaryColor
                    range:NSMakeRange(0, self.string.length)];
    return mut;
}

- (NSAttributedString *)withStrokeColor:(UIColor *)strokeColor {
    NSMutableAttributedString *mut = self.mutableCopyOrSelf;
    [mut addAttribute:NSStrokeColorAttributeName
                    value:strokeColor
                    range:NSMakeRange(0, self.string.length)];
    return mut;
}

- (NSAttributedString *)withStrokeWidth:(CGFloat)strokeWidth {
    NSMutableAttributedString *mut = self.mutableCopyOrSelf;
    [mut addAttribute:NSStrokeWidthAttributeName
                    value:@(strokeWidth)
                    range:NSMakeRange(0, self.string.length)];
    return mut;
}

@end
