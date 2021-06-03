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
@end

@implementation CollectionViewFeedPresenter

#pragma mark - UICollectionViewDelegate/DataSource/FlowLayout methods
- (UICollectionViewFlowLayout *)collectionFlowLayout {
    let flowLayout = [UICollectionViewFlowLayout new];
    return flowLayout;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 1) {
        let size = CGSizeMake(collectionView.bounds.size.width, 240);
        return size;
    }
    let nodesPerRow = AppDelegate.sharedInstance.deviceIsIpad ? 3 : 2;
    let flowLayout = (UICollectionViewFlowLayout *) collectionViewLayout;
    let inset = flowLayout.sectionInset.left + flowLayout.sectionInset.right;
    let interItemSpace = (nodesPerRow - 1) * flowLayout.minimumInteritemSpacing;
    let dimension = (collectionView.bounds.size.width - inset - interItemSpace) / nodesPerRow;
    return CGSizeMake(dimension, dimension);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.lastKnownFeed.items.count < 1) {
        return 0;
    }
    return section < 1 ? 1 : self.lastKnownFeed.items.count - 1;
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
    BOOL isPrimary = indexPath.row < 1;
    [cell configureWithArticle:self.lastKnownFeed.items[indexPath.row] isPrimary:isPrimary];
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section > 0) {
        let headerView = [UIView new];
        let label = [UILabel new];
        [headerView addSubview:label];
        label.text = @"Previous Articles";
        label.font = [UIFont boldSystemFontOfSize:16];
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textAlignment = NSTextAlignmentLeft;
        [NSLayoutConstraint activateConstraints:@[
            [label.topAnchor constraintEqualToAnchor:headerView.topAnchor constant:16],
            [label.bottomAnchor constraintEqualToAnchor:headerView.bottomAnchor constant:-16],
            [label.leadingAnchor constraintEqualToAnchor:headerView.leadingAnchor constant:8],
            [label.trailingAnchor constraintEqualToAnchor:headerView.trailingAnchor constant:-8],
        ]];
        return headerView;
    } else {
        return [UIView new];
    }
    
}




@end
