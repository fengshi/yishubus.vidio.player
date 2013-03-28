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
#import "MainColumnObject.h"

@implementation NetworkData

+ (NSMutableArray *) mainTitleData: (NSString *) dataUrl
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

+ (NSMutableArray *) mainColumnData:(NSString *)dataUrl
{
    NSURL *url = [NSURL URLWithString:dataUrl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *jsonResult = [request responseString];
        NSArray *resultArray = [jsonResult objectFromJSONString];
        NSLog(@"%@",[[jsonResult objectFromJSONString] class]);
        NSLog(@"%@",jsonResult);
        NSDictionary *dataDictionary = [resultArray objectAtIndex:0];
        if ([[dataDictionary objectForKey:@"id"] isEqual:@"column"]) {
            NSArray *data = [dataDictionary objectForKey:@"data"];
            NSMutableArray *result = [[NSMutableArray alloc] init];
            for (int i=0; i<[data count]; i++) {
                NSDictionary *column = [data objectAtIndex:i];
                MainColumnObject *object = [[MainColumnObject alloc] init];
                object.columnId = [[column objectForKey:@"columnId"] intValue];
                object.columnName = [column objectForKey:@"columnName"];
                
                NSMutableArray *columnDetailArray = [[NSMutableArray alloc] init];
                NSArray *columnDetail = [column objectForKey:@"data"];
                for (int j=0; j<[columnDetail count]; j++) {
                    NSDictionary *detail = [columnDetail objectAtIndex:j];
                    NSString *introduce = [detail objectForKey:@"titleName"];
                    NSString *imageUrl = [detail objectForKey:@"imageUrl"];
                    int mid = [[detail objectForKey:@"moveId"] intValue];
                    MainTitleObject *tmp = [[MainTitleObject alloc] init];
                    tmp.imageUrl = imageUrl;
                    tmp.introduce = introduce;
                    tmp.mid = mid;
                    [columnDetailArray addObject:tmp];
                }
                object.columnDetails = columnDetailArray;
                [result addObject:object];
            }
            return result;
        }
    }
    return nil;
}
@end
