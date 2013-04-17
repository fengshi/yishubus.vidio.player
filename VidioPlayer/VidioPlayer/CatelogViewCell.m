//
//  CatelogViewCell.m
//  VidioPlayer
//
//  Created by shi feng on 13-4-10.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import "CatelogViewCell.h"

@implementation CatelogViewCell

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

- (void) initDraw: (NSString *) imageUrl introduce:(NSString *) introduce
{
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    self.introduce.text = introduce;
    
    UIFont *introduceFont = [UIFont fontWithName:@"HiraginoSansGB-W6" size:14];
    [self.introduce setFont:introduceFont];
}
@end