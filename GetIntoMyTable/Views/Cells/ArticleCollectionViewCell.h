//
//  ArticleCollectionViewCell.h
//  GetIntoMyTable
//
//  Created by Jaden Nation on 6/2/21.
//

#import <UIKit/UIKit.h>
@class Article;

NS_ASSUME_NONNULL_BEGIN

@interface ArticleCollectionViewCell : UICollectionViewCell
- (void)configureWithArticle:(Article *)article isPrimary:(BOOL)isPrimary;
@end

NS_ASSUME_NONNULL_END
