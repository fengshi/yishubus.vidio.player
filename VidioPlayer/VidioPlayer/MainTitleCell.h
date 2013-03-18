//
//  MainTitleCell.h
//  VidioPlayer
//
//  Created by shi feng on 13-3-18.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainTitleDelegate <NSObject>

@optional
- (void) clickedImageSend: (int) mid;

@end
@interface MainTitleCell : UITableViewCell <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, weak) id<MainTitleDelegate> delegate;
@end
