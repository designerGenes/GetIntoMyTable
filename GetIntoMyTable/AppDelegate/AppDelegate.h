//
//  AppDelegate.h
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/27/21.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
+ (instancetype)sharedInstance;
- (BOOL)deviceIsIpad;
@end

