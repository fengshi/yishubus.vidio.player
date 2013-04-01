//
//  MainViewController.h
//  VidioPlayer
//
//  Created by shi feng on 13-3-18.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTitleCell.h"
#import "MainColumnCell.h"
#import "EGORefreshTableHeaderView.h"

@interface MainViewController : UITableViewController <MainTitleDelegate,MainColumnDelegate,EGORefreshTableHeaderDelegate> {
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}

@property (strong, nonatomic) NSMutableArray *columnArray;
@property (retain, nonatomic) NSMutableArray *titleArray;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
