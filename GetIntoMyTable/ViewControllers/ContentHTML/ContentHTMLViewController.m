//
//  ContentHTMLViewController.m
//  GetIntoMyTable
//
//  Created by Jaden Nation on 6/3/21.
//

#import "ContentHTMLViewController.h"
#import "Article.h"

@interface ContentHTMLViewController ()
@property (nonatomic, strong) UITextView *contentTextView;

@end

@implementation ContentHTMLViewController

- (UITextView *)contentTextView {
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc] initWithFrame:self.view.frame textContainer:nil];
        
        _contentTextView.textAlignment = NSTextAlignmentLeft;
    }
    
    return _contentTextView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.contentTextView];
    self.contentTextView.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentTextView.attributedText = [Article cleanText:self.article.contentHTML];
    [NSLayoutConstraint activateConstraints:@[
        [self.contentTextView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:16],
        [self.contentTextView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:16],
        [self.contentTextView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-16],
        [self.contentTextView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-16]
    ]];
    [self.view layoutIfNeeded];
    
    
    self.contentTextView.editable = NO;
    self.navigationItem.title = self.article.title;
}

@end
