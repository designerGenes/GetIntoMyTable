//
//  FeedPresenter.m
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/27/21.
//

#import "FeedPresenter.h"
#import <UIKit/UIKit.h>
#import "Feed.h"
#import "ArticleCell.h"
#import "Article.h"
#import "AppDelegate.h"

@interface FeedPresenter () 

@property (nonatomic, weak) id<FeedView> view;
@property (nonatomic, strong) HTTPHandler *httpHandler;
@property (nonatomic, strong) Feed *lastKnownFeed;
@property (nonatomic, assign) BOOL lastScrollWasUp;


@end

@implementation FeedPresenter

- (HTTPHandler *)httpHandler {
    if (!_httpHandler) {
        _httpHandler = [HTTPHandler new];
        _httpHandler.delegate = self;
    }
    return _httpHandler;
}

- (void)viewDidBecomeReady:(id<FeedView>)view {
    self.view = view;
    [self reloadData];
}

- (void)reloadData {
    self.lastKnownFeed = nil;
    [self.view invalidateData:self.lastKnownFeed];
    [self.view setIsLoading:YES];
    [self.httpHandler fetchArticleFeed];
}


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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lastKnownFeed.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = NSStringFromClass(ArticleCell.class);
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    BOOL isPrimary = indexPath.row < 1;
    [cell configureWithArticle:self.lastKnownFeed.items[indexPath.row] isPrimary:isPrimary];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Article *chosenArticle = [self.lastKnownFeed.items objectAtIndex:indexPath.row];
    NSURL *destinationURL = [NSURL URLWithString:chosenArticle.url];
    [self.view navigateToBrowserWithURL:destinationURL];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    let divisor = AppDelegate.sharedInstance.deviceIsIpad ? 3 : 2;
    return tableView.frame.size.height / divisor;
}


@end
