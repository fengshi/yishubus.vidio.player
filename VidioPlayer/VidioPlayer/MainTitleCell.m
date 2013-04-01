//
//  MainTitleCell.m
//  VidioPlayer
//
//  Created by shi feng on 13-3-18.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import "MainTitleCell.h"
#import "Constants.h"
#import "RequestURL.h"
#import "NetworkData.h"
#import "MainTitleObject.h"

@interface MainTitleCell()

@end

@implementation MainTitleCell
@synthesize myScrollView = _myScrollView;
@synthesize pagecontrol = _pagecontrol;
@synthesize label = _label;
@synthesize imageViews = _imageViews;

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
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) initDraw:(NSMutableArray *) array
{
    if ([[self.myScrollView subviews] count] > 0) {
        for (UIView *subview in [self.myScrollView subviews]) {
            [subview removeFromSuperview];
        }
    }
    self.imageViews = array;
    
    [self.myScrollView setBackgroundColor:MAIN_SECTION_BACKGROUND_COLOR];
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.contentSize = CGSizeMake(self.frame.size.width * [self.imageViews count], self.frame.size.height);
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    self.myScrollView.showsVerticalScrollIndicator = NO;
    self.myScrollView.scrollsToTop = NO;
    self.myScrollView.delegate = self;

    self.pagecontrol.numberOfPages = [self.imageViews count];
    self.pagecontrol.currentPage = 0;
    
    MainTitleObject *mo = [self.imageViews objectAtIndex:0];
    self.label.text = mo.introduce;
    
    [self createPages];
}

- (void) createPages
{
    CGRect pageRect = self.myScrollView.frame;
    for (MainTitleObject *mm in self.imageViews) {
        UIImageView *view = [[UIImageView alloc] initWithFrame:pageRect];
        view.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:mm.imageUrl]]];
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
    CGRect bounds = self.myScrollView.bounds;
    bounds.origin.x = bounds.size.width * defaultCount;
    bounds.origin.y = 0;
    page.frame = bounds;
    [self.myScrollView addSubview:page];
}

- (void) touchImageViewAction:(UITapGestureRecognizer *)recognizer
{
    UIView *view = [recognizer view];
    if ([self.delegate respondsToSelector:@selector(clickedTitleImageSend:)])
    {
        [self.delegate clickedTitleImageSend:view.tag];
    }
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pagecontrol.currentPage = page;
    
    MainTitleObject *mm = [self.imageViews objectAtIndex:page];
    self.label.text = mm.introduce;
}
@end
