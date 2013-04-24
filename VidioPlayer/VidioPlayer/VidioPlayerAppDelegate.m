//
//  VidioPlayerAppDelegate.m
//  VidioPlayer
//
//  Created by shi feng on 13-3-15.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import "VidioPlayerAppDelegate.h"
#import "MainViewController.h"
#import "CatelogViewController.h"
#import "SearchViewController.h"
#import "Reachability.h"
#import "Constants.h"
#import "APIEngine.h"
#import "InitViewController.h"

@implementation VidioPlayerAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachChanged:) name:kReachabilityChangedNotification object:nil];
    hostReach = [Reachability reachabilityWithHostName:MAIN];
    [hostReach startNotifier];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.tabBarController = [[UITabBarController alloc] init];
//    
//    MainViewController *mainController = [[MainViewController alloc] initWithStyle:UITableViewStylePlain];
//    UINavigationController *mainNavigation = [[UINavigationController alloc] initWithRootViewController:mainController];
//    mainNavigation.navigationBar.tintColor = [UIColor colorWithRed:20/255.0 green:20/255.0 blue:20/255.0 alpha:1];
//    
//    CatelogViewController *catelogController = [[CatelogViewController alloc] initWithStyle:UITableViewStylePlain];
//    UINavigationController *catelogNavigation = [[UINavigationController alloc] initWithRootViewController:catelogController];
//    catelogNavigation.navigationBar.tintColor = [UIColor colorWithRed:20/255.0 green:20/255.0 blue:20/255.0 alpha:1];
//    
//    SearchViewController *searchController = [[SearchViewController alloc] init];
//    UINavigationController *searchNavigation = [[UINavigationController alloc] initWithRootViewController:searchController];
//    searchNavigation.navigationBar.tintColor = [UIColor colorWithRed:20/255.0 green:20/255.0 blue:20/255.0 alpha:1];
//    
//    self.tabBarController.viewControllers = [NSArray arrayWithObjects:mainNavigation,catelogNavigation,searchNavigation, nil];
    
//    [self.window addSubview:self.tabBarController.view];
    InitViewController *con = [[InitViewController alloc] init];
    [con.view setFrame:self.window.bounds];
    
    self.window.rootViewController = con;
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [APIEngine activeEngineWithAppKey:APPID_56 Secret:SECRET_56];
    
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
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络正在连接" message:statusString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void) theAnimation
{
    [UIView animateWithDuration:1.0 animations:^{
        startImageView.frame = CGRectMake(self.window.frame.origin.x, self.window.frame.size.height, -self.window.frame.size.width, -self.window.frame.size.height);
    }];
}

- (void) allFonts
{
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily) {
        NSLog(@"Family name: %@",[familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:[UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indFamily]]];
        for (indFont = 0; indFont < [fontNames count]; ++indFont) {
            NSLog(@"    Font name: %@",[fontNames objectAtIndex:indFont]);
        }
    }
}
@end
