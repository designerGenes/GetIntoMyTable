//
//  ArticleCollectionViewCell.m
//  GetIntoMyTable
//
//  Created by Jaden Nation on 6/2/21.
//

#import "ArticleCollectionViewCell.h"
#import "Article.h"
#import "CacheHandler.h"
#import "CollectionViewFeedPresenter.h"

@interface ArticleCollectionViewCell ()
@property (strong, nonatomic) UIImageView *articleImageView;
@property (strong, nonatomic) UILabel *bodyLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation ArticleCollectionViewCell

- (UILabel *)bodyLabel {
    if (!_bodyLabel) {
        _bodyLabel = [UILabel new];
        _bodyLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:_bodyLabel];
    }
    return _bodyLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)articleImageView {
    if (!_articleImageView) {
        _articleImageView = [UIImageView new];
        _articleImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_articleImageView];
    }
    
    return _articleImageView;
}

- (void)configureWithArticle:(Article *)article section:(NSInteger)section presenter:(CollectionViewFeedPresenter *)presenter {
    [self setupForSection:section withPresenter:presenter];
    
    CGFloat titleFontSize = section < 1 ? 24 : 16;
    self.titleLabel.numberOfLines = section < 1 ? 1 : 2;
    self.titleLabel.text = [Article cleanText:article.title].string; //[[Article cleanText:article.title] withFont:[UIFont boldSystemFontOfSize:titleFontSize]];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:titleFontSize];
    self.bodyLabel.font = [UIFont systemFontOfSize:14];
    if (section < 1) {
        self.bodyLabel.text = [Article cleanText:article.summary].string; //[[Article cleanText:article.summary] withFont:[UIFont boldSystemFontOfSize:16]];
    }
    
    UIImage *cachedImage = [CacheHandler.sharedInstance.imageCache objectForKey:[NSURL URLWithString:article.featuredImageUrl]];
    if (cachedImage) {
        self.articleImageView.image = cachedImage;
    } else {
        [self.articleImageView downloadImageAtURL:[NSURL URLWithString:article.featuredImageUrl] completion:nil];
    }
    
}

-(void)prepareForReuse {
    [super prepareForReuse];
    for (UIView *aView in @[self.articleImageView, self.titleLabel, self.bodyLabel]) {
        [aView removeFromSuperview];
    }
    self.articleImageView = nil;
    self.titleLabel = nil;
    self.bodyLabel = nil;
}

- (void)setupForSection:(NSInteger)section withPresenter:(CollectionViewFeedPresenter *)presenter {
    self.backgroundColor = UIColor.whiteColor;
    for (UIView *someView in @[self.articleImageView, self.bodyLabel, self.titleLabel]) {
        someView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    self.bodyLabel.numberOfLines = 2;
    self.articleImageView.clipsToBounds = YES;
    CGFloat height = [presenter heightForCellInSection:section];
    CGFloat leftInset = 8;
    CGFloat rightInset = 8;
    CGFloat imageHeight = height * 0.6667;
    CGFloat titleLabelHeight = height * (section < 1 ? 0.1 : 0.3);
    CGFloat bodyLabelHeight = section < 1 ? height * 0.12 : 0;
    CGFloat topLabelInset = section < 1 ? 8 : 4;
    
    
    [NSLayoutConstraint activateConstraints:@[
        [self.articleImageView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.articleImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.articleImageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.articleImageView.heightAnchor constraintEqualToConstant:imageHeight],
        
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.articleImageView.bottomAnchor constant:topLabelInset],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:leftInset],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-rightInset],
        [self.titleLabel.heightAnchor constraintEqualToConstant:titleLabelHeight],
        
        [self.bodyLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor],
        [self.bodyLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:leftInset],
        [self.bodyLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-rightInset],
        [self.bodyLabel.heightAnchor constraintEqualToConstant:bodyLabelHeight],
    ]];

}

@end
