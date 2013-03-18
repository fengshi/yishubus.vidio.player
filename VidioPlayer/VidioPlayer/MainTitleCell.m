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

@property (strong,nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic) IBOutlet UIPageControl *pagecontrol;
@property (strong,nonatomic) IBOutlet UILabel *label;

@end

@implementation MainTitleCell
@synthesize scrollView = _scrollView;
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


- (void) setUp
{
    NSString *titleUrl = [RequestURL getUrlByKey:MAIN_TITLE_URL];
    NetworkData *network = [[NetworkData alloc] init];
    NSMutableArray *data = [network mainTitleData:titleUrl];
    self.imageViews = data;
}


- (void) drawRect:(CGRect)rect
{
    [self setUp];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * MAIN_TITLE_COUNT, self.frame.size.height);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    
    MainTitleObject *mo = [self.imageViews objectAtIndex:0];
    self.label.text = mo.introduce;
}

- (void) createPages
{
    CGRect pageRect = self.scrollView.frame;
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
    int defaultCount = [[self.scrollView subviews] count];
    CGRect bounds = self.scrollView.bounds;
    bounds.origin.x = bounds.size.width * defaultCount;
    bounds.origin.y = 0;
    page.frame = bounds;
    [self.scrollView addSubview:page];
}

- (void) touchImageViewAction:(UITapGestureRecognizer *)recognizer
{
    UIView *view = [recognizer view];
    if ([self.delegate respondsToSelector:@selector(clickedImageSend:)])
    {
        [self.delegate clickedImageSend:view.tag];
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
