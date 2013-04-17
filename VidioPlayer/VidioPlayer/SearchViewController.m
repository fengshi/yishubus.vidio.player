//
//  SearchViewController.m
//  VidioPlayer
//
//  Created by shi feng on 13-4-17.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
{
    UISearchBar *mySearchBar;
    UITableView *searchTableView;
}
@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"搜索";
        
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"搜索" image:nil tag:0];
        [item setFinishedSelectedImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bar1" ofType:@"png"]] withFinishedUnselectedImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bar1" ofType:@"png"]]];
        self.tabBarItem = item;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    mySearchBar.delegate = self;
    mySearchBar.backgroundColor = [UIColor clearColor];
    mySearchBar.barStyle = UIBarStyleBlackTranslucent;
    mySearchBar.keyboardType = UIKeyboardTypeDefault;
    
    searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 40) style:UITableViewStylePlain];
    searchTableView.delegate = self;
    searchTableView.dataSource = self;
    
    searchTableView.userInteractionEnabled = YES;
    
    searchTableView.tableHeaderView = mySearchBar;
    UITapGestureRecognizer *tableGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCloseKeyBoard:)];
    
    [searchTableView addGestureRecognizer:tableGesture];
    
    [self.view addSubview:searchTableView];
//    searchBar.showsCancelButton = YES;
    
//    [self.view addSubview:searchBar];
}

- (void) clickCloseKeyBoard: (UITapGestureRecognizer *) gesture
{
    [mySearchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    NSLog(@"%@",searchBar.text);
    NSLog(@"search.....");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

@end
