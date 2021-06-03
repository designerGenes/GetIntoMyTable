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
#import "ContentHTMLViewController.h"
@import SafariServices;


@interface FeedCollectionViewController ()
@property (nonatomic, strong) UICollectionView *feedCollectionView;
@property (nonatomic, strong) CollectionViewFeedPresenter *presenter;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@end

@implementation FeedCollectionViewController

- (UICollectionView *)feedCollectionView {
    if (!_feedCollectionView) {
        _feedCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.presenter.flowLayout];
        [_feedCollectionView registerClass:ArticleCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(ArticleCollectionViewCell.class)];
        [_feedCollectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(UICollectionReusableView.class)];
        _feedCollectionView.dataSource = self.presenter;
        _feedCollectionView.delegate = self.presenter;
        
        _feedCollectionView.backgroundColor = UIColor.systemGray2Color;
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
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"Research & Insights";
    [self.presenter viewDidBecomeReady:self];
}


- (void)invalidateData:(id)newData {
    [self.feedCollectionView reloadData];
}

- (void)navigateToBrowserWithURL:(NSURL *)url {
    SFSafariViewController *webViewController = [[SFSafariViewController alloc] initWithURL:url];
    [self.navigationController presentViewController:webViewController animated:YES completion:nil];
}

- (void)navigateToViewArticle:(Article *)article {
    let contentController = [ContentHTMLViewController new];
    contentController.article = article;
    [self.navigationController pushViewController:contentController animated:YES];
}

- (void)setIsLoading:(BOOL)isLoading {
    self.feedCollectionView.hidden = isLoading;
    if (isLoading) {
        self.activityIndicator = [UIActivityIndicatorView new];
        self.activityIndicator.color = UIColor.blackColor;
        [self.view insertSubview:self.activityIndicator belowSubview:self.feedCollectionView];
        [self.activityIndicator startAnimating];
    } else {
        __weak typeof(self) weakSelf = self;
        dispatch_after(2, dispatch_get_main_queue(), ^{
            weakSelf.feedCollectionView.userInteractionEnabled = YES;
            [weakSelf.activityIndicator stopAnimating];
            [weakSelf.activityIndicator removeFromSuperview];
        });
    }
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.activityIndicator.frame = CGRectMake(0, 0, 160, 160);
    self.activityIndicator.center = self.view.center;
     
}


@end
