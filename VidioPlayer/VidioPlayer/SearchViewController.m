//
//  SearchViewController.m
//  VidioPlayer
//
//  Created by shi feng on 13-4-17.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import "SearchViewController.h"
#import "MainTitleObject.h"
#import "Constants.h"
#import "NetworkData.h"
#import "RequestURL.h"
#import "VideoSetController.h"

@interface SearchViewController ()
{
    UISearchBar *mySearchBar;
    UITableView *searchTableView;
    NSMutableArray *array;
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
    tableGesture.delegate = self;
    [searchTableView addGestureRecognizer:tableGesture];
    
    [self.view addSubview:searchTableView];

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
    
    NSString *titleUrl = [RequestURL getUrlByKey:SEARCH_URL];
    array = [NetworkData searchData:titleUrl searchText:searchBar.text];
    
    [searchTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    MainTitleObject *obj = [array objectAtIndex:[indexPath row]];
    cell.textLabel.text = obj.introduce;

    return cell;
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
//    NSLog(@"%@",[touch.view class]);
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    [mySearchBar resignFirstResponder];
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainTitleObject *vo = [array objectAtIndex:[indexPath row]];

    VideoSetController *controller = [[VideoSetController alloc] init];
    [controller initDraw:vo.mid];
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
