//
//  UIView+Constrain.m
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/29/21.
//

#import "UIView+Constrain.h"

@implementation UIView (Constrain)

- (void)fixToAllSidesInView:(UIView *)container obeyingSafeArea:(BOOL)obeySafeArea {
    [container addSubview:self];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutXAxisAnchor *leadingAnchor = obeySafeArea ? container.safeAreaLayoutGuide.leadingAnchor : container.leadingAnchor;
    NSLayoutXAxisAnchor *trailingAnchor = obeySafeArea ? container.safeAreaLayoutGuide.trailingAnchor : container.trailingAnchor;
    NSLayoutYAxisAnchor *topAnchor = obeySafeArea ? container.safeAreaLayoutGuide.topAnchor : container.topAnchor;
    NSLayoutYAxisAnchor *bottomAnchor = obeySafeArea ? container.safeAreaLayoutGuide.bottomAnchor : container.bottomAnchor;
    [NSLayoutConstraint activateConstraints:@[
        [self.leadingAnchor constraintEqualToAnchor:leadingAnchor],
        [self.trailingAnchor constraintEqualToAnchor:trailingAnchor],
        [self.topAnchor constraintEqualToAnchor:topAnchor],
        [self.bottomAnchor constraintEqualToAnchor:bottomAnchor],
    ]];
}

- (void)centerPerfectlyInView:(UIView *)container {
    [container addSubview:self];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.centerYAnchor constraintEqualToAnchor:container.centerYAnchor],
        [self.centerXAnchor constraintEqualToAnchor:container.centerXAnchor],
    ]];
}

- (void)coverSelfEntirelyWith:(UIView *)coveringSubview  {
    [self addSubview:coveringSubview];
    coveringSubview.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [coveringSubview.topAnchor constraintEqualToAnchor:self.topAnchor],
        [coveringSubview.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [coveringSubview.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [coveringSubview.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
    ]];
}

@end
