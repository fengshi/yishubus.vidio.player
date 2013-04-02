//
//  VidioPlayerAppDelegate.h
//  VidioPlayer
//
//  Created by shi feng on 13-3-15.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Reachability;

@interface VidioPlayerAppDelegate : UIResponder <UIApplicationDelegate> {
    UIImageView *startImageView;
    Reachability *hostReach;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
