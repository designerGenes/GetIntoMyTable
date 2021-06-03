//
//  UIImageView+Download.m
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/28/21.
//

#import "UIImageView+Download.h"
#import "CacheHandler.h"

@implementation UIImageView (Download)

- (void)downloadImageAtURL:(NSURL *)url completion:(void(^ _Nullable)(UIImage *))callback {
    UIActivityIndicatorView *activityIndicator;
    if (self.superview) {
        activityIndicator = [UIActivityIndicatorView new];
        [self.superview addSubview:activityIndicator];
        [activityIndicator centerPerfectlyInView:self.superview];
        [activityIndicator startAnimating];
    }
    
    __weak typeof(self) weakSelf = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [activityIndicator stopAnimating];
            [activityIndicator removeFromSuperview];
            UIImage *image = [UIImage imageWithData:data];
            if (data && !error && image) {
                weakSelf.image = image;
                [CacheHandler.sharedInstance.imageCache setObject:image forKey:url];
            }
            if (callback) callback(image);
        });
    }];
    [task resume];
    
}

@end
