//
//  CatelogViewCell.h
//  VidioPlayer
//
//  Created by shi feng on 13-4-10.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatelogViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *introduce;

- (void) initDraw: (NSString *) imageUrl introduce:(NSString *) introduce;
@end
