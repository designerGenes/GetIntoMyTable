//
//  NSString+Extension.m
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/30/21.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (NSMutableAttributedString *)mutableAttributedString {
    return [[NSMutableAttributedString alloc] initWithString:self];
}

@end
