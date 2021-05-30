//
//  HTTPHandler.h
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/27/21.
//

#import <Foundation/Foundation.h>
@class Feed;

@protocol HTTPHandlerDelegate

- (void)didReceiveArticleFeed:(Feed *)feed;
- (void)didSetIsLoadingRequest:(BOOL)isLoadingRequest;

@end

@interface HTTPHandler : NSObject

@property (nonatomic, weak) id<HTTPHandlerDelegate> delegate;

- (void)fetchArticleFeed;

@end

