//
//  UIImageView+Download.m
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/28/21.
//

#import "UIImageView+Download.h"

@implementation UIImageView (Download)

- (void)downloadImageAtURL:(NSURL *)url {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:data];
            if (data && !error && image) {
                self.image = image;
            }
        });
    }];
    [task resume];
    
}

@end
