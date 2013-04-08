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
