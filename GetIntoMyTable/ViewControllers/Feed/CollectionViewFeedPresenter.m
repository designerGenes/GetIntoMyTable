//
//  CollectionViewFeedPresenter.m
//  GetIntoMyTable
//
//  Created by Jaden Nation on 6/2/21.
//

#import "CollectionViewFeedPresenter.h"
#import "Feed.h"
#import "Article.h"
#import "FeedView.h"
#import "ArticleCollectionViewCell.h"
#import "AppDelegate.h"


@interface CollectionViewFeedPresenter ()
@property (nonatomic, weak) id<FeedView> view;
@property (nonatomic, strong) HTTPHandler *httpHandler;
@end

@implementation CollectionViewFeedPresenter

- (HTTPHandler *)httpHandler {
    if (!_httpHandler) {
        _httpHandler = [HTTPHandler new];
        _httpHandler.delegate = self;
    }
    return _httpHandler;
}

#pragma mark - UICollectionViewDelegate/DataSource/FlowLayout methods
- (UICollectionViewFlowLayout *)flowLayout {
    let flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.estimatedItemSize = CGSizeZero;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return flowLayout;
}

- (void)reloadData {
    self.lastKnownFeed = nil;
    [self.view invalidateData:self.lastKnownFeed];
    [self.view setIsLoading:YES];
    [self.httpHandler fetchArticleFeed];
}

- (void)viewDidBecomeReady:(id<FeedView>)view {
    self.view = view;
    [self reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 1) {
        let size = CGSizeMake(collectionView.bounds.size.width, [self heightForCellInSection:indexPath.section]);
        return size;
    }
    let nodesPerRow = AppDelegate.sharedInstance.deviceIsIpad ? 3 : 2;
    let flowLayout = (UICollectionViewFlowLayout *) collectionViewLayout;
    let inset = flowLayout.sectionInset.left + flowLayout.sectionInset.right + 16;
    let interItemSpace = (nodesPerRow - 1) * flowLayout.minimumInteritemSpacing;
    let width = (collectionView.bounds.size.width - inset - interItemSpace) / nodesPerRow;
    return CGSizeMake(width, [self heightForCellInSection:indexPath.section]);
}

- (CGFloat)heightForCellInSection:(NSInteger)section {
    if (section < 1) {
        return 400;
    }
    return 250;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section < 1) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 8, 0, 8);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    let itemCount = self.lastKnownFeed.items.count;
    if (itemCount < 1) {
        return 0;
    }
    return section < 1 ? 1 : itemCount - 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    let adjustedIdx = indexPath.section < 1 ? 0 : indexPath.row + 1;
    Article *chosenArticle = [self.lastKnownFeed.items objectAtIndex:adjustedIdx];
    NSURL *destinationURL = [NSURL URLWithString:chosenArticle.url];
    [self.view navigateToBrowserWithURL:destinationURL];
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = NSStringFromClass(ArticleCollectionViewCell.class);
    ArticleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    BOOL isPrimary = indexPath.section < 1;
    let rowIdx = isPrimary ? 0 : indexPath.row + 1;
    [cell configureWithArticle:self.lastKnownFeed.items[rowIdx] section:indexPath.section presenter:self];
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    let itemCount = self.lastKnownFeed.items.count;
    return itemCount < 1 ? 0 : itemCount < 2 ? 1 : 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return section < 1 ? CGSizeZero : CGSizeMake(collectionView.bounds.size.width, 32);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section > 0) {
        let headerView = [UIView new];
        headerView.backgroundColor = UIColor.orangeColor; // TMP!
        let label = [UILabel new];
        [headerView addSubview:label];
        label.text = @"Previous Articles";
        label.font = [UIFont boldSystemFontOfSize:16];
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textAlignment = NSTextAlignmentLeft;
        [label centerPerfectlyInView:headerView];
        return headerView;
    } else {
        return [UIView new];
    }
    
}

#pragma mark - HTTPHandlerDelegate methods
- (void)didReceiveArticleFeed:(Feed *)feed {
    self.lastKnownFeed = feed;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view setIsLoading:NO];
        [self.view invalidateData:self.lastKnownFeed];
    });
}

- (void)didSetIsLoadingRequest:(BOOL)isLoadingRequest {
    [self.view setIsLoading:isLoadingRequest];
}

@end
