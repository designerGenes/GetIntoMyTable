//
//  ArticleCollectionViewCell.m
//  GetIntoMyTable
//
//  Created by Jaden Nation on 6/2/21.
//

#import "ArticleCollectionViewCell.h"
#import "Article.h"
#import "CacheHandler.h"

@interface ArticleCollectionViewCell ()
@property (strong, nonatomic) UIImageView *articleImageView;
@property (strong, nonatomic) UILabel *bodyLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation ArticleCollectionViewCell

- (void)configureWithArticle:(Article *)article isPrimary:(BOOL)isPrimary {
    int fontSize = 16;
    if (isPrimary) {
        fontSize = 24;
    }
    
    
    self.bodyLabel.hidden = !isPrimary;
    self.titleLabel.attributedText = [[Article cleanText:article.title] withFont:[UIFont boldSystemFontOfSize:fontSize]];
    if (isPrimary) {
        self.bodyLabel.attributedText = [[Article cleanText:article.summaryHTML] withFont:[UIFont boldSystemFontOfSize:16]];
    }
    
    UIImage *cachedImage = [CacheHandler.sharedInstance.imageCache objectForKey:[NSURL URLWithString:article.featuredImageUrl]];
    if (cachedImage) {
        self.articleImageView.image = cachedImage;
    } else {
        [self.articleImageView downloadImageAtURL:[NSURL URLWithString:article.featuredImageUrl] completion:^(UIImage *image) {
            [CacheHandler.sharedInstance.imageCache setObject:image forKey:article.featuredImageUrl];
        }];
    }
    
}

-(void)prepareForReuse {
    [super prepareForReuse];
    self.articleImageView.image = nil;
    self.bodyLabel.text = nil;
    self.titleLabel.text = nil;
}

- (UIImageView *)articleImageView {
    if (!_articleImageView) {
        _articleImageView = [UIImageView new];
        _articleImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _articleImageView;
}

- (void)setup {
    self.bodyLabel = [UILabel new];
    self.titleLabel = [UILabel new];
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.bodyLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.bodyLabel.numberOfLines = 2;
    for (UIView *someView in @[self.articleImageView, self.bodyLabel, self.titleLabel]) {
        [self.contentView addSubview:someView];
        someView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    [NSLayoutConstraint activateConstraints:@[
        [self.articleImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
        [self.articleImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
        [self.articleImageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
        [self.articleImageView.bottomAnchor constraintEqualToAnchor:self.titleLabel.topAnchor constant:8],
        
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:4],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-4],
        [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.bodyLabel.topAnchor constant:8],
        
        [self.bodyLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:4],
        [self.bodyLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-4],
        [self.bodyLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-8],
    ]];
}

@end
