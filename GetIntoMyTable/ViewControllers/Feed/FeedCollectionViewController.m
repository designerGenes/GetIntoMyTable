//
//  FeedCollectionViewController.m
//  GetIntoMyTable
//
//  Created by Jaden Nation on 6/2/21.
//

#import "FeedCollectionViewController.h"
#import "Article.h"
#import "Feed.h"
#import "CollectionViewFeedPresenter.h"
#import "ArticleCollectionViewCell.h"
@import SafariServices;


@interface FeedCollectionViewController ()
@property (nonatomic, strong) UICollectionView *feedCollectionView;
@property (nonatomic, strong) CollectionViewFeedPresenter *presenter;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@end

@implementation FeedCollectionViewController

- (UICollectionView *)feedCollectionView {
    if (!_feedCollectionView) {
        _feedCollectionView = [UICollectionView new];
        _feedCollectionView.dataSource = self.presenter;
        _feedCollectionView.delegate = self.presenter;
        [_feedCollectionView registerClass:ArticleCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(ArticleCollectionViewCell.class)];
    }
    
    return _feedCollectionView;
}

- (void)installConstraints {
    [self.view addSubview:self.feedCollectionView];
    [self.view coverSelfEntirelyWith:self.feedCollectionView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [CollectionViewFeedPresenter new];
    [self installConstraints];
    self.navigationItem.title = @"Research & Inlights";
    [self.presenter viewDidBecomeReady:self];
}


- (void)invalidateData:(id)newData {
    [self.feedCollectionView reloadData];
}

- (void)navigateToBrowserWithURL:(NSURL *)url {
    SFSafariViewController *webViewController = [[SFSafariViewController alloc] initWithURL:url];
    
    [self.navigationController presentViewController:webViewController animated:YES completion:nil];
}

- (void)setIsLoading:(BOOL)isLoading {
    self.feedCollectionView.hidden = isLoading;
    self.feedCollectionView.userInteractionEnabled = !isLoading;
    if (isLoading) {
        self.activityIndicator = [UIActivityIndicatorView new];
        self.activityIndicator.color = UIColor.blackColor;
        [self.view insertSubview:self.activityIndicator belowSubview:self.feedCollectionView];
        [self.activityIndicator startAnimating];
    } else {
        __weak typeof(self) weakSelf = self;
        dispatch_after(2, dispatch_get_main_queue(), ^{
            weakSelf.feedCollectionView.alpha = 1;
            weakSelf.feedCollectionView.userInteractionEnabled = YES;
            [weakSelf.activityIndicator stopAnimating];
            [weakSelf.activityIndicator removeFromSuperview];
        });
    }
}

- (void)setTitleLabelText:(NSString *)titleLabelText {
    //
}



- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.activityIndicator.frame = CGRectMake(0, 0, 160, 160);
    self.activityIndicator.center = self.view.center;
     
}


@end
