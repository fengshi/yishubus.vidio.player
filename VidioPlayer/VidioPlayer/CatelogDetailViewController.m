//
//  CatelogDetailViewController.m
//  VidioPlayer
//
//  Created by shi feng on 13-4-12.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import "CatelogDetailViewController.h"
#import "Constants.h"
#import "RequestURL.h"
#import "NetworkData.h"
#import "CatelogDetailViewCell.h"
#import "VideoSetController.h"

@interface CatelogDetailViewController ()
{
    int pageNumber;
    int cId;
    NSMutableArray *initArray;
    NSMutableArray *loadArray;
}
@end

@implementation CatelogDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"艺术巴士";
    }
    return self;
}

- (void) initDraw: (int) columnId
{
    cId = columnId;
    pageNumber = 1;
    
    [self loadArrays];
}

- (void) loadArrays
{
    dispatch_queue_t downloadArray = dispatch_queue_create("catelogDetailArray", nil);
    dispatch_async(downloadArray, ^{
        NSString *titleUrl = [RequestURL getUrlByKey:CATELOG_DETAIL_URL];
        initArray = [NetworkData catelogDetailData:titleUrl columnId:cId number:pageNumber];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (_refreshHeaderView == nil)
    {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - self.tableView.bounds.size.height, self.view.frame.size.width, self.view.frame.size.height)];
        view.delegate = self;
        [self.tableView addSubview:view];
        _refreshHeaderView = view;
    }
    
    [_refreshHeaderView refreshLastUpdatedDate];
    [self.tableView setBackgroundColor:MAIN_SECTION_BACKGROUND_COLOR];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (NSArray *) cellArray: (int) row
{
    int index_ = 3 * row + 1;
    int end_ = index_ + 3;
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    
    for (int i = index_; i <end_ ; i++) {
        if ([initArray count] >= i) {
            [tmp addObject:[initArray objectAtIndex:i-1]];
        }
    }
    return tmp;
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
    int cellCount = 0;
    
    if ([initArray count] > 0)
    {
        if ([initArray count] % 3 == 0) {
            cellCount = [initArray count] / 3;
        } else {
            cellCount = [initArray count] / 3 + 1;
        }
        if (cellCount == 0) {
            cellCount = 1;
        }
    }
    
    return cellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *catelogDetailViewCell = @"catelogDetailViewCell";
    
    UINib *nib = [UINib nibWithNibName:@"CatelogDetailViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:catelogDetailViewCell];
        
    CatelogDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:catelogDetailViewCell];
    [cell initDraw:[self cellArray:[indexPath row]]];
    
    cell.delegate = self;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void) clickedImageSend:(int)mid
{
    VideoSetController *controller = [[VideoSetController alloc] init];
    [controller initDraw:mid];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Table view delegate

- (void)reloadTableViewDataSource
{
    [self loadArrays];
    //    [self.tableView reloadData];
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
