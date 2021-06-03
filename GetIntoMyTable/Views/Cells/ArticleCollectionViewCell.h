//
//  ArticleCollectionViewCell.h
//  GetIntoMyTable
//
//  Created by Jaden Nation on 6/2/21.
//

#import <UIKit/UIKit.h>
@class Article, CollectionViewFeedPresenter;

NS_ASSUME_NONNULL_BEGIN

@interface ArticleCollectionViewCell : UICollectionViewCell
- (void)configureWithArticle:(Article *)article section:(NSInteger)section presenter:(CollectionViewFeedPresenter *)presenter;
@end

NS_ASSUME_NONNULL_END
