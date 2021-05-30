//
//  Feed.h
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/27/21.
//

#import <Foundation/Foundation.h>
@class Article;

@interface Feed : NSObject

@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *userComment;
@property (nonatomic, strong) NSString *homePageURL;
@property (nonatomic, strong) NSString *feedURL;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *feedDescription;
@property (nonatomic, strong) NSArray<Article *> *items;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

