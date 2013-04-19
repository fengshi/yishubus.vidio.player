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
#import "VideoSetObject.h"

@interface VideoSetController () {
    SDSegmentedControl *segmentControl;
    UIImageView *titleView;
    NSMutableArray *array;
    UITableView *myTableView;
    NSMutableArray *tableArray;
}

@end

@implementation VideoSetController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"艺术巴士";
    }
    return self;
}

- (void) myViewSetView
{
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [myTableView setBackgroundColor:VIDEO_SEGMENTED_BACKGROUND_COLOR];
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
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, MAIN_TITLE_HEIGHT + VIDEO_SEGMENTED_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - MAIN_TITLE_HEIGHT - VIDEO_SEGMENTED_HEIGHT - 90)];
    
    myTableView.delegate = self;
    myTableView.dataSource = self;
    
    tableArray = [[NSMutableArray alloc] initWithObjects:[array objectAtIndex:1], nil];
    
    [self myViewSetView];

    [self.view addSubview:titleView];
    [self.view addSubview:segmentControl];
    [self.view addSubview:myTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitfull:) name:MPMoviePlayerDidExitFullscreenNotification object:self.player];

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
    [self myViewSetView];
    if (index == 0) {
        tableArray = [[NSMutableArray alloc] initWithObjects:[array objectAtIndex:1], nil];
        [myTableView reloadData];
    } else if (index == 1) {
        NSMutableArray *temp = [array objectAtIndex:2];
        tableArray = [[NSMutableArray alloc] init];
        for (int i=0; i<[temp count]; i++) {
            [tableArray addObject:[temp objectAtIndex:i]];
        }

        [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [myTableView setBackgroundColor:MAIN_SECTION_BACKGROUND_COLOR];
        [myTableView reloadData];
    } else if (index == 2) {
        tableArray = [[NSMutableArray alloc] initWithObjects:[array objectAtIndex:3], nil];
        [myTableView reloadData];
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableArray count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    static NSString *videoSetCell = @"videoSetCell";
    
    if (segmentControl.selectedSegmentIndex == 1) {
        UINib *nib = [UINib nibWithNibName:@"VideoSetCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:videoSetCell];
        
        VideoSetCell *cell = [tableView dequeueReusableCellWithIdentifier:videoSetCell];
        VideoSetObject *vo = [tableArray objectAtIndex:[indexPath row]];
        [cell initDraw:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:vo.imageUrl]]] introduce:vo.introduce detail:vo.detail index:[indexPath row]];
        cell.delegate = self;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setSelected:NO];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [cell setFrame:CGRectMake(0, 0, myTableView.frame.size.width, myTableView.frame.size.height)];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [label setNumberOfLines:0];
        
        UIFont *font = [UIFont fontWithName:@"HiraginoSansGB-W6" size:12];
        CGSize size = cell.frame.size;
        CGSize labelSize = [[tableArray objectAtIndex:0] sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        [label setFrame:CGRectMake(0, 5, labelSize.width, labelSize.height)];
        [label setFont:font];
        [label setTextColor:MAIN_SECTION_TEXT_COLOR];
        [label setBackgroundColor:[UIColor clearColor]];
        label.text = [tableArray objectAtIndex:0];
        [cell addSubview:label];
        return cell;
    }

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void) clickedVideoCellSend:(int)mid
{
    VideoSetObject *vo = [tableArray objectAtIndex:mid];

    NSURL *movieurl = [NSURL URLWithString:vo.videoUrl];
    
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:movieurl];
    [self.player.view setFrame:self.view.bounds];
    [self.view addSubview:self.player.view];
    
//    self.player.shouldAutoplay = YES;
//    [self.player setControlStyle:MPMovieScalingModeAspectFit];
    self.player.scalingMode = MPMovieScalingModeAspectFit;
    
    [self.player setFullscreen:YES];
    [self.player play];
}

- (void) exitfull: (NSNotification *)notification {
    [self.player.view removeFromSuperview];
}
@end
