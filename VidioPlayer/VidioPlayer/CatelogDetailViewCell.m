//
//  CatelogDetailViewCell.m
//  VidioPlayer
//
//  Created by shi feng on 13-4-12.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import "CatelogDetailViewCell.h"
#import "MainTitleObject.h"
#import "Constants.h"

@implementation CatelogDetailViewCell
@synthesize firstImageView = _firstImageView;
@synthesize secondImageView = _secondImageView;
@synthesize thirdImageView = _thirdImageView;

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

-(void) initDraw: (NSArray *) array
{
    int count = [array count];
    for (int i=0; i<count; i++) {
        MainTitleObject *mm = [array objectAtIndex:i];
        if (i == 0) {
            self.firstImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:mm.imageUrl]]];
            self.firstImageView.tag = mm.mid;
            [self.firstImageView setUserInteractionEnabled:YES];

            UITapGestureRecognizer *touchViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchImageViewAction:)];
            [self.firstImageView addGestureRecognizer:touchViewGesture];
        }
        
        if (i == 1) {
            self.secondImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:mm.imageUrl]]];
            self.secondImageView.tag = mm.mid;
            [self.secondImageView setUserInteractionEnabled:YES];
            
            UITapGestureRecognizer *touchViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchImageViewAction:)];
            [self.secondImageView addGestureRecognizer:touchViewGesture];
        }
        
        if (i == 2) {
            self.thirdImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:mm.imageUrl]]];
            self.thirdImageView.tag = mm.mid;
            [self.thirdImageView setUserInteractionEnabled:YES];
            
            UITapGestureRecognizer *touchViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchImageViewAction:)];
            [self.thirdImageView addGestureRecognizer:touchViewGesture];
        }
    }
}

- (void) touchImageViewAction:(UITapGestureRecognizer *)recognizer
{
    UIView *view = [recognizer view];
    if ([self.delegate respondsToSelector:@selector(clickedImageSend:)])
    {
        [self.delegate clickedImageSend:view.tag];
    }
}

@end
