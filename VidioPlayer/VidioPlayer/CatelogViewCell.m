//
//  CatelogViewCell.m
//  VidioPlayer
//
//  Created by shi feng on 13-4-10.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import "CatelogViewCell.h"
#import "Constants.h"

@implementation CatelogViewCell
@synthesize introduceString;
@synthesize imageUrl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setIntroduceString:(NSString *)n
{
    if (![n isEqualToString:introduceString]) {
        introduceString = [n copy];
        self.introduce.text = introduceString;
    }
}

- (void) setImageUrl:(NSString *)iUrl
{
    if (![iUrl isEqualToString:imageUrl]) {
        imageUrl = [iUrl copy];
        UIImageView *myView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, CATELOG_IMAGE_WIDTH, CATELOG_IMAGE_HEIGHT)];
        myView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
        [self addSubview:myView];
    }
}


@end