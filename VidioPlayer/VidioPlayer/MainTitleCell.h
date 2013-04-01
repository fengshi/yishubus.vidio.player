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
- (void) clickedTitleImageSend: (int) mid;

@end
@interface MainTitleCell : UITableViewCell <UIScrollViewDelegate>
{
    UIScrollView *myScrollView;
    UIPageControl *pagecontrol;
    UILabel *label;
}

@property (strong,nonatomic) IBOutlet UIScrollView *myScrollView;
@property (strong,nonatomic) IBOutlet UIPageControl *pagecontrol;
@property (strong,nonatomic) IBOutlet UILabel *label;

@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, weak) id<MainTitleDelegate> delegate;

- (void) initDraw:(NSMutableArray *) array;

@end
