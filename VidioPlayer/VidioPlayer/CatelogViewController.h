//
//  CatelogViewController.h
//  VidioPlayer
//
//  Created by shi feng on 13-4-10.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface CatelogViewController : UITableViewController <EGORefreshTableHeaderDelegate> {
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    NSMutableArray *catelogArray;
}

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
