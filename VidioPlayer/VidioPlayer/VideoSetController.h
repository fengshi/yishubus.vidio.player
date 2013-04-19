//
//  VideoSetController.h
//  VidioPlayer
//
//  Created by shi feng on 13-4-3.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "VideoSetCell.h"

@interface VideoSetController : UIViewController <UITableViewDataSource,UITableViewDelegate,VideoSetDelegate>

@property (nonatomic, strong) MPMoviePlayerController *player;

- (void) initDraw: (int) mid;

@end