//
//  CollectionViewFeedPresenter.h
//  GetIntoMyTable
//
//  Created by Jaden Nation on 6/2/21.
//

#import "FeedPresenter.h"
@class Feed;

@interface CollectionViewFeedPresenter : NSObject <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, HTTPHandlerDelegate>

@property (nonatomic, strong) Feed *lastKnownFeed;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
- (void)reloadData;
- (void)viewDidBecomeReady:(id<FeedView>)view;

@end

