//
//  Feed.m
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/27/21.
//

#import "Feed.h"
#import "Article.h"

@implementation Feed

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.version = dictionary[@"version"];
        self.userComment = dictionary[@"user_comment"];
        self.homePageURL = dictionary[@"home_page_url"];
        self.feedURL = dictionary[@"feed_url"];
        self.title = dictionary[@"title"];
        self.feedDescription = dictionary[@"description"];
        NSArray *itemsArray = dictionary[@"items"];
        NSMutableArray *typedItemsArray = [NSMutableArray new];
        for (NSDictionary *item in itemsArray) {
            Article *nextArticle = [[Article alloc] initWithDictionary:item];
            [typedItemsArray addObject:nextArticle];
        }
        self.items = typedItemsArray;
        
    }
    return self;
    
}

-(NSString *)debugDescription {
    return [NSString stringWithFormat:@"Feed with %d Articles", @(self.items.count).intValue];
}

@end
