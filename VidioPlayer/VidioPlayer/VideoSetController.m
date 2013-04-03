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

@interface VideoSetController () {
    SDSegmentedControl *segmentControl;
    UIImageView *titleView;
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
    NSLog(@"%d",mid);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, MAIN_TITLE_HEIGHT)];
    segmentControl = [[SDSegmentedControl alloc] initWithItems:[[NSArray alloc] initWithObjects:@"详情",@"视频",@"作者", nil]];
    segmentControl.frame = CGRectMake(0, MAIN_TITLE_HEIGHT, self.view.frame.size.width, MAIN_SECTION_HEIGHT);
    segmentControl.selectedSegmentIndex = 0;
    
    [self.view addSubview:titleView];
    [self.view addSubview:segmentControl];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
