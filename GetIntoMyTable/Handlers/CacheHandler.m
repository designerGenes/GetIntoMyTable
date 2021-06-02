//
//  CacheHandler.m
//  GetIntoMyTable
//
//  Created by Jaden Nation on 6/2/21.
//

#import "CacheHandler.h"

@implementation CacheHandler
- (NSMutableDictionary *)imageCache {
    if (!_imageCache) {
        _imageCache = [NSMutableDictionary new];
    }
    return _imageCache;
}

+ (CacheHandler *)sharedInstance {
    static CacheHandler *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [CacheHandler new];
    });
    return sharedInstance;
}

@end
