//
//  VidioPlayerAppDelegate.m
//  VidioPlayer
//
//  Created by shi feng on 13-3-15.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import "VidioPlayerAppDelegate.h"
#import "MainViewController.h"
#import "Reachability.h"
#import "Constants.h"

@implementation VidioPlayerAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachChanged:) name:kReachabilityChangedNotification object:nil];
    hostReach = [Reachability reachabilityWithHostName:MAIN];
    [hostReach startNotifier];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.tabBarController = [[UITabBarController alloc] init];
    
    MainViewController *mainController = [[MainViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *mainNavigation = [[UINavigationController alloc] initWithRootViewController:mainController];
    
    MainViewController *tmpController = [[MainViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *tmpNavigation = [[UINavigationController alloc] initWithRootViewController:tmpController];
    
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:mainNavigation,tmpNavigation, nil];
    
    [self.window addSubview:self.tabBarController.view];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    startImageView = [[UIImageView alloc] initWithFrame:self.window.frame];
    startImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Default" ofType:@"png"]];
    
    [self.window addSubview:startImageView];
    [self performSelector:@selector(theAnimation) withObject:nil afterDelay:5];
    
    return YES;
}

- (void) reachChanged: (NSNotification *)note
{
    Reachability *curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    NSString *statusString;
    
    switch (status) {
        case NotReachable:
            statusString = @"您没有网络连接!";
            break;
        case ReachableViaWiFi:
            statusString = @"您正在使用WiFi网络!";
            break;
        case ReachableViaWWAN:
            statusString = @"您正在使用3G网络!";
            break;
        default:
            break;
    }
    
    if (status == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络正在连接" message:statusString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void) theAnimation
{
    [UIView animateWithDuration:1.0 animations:^{
        startImageView.frame = CGRectMake(self.window.frame.origin.x, self.window.frame.size.height, -self.window.frame.size.width, -self.window.frame.size.height);
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
