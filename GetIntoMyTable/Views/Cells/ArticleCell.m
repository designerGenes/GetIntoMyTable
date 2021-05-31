//
//  ArticleCell.m
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/27/21.
//

#import "ArticleCell.h"
#import "Article.h"

@interface ArticleCell ()

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) UILabel *bodyLabel;
@property (strong, nonatomic) UIImageView *articleImageView;

@end

@implementation ArticleCell

- (UIImageView *)articleImageView {
    if (!_articleImageView) {
        _articleImageView = [UIImageView new];
        _articleImageView.contentMode = UIViewContentModeScaleAspectFill;
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
    self.titleLabel = [UILabel new];
    self.bodyLabel = [UILabel new];
    self.titleLabel.attributedText = [[Article cleanText:article.title]
                                      withFont:[UIFont boldSystemFontOfSize:26]];
    self.bodyLabel.attributedText = [[[[Article cleanText:article.summaryHTML]
                                        withFont:[UIFont boldSystemFontOfSize:18]]
                                       withPrimaryColor:UIColor.blackColor]
                                      withStrokeColor:UIColor.whiteColor];
    self.bodyLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleLabel.numberOfLines = isPrimary ? 1 : 2;
    self.bodyLabel.numberOfLines = 2;
    NSURL *imageURL = [NSURL URLWithString:article.featuredImageUrl];
    [self.articleImageView downloadImageAtURL:imageURL];
    self.articleImageView.alpha = 0.6;
    [self.contentView sendSubviewToBack:self.articleImageView];
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
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16],
        [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.contentView.centerYAnchor constant:-8],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-8],
        [self.bodyLabel.leadingAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor],
        [self.bodyLabel.topAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.bodyLabel.bottomAnchor constraintLessThanOrEqualToAnchor:self.contentView.bottomAnchor constant:16],
        [self.bodyLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-8],
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
