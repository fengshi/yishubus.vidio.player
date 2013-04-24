//
//  InitViewController.m
//  VidioPlayer
//
//  Created by shi feng on 13-4-23.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import "InitViewController.h"
#import "MainViewController.h"
#import "CatelogViewController.h"
#import "SearchViewController.h"
#import "Reachability.h"
#import "Constants.h"
#import "APIEngine.h"

@interface InitViewController ()

@end

@implementation InitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController = [[UITabBarController alloc] init];
    [self.tabBarController.view setFrame:self.view.bounds];
    
    MainViewController *mainController = [[MainViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *mainNavigation = [[UINavigationController alloc] initWithRootViewController:mainController];
    mainNavigation.navigationBar.tintColor = [UIColor colorWithRed:20/255.0 green:20/255.0 blue:20/255.0 alpha:1];
    
    CatelogViewController *catelogController = [[CatelogViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *catelogNavigation = [[UINavigationController alloc] initWithRootViewController:catelogController];
    catelogNavigation.navigationBar.tintColor = [UIColor colorWithRed:20/255.0 green:20/255.0 blue:20/255.0 alpha:1];
    
    SearchViewController *searchController = [[SearchViewController alloc] init];
    UINavigationController *searchNavigation = [[UINavigationController alloc] initWithRootViewController:searchController];
    searchNavigation.navigationBar.tintColor = [UIColor colorWithRed:20/255.0 green:20/255.0 blue:20/255.0 alpha:1];
    
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:mainNavigation,catelogNavigation,searchNavigation, nil];
    
    [self.view addSubview:self.tabBarController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) shouldAutorotate
{
    return NO;
}


@end
