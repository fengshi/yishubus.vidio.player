//
//  CatelogDetailViewCell.h
//  VidioPlayer
//
//  Created by shi feng on 13-4-12.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CatelogDetailViewDelegate <NSObject>

@optional
- (void) clickedImageSend: (int) mid;

@end

@interface CatelogDetailViewCell : UITableViewCell {
    UIImageView *firstImageView;
    UIImageView *secondImageView;
    UIImageView *thirdImageView;
}

@property (strong, nonatomic) IBOutlet UIImageView *firstImageView;

@property (strong, nonatomic) IBOutlet UIImageView *secondImageView;

@property (strong, nonatomic) IBOutlet UIImageView *thirdImageView;

-(void) initDraw: (NSArray *) array;

@property (nonatomic, weak) id<CatelogDetailViewDelegate> delegate;
@end
