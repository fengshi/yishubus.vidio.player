//
//  VideoSetController.m
//  VidioPlayer
//
//  Created by shi feng on 13-4-3.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import "VideoSetController.h"
#import "SDSegmentedControl.h"
#import "Constants.h"
#import "NetworkData.h"
#import "RequestURL.h"

@interface VideoSetController () {
    SDSegmentedControl *segmentControl;
    UIImageView *titleView;
    NSMutableArray *array;
}

@end

@implementation VideoSetController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) initDraw: (int) mid
{
    NSString *titleUrl = [RequestURL getUrlByKey:VIDEO_SET_URL];
    array = [NetworkData videoSetData:titleUrl mid:mid];
    
	titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, MAIN_TITLE_HEIGHT)];
    titleView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[array objectAtIndex:0]]]];

    segmentControl = [[SDSegmentedControl alloc] initWithItems:[[NSArray alloc] initWithObjects:@"详情",@"视频",@"作者", nil]];
    segmentControl.frame = CGRectMake(0, MAIN_TITLE_HEIGHT, self.view.frame.size.width, VIDEO_SEGMENTED_HEIGHT);
    segmentControl.selectedSegmentIndex = 0;
    
    [segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:titleView];
    [self.view addSubview:segmentControl];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) segmentAction: (UISegmentedControl *) seg
{
    NSInteger index = seg.selectedSegmentIndex;
    if (index == 0) {

    } else if (index == 1) {

    } else if (index == 2) {

    }
}
@end
