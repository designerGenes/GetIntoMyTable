//
//  ArticleCell.h
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/27/21.
//

#import <UIKit/UIKit.h>
@class Article;

@interface ArticleCell : UITableViewCell

- (void)configureWithArticle:(Article *)article isPrimary:(BOOL)isPrimary;
- (UIColor *)backgroundGrayWithDegree:(NSUInteger)grayDegree;
@end


