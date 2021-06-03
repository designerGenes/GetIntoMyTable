//
//  FeedPresenter.h
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/27/21.
//

#import <Foundation/Foundation.h>
#import "HTTPHandler.h"
#import <UIKit/UIKit.h>
#import "FeedView.h"

@class Feed;

@interface FeedPresenter : NSObject <HTTPHandlerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) Feed *lastKnownFeed;
- (void)reloadData;
- (void)viewDidBecomeReady:(id<FeedView>)view;

@end


