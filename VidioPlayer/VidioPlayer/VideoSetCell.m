//
//  VideoSetCell.m
//  VidioPlayer
//
//  Created by shi feng on 13-4-9.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import "VideoSetCell.h"
#import "Constants.h"

@interface VideoSetCell()

@end

@implementation VideoSetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
//    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void) initDraw:(UIImage *)image introduce:(NSString *)introduce detail:(NSString *)detail index:(int) cellIndex
{
//    self.imageView.image = image;
    UIImageView *myView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, CATELOG_IMAGE_WIDTH, CATELOG_IMAGE_HEIGHT)];
    myView.image = image;
    
    self.introduceLabel.text = introduce;
    self.detailLabel.text = detail;
    
    UIFont *introduceFont = [UIFont fontWithName:@"HiraginoSansGB-W6" size:14];
    [self.introduceLabel setFont:introduceFont];
    
    UIFont *detailFont = [UIFont fontWithName:@"HiraginoSansGB-W6" size:12];
    [self.detailLabel setFont:detailFont];
    
    [self addSubview:myView];
    self.button.tag = cellIndex;
}

- (IBAction) clickView:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(clickedVideoCellSend:)])
    {
        [self.delegate clickedVideoCellSend:sender.tag];
    }
}
@end
