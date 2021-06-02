//
//  CacheHandler.h
//  GetIntoMyTable
//
//  Created by Jaden Nation on 6/2/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CacheHandler : NSObject
@property (nonatomic, strong) NSMutableDictionary *imageCache;
+ (CacheHandler *)sharedInstance;
@end

NS_ASSUME_NONNULL_END
