//
//  MainViewController.m
//  VidioPlayer
//
//  Created by shi feng on 13-3-18.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import "MainViewController.h"
#import "NetworkData.h"
#import "MainTitleCell.h"
#import "Constants.h"
#import "RequestURL.h"
#import "MainTitleObject.h"
#import "MainColumnObject.h"

@interface MainViewController()

@end

@implementation MainViewController
@synthesize columnArray = _columnArray;
@synthesize titleArray = _titleArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) loadTitleArray
{
    NSString *titleUrl = [RequestURL getUrlByKey:MAIN_TITLE_URL];
    self.titleArray = [NetworkData mainTitleData:titleUrl];
}

- (void) loadColumnArray
{
    NSString *columnUrl = [RequestURL getUrlByKey:MAIN_COLUMN_URL];
    self.columnArray = [NetworkData mainColumnData:columnUrl];
    NSLog(@"%d",self.columnArray.count);
}

- (MainColumnObject *) fromColumnArrayGetObjectBySection:(NSInteger) section
{
    MainColumnObject *columnObj = [self.columnArray objectAtIndex:section-1];
    return columnObj;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadTitleArray];
    [self loadColumnArray];
    
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
    return [self.columnArray count] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        MainColumnObject *columnObj = [self fromColumnArrayGetObjectBySection:section];
        return [columnObj.columnDetails count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *mainTitle = @"maintitle";
    if (indexPath.section == 0) {
        UINib *nib = [UINib nibWithNibName:@"MainTitleCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:mainTitle];
        
        MainTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:mainTitle];
        [cell initDraw:self.titleArray];
        cell.delegate = self;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        MainColumnObject *cellObj = [self fromColumnArrayGetObjectBySection:[indexPath section]];
        MainTitleObject *thisTitle = [cellObj.columnDetails objectAtIndex:[indexPath row]];
        cell.textLabel.text = thisTitle.introduce;
        return cell;
    }
}

- (void) clickedImageSend:(int)mid
{
    NSLog(@"aaaa=%d",mid);
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return MAIN_TITLE_HEIGHT;
    }
    return MAIN_COLUMN_HEIGHT;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 20.0f;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *newView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    
    UIButton *button = [[UIButton alloc] initWithFrame:newView.frame];
    [button setBackgroundColor:[UIColor blackColor]];
    [button setAlpha:0.6f];
    [button addTarget:self action:@selector(columnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, 100, 20)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Arial" size:13];
    
    if (section > 0) {
        MainColumnObject *columnObj = [self fromColumnArrayGetObjectBySection:section];
        label.text = columnObj.columnName;
        button.tag = columnObj.columnId;
    }

    [newView addSubview:label];
    [newView addSubview:button];
    return newView;
}

- (void) columnClick: (UIButton *) clickButton
{
    NSLog(@"%d",clickButton.tag);
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"Nib name" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)reloadTableViewDataSource
{
    [self loadTitleArray];
    [self loadColumnArray];
    [self.tableView reloadData];
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
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
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
