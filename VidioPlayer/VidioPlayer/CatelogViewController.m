//
//  CatelogViewController.m
//  VidioPlayer
//
//  Created by shi feng on 13-4-10.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import "CatelogViewController.h"
#import "Constants.h"
#import "NetworkData.h"
#import "RequestURL.h"
#import "CatelogViewCell.h"
#import "MainColumnObject.h"
#import "CatelogDetailViewController.h"

@interface CatelogViewController ()

@end

@implementation CatelogViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"分类";
        
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"分类" image:nil tag:0];
        [item setFinishedSelectedImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bar1" ofType:@"png"]] withFinishedUnselectedImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bar1" ofType:@"png"]]];
        self.tabBarItem = item;
    }
    return self;
}

- (void) loadArrays
{
    dispatch_queue_t downloadQueue = dispatch_queue_create("catelogArray", nil);
    dispatch_async(downloadQueue, ^{
        
        NSString *titleUrl = [RequestURL getUrlByKey:CATELOG_URL];
        catelogArray = [NetworkData catelogData:titleUrl];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadArrays];
    
    [self.tableView setBackgroundColor:MAIN_SECTION_BACKGROUND_COLOR];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    if (_refreshHeaderView == nil)
    {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - self.tableView.bounds.size.height, self.view.frame.size.width, self.view.frame.size.height)];
        view.delegate = self;
        [self.tableView addSubview:view];
        _refreshHeaderView = view;
    }
    
    [_refreshHeaderView refreshLastUpdatedDate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [catelogArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"catelogViewCell";
    UINib *nib = [UINib nibWithNibName:@"CatelogViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    CatelogViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    MainColumnObject *vo = [catelogArray objectAtIndex:[indexPath row]];
    [cell initDraw:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:vo.columnImageUrl]]] introduce:vo.columnName];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainColumnObject *vo = [catelogArray objectAtIndex:[indexPath row]];
    
    CatelogDetailViewController *controller = [[CatelogDetailViewController alloc] init];
    [controller initDraw:vo.columnId];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)reloadTableViewDataSource
{
    [self loadArrays];
    _reloading = YES;
}

- (void)doneLoadingTableViewData
{
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void) egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:2.0];
}

- (BOOL) egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return _reloading;
}

- (NSDate *) egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}

@end
