//
//  VideoSetCell.h
//  VidioPlayer
//
//  Created by shi feng on 13-4-9.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VideoSetDelegate <NSObject>

@optional
- (void) clickedVideoCellSend: (int) mid;
@end

@interface VideoSetCell : UITableViewCell

@property (strong,nonatomic) IBOutlet UILabel *introduceLabel;
@property (strong,nonatomic) IBOutlet UILabel *detailLabel;
@property (strong,nonatomic) IBOutlet UIButton *button;

@property (nonatomic, weak) id<VideoSetDelegate> delegate;

- (void) initDraw: (UIImage *) image introduce:(NSString *) introduce detail:(NSString *) detail index:(int) cellIndex;

- (IBAction)clickView:(UIButton *)sender;

@end