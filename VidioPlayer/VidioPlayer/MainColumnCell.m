//
//  MainColumnCell.m
//  VidioPlayer
//
//  Created by shi feng on 13-4-1.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import "MainColumnCell.h"
#import "Constants.h"
#import "MainTitleObject.h"

@implementation MainColumnCell
@synthesize myScrollView = _myScrollView;
@synthesize imageArrays = _imageArrays;

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

- (void) initDraw: (NSMutableArray *) array
{
    if ([[self.myScrollView subviews] count] > 0) {
        for (UIView *ui in [self.myScrollView subviews]) {
            [ui removeFromSuperview];
        }
    }
    self.imageArrays = array;
    [self.myScrollView setBackgroundColor:[UIColor blackColor]];
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.contentSize = CGSizeMake([self.imageArrays count] * MAIN_SECTION_IMAGE_WIDTH + ([self.imageArrays count] + 1) * MAIN_SECTION_WIDTH_EMPTY, MAIN_COLUMN_HEIGHT);

    self.myScrollView.delegate = self;
    [self createPages];
}

- (void) createPages
{
    for (MainTitleObject *mm in self.imageArrays) {
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SECTION_IMAGE_WIDTH, MAIN_SECTION_IMAGE_HEIGHT)];
//        view.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:mm.imageUrl]]];
        view.image = mm.image;
        [view setUserInteractionEnabled:YES];
        [view setTag:mm.mid];
        UITapGestureRecognizer *touchViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchImageViewAction:)];
        [view addGestureRecognizer:touchViewGesture];
        
        [self scrollViewWidthPage:view];
    }
}

- (void) scrollViewWidthPage: (UIImageView *)page
{
    int defaultCount = [[self.myScrollView subviews] count];
    
    int x = defaultCount * MAIN_SECTION_IMAGE_WIDTH + MAIN_SECTION_WIDTH_EMPTY * (defaultCount + 1);

    CGRect bounds = page.bounds;
    bounds.origin.x = x;
    bounds.origin.y = MAIN_SECTION_HEIGHT_EMPTY;
    
    page.frame = bounds;
    
    [self.myScrollView addSubview:page];
}

- (void) touchImageViewAction:(UITapGestureRecognizer *)recognizer
{
    UIView *view = [recognizer view];
    if ([self.delegate respondsToSelector:@selector(clickedColumnImageSend:)])
    {
        [self.delegate clickedColumnImageSend:view.tag];
    }
}
@end
