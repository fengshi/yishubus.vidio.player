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
#import "APIEngine.h"

@interface VideoSetController : UIViewController <UITableViewDataSource,UITableViewDelegate,VideoSetDelegate,APIEngineDelegate>

@property (nonatomic, strong) MPMoviePlayerController *player;
@property (nonatomic, retain) APIEngine *engine;

- (void) initDraw: (int) mid;

@end