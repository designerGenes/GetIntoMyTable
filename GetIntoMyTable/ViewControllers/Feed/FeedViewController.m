//
//  ViewController.m
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/27/21.
//

#import "FeedViewController.h"
#import "ArticleCell.h"
#import "FeedPresenter.h"
#import "Article.h"
#import "Feed.h"
#import "UIView+Constrain.h"

@import SafariServices;


@interface FeedViewController () 

@property (nonatomic, strong) FeedPresenter *presenter;
@property (strong, nonatomic)  UILabel *feedTitleLabel;
@property (strong, nonatomic)  UIButton *reloadButton;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UITableView *feedTable;
@end

@implementation FeedViewController

- (IBAction)tappedReload:(UIButton *)sender {
    [self.presenter reloadData];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.presenter = [FeedPresenter new];
    }
    return self;
}

- (UITableView *)feedTable {
    if (!_feedTable) {
        _feedTable = [UITableView new];
        
        [_feedTable registerClass:ArticleCell.class forCellReuseIdentifier:NSStringFromClass(ArticleCell.class)];
        _feedTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _feedTable.dataSource = self.presenter;
        _feedTable.delegate = self.presenter;
    }
    
    return _feedTable;
}

- (UIButton *)reloadButton {
    if (!_reloadButton) {
        _reloadButton = [UIButton new];
        [_reloadButton setImage:[UIImage systemImageNamed:@"arrow.clockwise"] forState:UIControlStateNormal];
        [_reloadButton addTarget:self action:@selector(tappedReload:) forControlEvents:UIControlEventTouchUpInside];
        _reloadButton.tintColor = UIColor.darkGrayColor;
        }
    
    return _reloadButton;
}

- (void)installConstraints {
    for (UIView *view in @[self.feedTable, self.reloadButton, self.feedTitleLabel]) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:view];
    }
    UILayoutGuide *guide = self.view.safeAreaLayoutGuide;
    [NSLayoutConstraint activateConstraints:@[
        [self.feedTable.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [self.feedTable.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.feedTable.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.feedTable.topAnchor constraintEqualToAnchor:self.feedTitleLabel.bottomAnchor constant:24],
        [self.feedTitleLabel.topAnchor constraintEqualToAnchor:guide.topAnchor constant:16],
        [self.feedTitleLabel.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:16],
        [self.feedTitleLabel.trailingAnchor constraintLessThanOrEqualToAnchor:self.reloadButton.leadingAnchor constant:16],
        [self.reloadButton.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:-16],
        [self.reloadButton.centerYAnchor constraintEqualToAnchor:self.feedTitleLabel.centerYAnchor]
    ]];
}

#pragma MARK - lifecycle
- (void)viewDidLoad {
    self.feedTitleLabel = [UILabel new];
    self.navigationController.navigationBarHidden = YES;
    [super viewDidLoad];
    [self installConstraints];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.presenter viewDidBecomeReady:self];
    
}

#pragma MARK - FeedView
- (void)setTitleLabelText:(NSString *)titleLabelText {
    self.feedTitleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    self.feedTitleLabel.text = titleLabelText; // TMP!
}

- (void)invalidateData:(Feed *)newData {
    [self.feedTable reloadData];
    
    
    
    self.feedTitleLabel.attributedText = [[newData.title.mutableAttributedString
                                            withFont:[UIFont boldSystemFontOfSize:36]]
                                           withPrimaryColor:UIColor.blackColor];
}

- (void)navigateToBrowserWithURL:(NSURL *)url {
    SFSafariViewController *webViewController = [[SFSafariViewController alloc] initWithURL:url];
    
    [self.navigationController presentViewController:webViewController animated:YES completion:nil];
}

- (void)setIsLoading:(BOOL)isLoading {
    if (isLoading) {
        self.activityIndicator = [UIActivityIndicatorView new];
        self.activityIndicator.color = UIColor.blackColor;
        [self.view insertSubview:self.activityIndicator belowSubview:self.feedTable];
        self.feedTable.alpha = 0.15;
        self.feedTable.userInteractionEnabled = NO;
        [self.activityIndicator startAnimating];
    } else {
        __weak typeof(self) weakSelf = self;
        dispatch_after(2, dispatch_get_main_queue(), ^{
            weakSelf.feedTable.alpha = 1;
            weakSelf.feedTable.userInteractionEnabled = YES;
            [weakSelf.activityIndicator stopAnimating];
            [weakSelf.activityIndicator removeFromSuperview];
        });
        
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.activityIndicator.frame = CGRectMake(0, 0, 160, 160);
    self.activityIndicator.center = self.feedTable.center;
     
}


@end
