//
//  HTTPHandler.m
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/27/21.
//

#import "HTTPHandler.h"
#import "Feed.h"

@implementation HTTPHandler

- (void)fetchArticleFeed {
    NSString *remoteUrl = @"https://www.personalcapital.com/blog/feed/json";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:remoteUrl]];
    request.HTTPMethod = @"GET";
    NSURLSessionConfiguration *sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * response, NSError *  error) {
        NSError *jsonError;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        Feed *newFeed = [[Feed alloc] initWithDictionary:jsonDictionary];
        [weakSelf.delegate didReceiveArticleFeed:newFeed];
    }];
    [task resume];
}

@end
