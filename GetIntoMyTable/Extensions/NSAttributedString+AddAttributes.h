//
//  NSAttributedString+AddAttributes.h
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/29/21.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface NSAttributedString (AddAttributes)

- (NSAttributedString *)withFont:(UIFont *)font;
- (NSAttributedString *)withPrimaryColor:(UIColor *)primaryColor;
- (NSAttributedString *)withStrokeColor:(UIColor *)strokeColor;
- (NSAttributedString *)withStrokeWidth:(CGFloat)strokeWidth;

@end
