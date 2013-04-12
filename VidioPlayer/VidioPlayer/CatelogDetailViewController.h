//
//  CatelogDetailViewController.h
//  VidioPlayer
//
//  Created by shi feng on 13-4-12.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "CatelogDetailViewCell.h"

@interface CatelogDetailViewController : UITableViewController <EGORefreshTableHeaderDelegate,CatelogDetailViewDelegate> {
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}

- (void) initDraw: (int) columnId;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end