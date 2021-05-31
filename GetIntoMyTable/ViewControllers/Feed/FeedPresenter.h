//
//  FeedPresenter.h
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/27/21.
//

#import <Foundation/Foundation.h>
#import "HTTPHandler.h"
#import <UIKit/UIKit.h>

@class Feed;

@protocol FeedView

- (void)invalidateData:(Feed *)newData;
- (void)setIsLoading:(BOOL)isLoading;
- (void)navigateToBrowserWithURL:(NSURL *)url;
- (void)setTitleLabelText:(NSString *)titleLabelText; // TMP!

@end

@interface FeedPresenter : NSObject <HTTPHandlerDelegate, UITableViewDelegate, UITableViewDataSource>

- (void)reloadData;
- (void)viewDidBecomeReady:(id<FeedView>)view;

@end


