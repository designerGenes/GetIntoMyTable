//
//  Article.h
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/27/21.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property (nonatomic, strong) NSString *articleID;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSArray<NSString *> *categories;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *encodedTitle;
@property (nonatomic, strong) NSString *featuredImageUrl; // featuredImage
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *insightSummary;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *summaryHTML;
@property (nonatomic, strong) NSString *contentHTML;
@property (nonatomic, strong, readonly) NSDate *datePublished;
@property (nonatomic, strong, readonly) NSDate *dateModified;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSArray<NSString *> *authors;
@property (nonatomic, strong) NSArray<NSString *> *tags;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSAttributedString *)cleanText:(NSString *)rawText;

@end


