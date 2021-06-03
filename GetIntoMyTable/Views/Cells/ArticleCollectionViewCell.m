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
@property (strong, nonatomic) NSLayoutConstraint *bodyLabelHeightConstraint;
@end

@implementation ArticleCollectionViewCell

- (void)configureWithArticle:(Article *)article isPrimary:(BOOL)isPrimary {
    CGFloat titleFontSize = isPrimary ? 24 : 16;
    self.titleLabel.numberOfLines = isPrimary ? 1 : 2;
    self.bodyLabelHeightConstraint.constant = isPrimary ? 40 : 0;
    self.titleLabel.attributedText = [[Article cleanText:article.title] withFont:[UIFont boldSystemFontOfSize:titleFontSize]];
    if (isPrimary) {
        self.bodyLabel.attributedText = [[Article cleanText:article.summary] withFont:[UIFont boldSystemFontOfSize:16]];
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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
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
        _articleImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _articleImageView;
}

- (void)setup {
    self.backgroundColor = UIColor.lightGrayColor;
    self.bodyLabel = [UILabel new];
    self.titleLabel = [UILabel new];
    
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.bodyLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.bodyLabel.numberOfLines = 2;
    self.articleImageView.clipsToBounds = YES;
    for (UIView *someView in @[self.articleImageView, self.bodyLabel, self.titleLabel]) {
        [self.contentView addSubview:someView];
        someView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    CGFloat leftInset = 8;
    CGFloat rightInset = 8;
    CGFloat topInset = 16;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.articleImageView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.articleImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
        [self.articleImageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
        
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.articleImageView.bottomAnchor constant:topInset],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:leftInset],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:rightInset],
        [self.bodyLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:topInset],
        
        [self.bodyLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:leftInset],
        [self.bodyLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:rightInset],
        [self.bodyLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:16],
    ]];
    
    self.bodyLabelHeightConstraint = [self.bodyLabel.heightAnchor constraintGreaterThanOrEqualToConstant:40];
    [self.bodyLabelHeightConstraint setActive:YES];
}

@end
