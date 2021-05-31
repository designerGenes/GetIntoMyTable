//
//  UIView+Constrain.h
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/29/21.
//

#import <UIKit/UIKit.h>

@interface UIView (Constrain)
- (void)fixToAllSidesInView:(UIView *)container obeyingSafeArea:(BOOL)obeySafeArea;
- (void)centerPerfectlyInView:(UIView *)container;
@end

