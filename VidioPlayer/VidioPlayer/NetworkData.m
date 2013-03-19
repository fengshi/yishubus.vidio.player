//
//  NetworkData.m
//  VidioPlayer
//
//  Created by shi feng on 13-3-18.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import "NetworkData.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "MainTitleObject.h"

@implementation NetworkData

- (NSMutableArray *) mainTitleData: (NSString *) dataUrl
{
    NSURL *url = [NSURL URLWithString:dataUrl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSString *jsonResult = [request responseString];
        NSArray *resultArray = [jsonResult objectFromJSONString];
        NSDictionary *dataDictionary = [resultArray objectAtIndex:0];
        if ([[dataDictionary objectForKey:@"id"] isEqual:@"title"])
        {
            NSMutableArray *result = [[NSMutableArray alloc] init];
            NSArray *data = [dataDictionary objectForKey:@"data"];
            for (int i=0; i<[data count]; i++) {
                NSDictionary *obj = [data objectAtIndex:i];
                NSString *introduce = [obj objectForKey:@"titleName"];
                NSString *imageUrl = [obj objectForKey:@"imageUrl"];
                int mid = [[obj objectForKey:@"moveId"] intValue];
                MainTitleObject *tmp = [[MainTitleObject alloc] init];
                tmp.imageUrl = imageUrl;
                tmp.introduce = introduce;
                tmp.mid = mid;
                [result addObject:tmp];
            }
            return result;
        }
    }
    return nil;
}

@end
