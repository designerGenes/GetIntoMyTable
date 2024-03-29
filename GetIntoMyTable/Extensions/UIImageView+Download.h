//
//  UIImageView+Download.h
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/28/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Download)
- (void)downloadImageAtURL:(NSURL *)url completion:(void(^ _Nullable)(UIImage *))callback;
@end

NS_ASSUME_NONNULL_END
