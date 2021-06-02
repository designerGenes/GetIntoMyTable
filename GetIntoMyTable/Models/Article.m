//
//  Article.m
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/27/21.
//

#import "Article.h"
#import "UIKit/UIKit.h"

@interface Article ()
@property (strong) NSString *rawDatePublished;
@property (strong) NSString *rawDateModified;
@property (strong, readonly) NSDateFormatter *dateFormatter;
@end

@implementation Article

@synthesize dateFormatter=_dateFormatter;

+ (NSAttributedString *)cleanText:(NSString *)rawText {
    if (rawText.length < 1) {
        return nil;
    }
    NSData *data = [rawText dataUsingEncoding:NSUTF16StringEncoding];
    NSError *error;
    NSAttributedString *cleaned = [[NSAttributedString alloc] initWithData:data
                                                                     options:@{
                                                                         NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType
                                                                     } documentAttributes:nil
                                                                       error:&error];
    return cleaned;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [NSDateFormatter new];
    }
    return _dateFormatter;
}


- (NSDate *)datePublished {
    return [self.dateFormatter dateFromString:self.rawDatePublished];
}

- (NSDate *)dateModified {
    return [self.dateFormatter dateFromString:self.rawDateModified];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.articleID = dictionary[@"id"];
        self.url = dictionary[@"url"];
        self.category = dictionary[@"category"];
        self.categories = dictionary[@"categories"];
        self.title = dictionary[@"title"];
        self.encodedTitle = dictionary[@"encoded_title"];
        self.featuredImageUrl = dictionary[@"featured_image"];
        self.summary = dictionary[@"summary"];
        self.summaryHTML = dictionary[@"summary_html"];
        self.rawDatePublished = dictionary[@"date_published"];
        self.rawDateModified = dictionary[@"date_modified"];
        self.authors = dictionary[@"authors"];
        self.tags = dictionary[@"tags"];
    }
    return self;
}

@end
