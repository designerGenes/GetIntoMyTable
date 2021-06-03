//
//  FeedView.h
//  GetIntoMyTable
//
//  Created by Jaden Nation on 6/2/21.
//

#ifndef FeedView_h
#define FeedView_h
@class Feed, Article;

@protocol FeedView

- (void)invalidateData:(Feed *)newData;
- (void)setIsLoading:(BOOL)isLoading;
- (void)navigateToBrowserWithURL:(NSURL *)url;
- (void)navigateToViewArticle:(Article *)article;

@end

#endif /* FeedView_h */
