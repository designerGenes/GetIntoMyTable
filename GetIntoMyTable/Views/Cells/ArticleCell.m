//
//  ArticleCell.m
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/27/21.
//

#import "ArticleCell.h"
#import "Article.h"
#import "UIImageView+Download.h"
#import "NSAttributedString+AddAttributes.h"
#import "UIView+Constrain.h"

@interface ArticleCell ()

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) UILabel *bodyLabel;
@property (strong, nonatomic) UIImageView *articleImageView;

@end

@implementation ArticleCell

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
    }
    return _titleLabel;
}

- (UILabel *)bodyLabel {
    if (!_bodyLabel) {
        _bodyLabel = [UILabel new];
    }
    return _bodyLabel;
}

- (UIImageView *)articleImageView {
    if (!_articleImageView) {
        _articleImageView = [UIImageView new];
        _articleImageView.contentMode = UIViewContentModeScaleToFill;
        _articleImageView.layer.masksToBounds = YES;
    }
    
    return _articleImageView;
}

- (void)configureWithArticle:(Article *)article isPrimary:(BOOL)isPrimary {
    /**
     The first article should take prominence at the top and
     1. display the image,
     2. title on one line with the rest ellipsed and
     3. the first two lines of the summary with the rest ellipsed if necessary.

     Each article after should be displayed underneath the main article and
     1. represented by the image and
     2. title underneath (rendering at most 2 lines of the title with the rest ellipsed if necessary
     
     */
    
    self.titleLabel.attributedText = [[Article cleanText:article.title] withFont:[UIFont boldSystemFontOfSize:16]];
    self.bodyLabel.attributedText = [[Article cleanText:article.summaryHTML] withFont:[UIFont systemFontOfSize:14]];
    self.titleLabel.numberOfLines = isPrimary ? 1 : 2;
    self.bodyLabel.numberOfLines = 2;
    NSURL *imageURL = [NSURL URLWithString:article.featuredImageUrl];
    [self.articleImageView downloadImageAtURL:imageURL];
    self.articleImageView.alpha = 0.5;
    
    [self.contentView sendSubviewToBack:self.articleImageView];
}

- (UIColor *)backgroundGrayWithDegree:(NSUInteger)grayDegree {
    NSDictionary *bgGrays = @{
        @0: UIColor.systemGrayColor,
        @1: UIColor.systemGray2Color,
        @2: UIColor.systemGray3Color,
        @3: UIColor.systemGray4Color,
        @4: UIColor.systemGray5Color,
        @5: UIColor.systemGray6Color,
    };
    if (grayDegree < bgGrays.allKeys.count) {
        return bgGrays[@(grayDegree)];
    }
    return UIColor.grayColor;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.articleImageView.image = nil;
}

- (void)setup {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.articleImageView.backgroundColor = UIColor.systemGray4Color;
    self.clipsToBounds = YES;
    for (UIView *view in @[self.articleImageView, self.bodyLabel, self.titleLabel]) {
        [self.contentView addSubview:view];
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    [self.articleImageView fixToAllSidesInView:self.contentView obeyingSafeArea:NO];
    [self.contentView sendSubviewToBack:self.articleImageView];
    [NSLayoutConstraint activateConstraints:@[
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:8],
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:4],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:8],
        [self.bodyLabel.leadingAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor],
        [self.bodyLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:4],
        [self.bodyLabel.bottomAnchor constraintLessThanOrEqualToAnchor:self.contentView.bottomAnchor constant:16],
        [self.bodyLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:8],
        [self.articleImageView.heightAnchor constraintGreaterThanOrEqualToConstant:320],
    ]];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

@end
