//
//  MainColumnCell.h
//  VidioPlayer
//
//  Created by shi feng on 13-4-1.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainColumnDelegate <NSObject>

@optional
- (void) clickedColumnImageSend: (int) mid;
@end

@interface MainColumnCell : UITableViewCell <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;

@property (strong, nonatomic) NSMutableArray *imageArrays;
@property (nonatomic, weak) id<MainColumnDelegate> delegate;

- (void) initDraw:(NSMutableArray *) array;

@end
