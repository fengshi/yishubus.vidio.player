//
//  NetworkData.m
//  VidioPlayer
//
//  Created by shi feng on 13-3-18.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import "NetworkData.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "MainTitleObject.h"
#import "MainColumnObject.h"
#import "VideoSetObject.h"

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

+ (NSMutableArray *) videoSetData:(NSString *)dataUrl mid: (int) mid
{
    NSString *stringUrl = [NSString stringWithFormat:@"&mid=%d",mid];
    NSURL *url = [NSURL URLWithString:[dataUrl stringByAppendingString:stringUrl]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSError *error = [request error];
//    if (!error) {
//        NSString *jsonRequest = [request responseString];
//        NSArray *resultArray = [jsonRequest objectFromJSONString];
//        NSMutableArray *result = [[NSMutableArray alloc]init];
//        
//        NSDictionary *imageDictionary = [resultArray objectAtIndex:0];
//        NSString *imageUrl = [imageDictionary objectForKey:@"imageUrl"];
//        [result addObject:imageUrl];
//        
//        NSDictionary *introduceDictionary = [resultArray objectAtIndex:1];
//        NSString *introduce = [introduceDictionary objectForKey:@"introduce"];
//        [result addObject:introduce];
//        
//        NSDictionary *videoDictionary = [resultArray objectAtIndex:2];
//        NSArray *videoArray = [videoDictionary objectForKey:@"video"];
//        NSMutableArray *videoMutableArray = [[NSMutableArray alloc] init];
//        
//        for (int i=0; i<[videoArray count]; i++) {
//            NSDictionary *video = [videoArray objectAtIndex:i];
//            VideoSetObject *object = [[VideoSetObject alloc] init];
//            object.introduce = [video objectForKey:@"title"];
//            object.imageUrl = [video objectForKey:@"imageUrl"];
//            object.detail = [video objectForKey:@"detail"];
//            object.videoUrl = [video objectForKey:@"videoUrl"];
//            
//            [videoMutableArray addObject:object];
//        }
//        [result addObject:videoMutableArray];
//        
//        NSDictionary *authorDictionary = [resultArray objectAtIndex:3];
//        NSString *author = [authorDictionary objectForKey:@"author"];
//        [result addObject:author];
//        return result;
//    }
    if (!error) {
        NSString *jsonRequest = [request responseString];
        NSArray *resultArray = [jsonRequest objectFromJSONString];
        NSMutableArray *result = [[NSMutableArray alloc]init];
        
        NSDictionary *typeDictionary = [resultArray objectAtIndex:0];
        NSString *type = [typeDictionary objectForKey:@"type"];
//        [result addObject:type];
        
        NSDictionary *imageDictionary = [resultArray objectAtIndex:1];
        NSString *imageUrl = [imageDictionary objectForKey:@"imageUrl"];
        [result addObject:imageUrl];
        
        NSDictionary *introduceDictionary = [resultArray objectAtIndex:2];
        NSString *introduce = [introduceDictionary objectForKey:@"introduce"];
        [result addObject:introduce];
        
        NSDictionary *videoDictionary = [resultArray objectAtIndex:3];
        NSArray *videoArray = [videoDictionary objectForKey:@"video"];
        NSMutableArray *videoMutableArray = [[NSMutableArray alloc] init];
        
        for (int i=0; i<[videoArray count]; i++) {
            NSDictionary *video = [videoArray objectAtIndex:i];
            VideoSetObject *object = [[VideoSetObject alloc] init];
            object.introduce = [video objectForKey:@"title"];
            object.imageUrl = [video objectForKey:@"imageUrl"];
            object.detail = [video objectForKey:@"detail"];
            object.videoUrl = [video objectForKey:@"videoUrl"];
            object.type = type;
            object.vid = [video objectForKey:@"videoUrl"];
            
            [videoMutableArray addObject:object];
        }
        [result addObject:videoMutableArray];
        
        NSDictionary *authorDictionary = [resultArray objectAtIndex:4];
        NSString *author = [authorDictionary objectForKey:@"author"];
        [result addObject:author];
        
        return result;
    }
    return nil;
}

+ (NSMutableArray *) catelogData: (NSString *) dataUrl
{
    NSURL *url = [NSURL URLWithString:dataUrl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *jsonResult = [request responseString];
        NSArray *resultArray = [jsonResult objectFromJSONString];
        NSMutableArray *result = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [resultArray count]; i++) {
            NSDictionary *column = [resultArray objectAtIndex:i];
            MainColumnObject *object = [[MainColumnObject alloc] init];
            object.columnId = [[column objectForKey:@"columnId"] intValue];
            object.columnName = [column objectForKey:@"columnName"];
            object.columnImageUrl = [column objectForKey:@"imageUrl"];
            [result addObject:object];
        }
        return result;
    }
    return nil;
}

+ (NSMutableArray *) catelogDetailData: (NSString *) dataUrl columnId: (int) columnId number:(int)number
{
    NSString *stringUrl = [NSString stringWithFormat:@"&columnId=%d&number=%d",columnId,number];
    NSURL *url = [NSURL URLWithString:[dataUrl stringByAppendingString:stringUrl]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *jsonResult = [request responseString];
        NSArray *resultArray = [jsonResult objectFromJSONString];
        
        NSMutableArray *result = [[NSMutableArray alloc] init];
        for (int j=0; j<[resultArray count]; j++) {
            NSDictionary *detail = [resultArray objectAtIndex:j];
            NSString *introduce = [detail objectForKey:@"titleName"];
            NSString *imageUrl = [detail objectForKey:@"imageUrl"];
            int mid = [[detail objectForKey:@"moveId"] intValue];
            MainTitleObject *tmp = [[MainTitleObject alloc] init];
            tmp.imageUrl = imageUrl;
            tmp.introduce = introduce;
            tmp.mid = mid;
            [result addObject:tmp];
        }
        return result;
    }
    return nil;
}

+ (NSMutableArray *) searchData: (NSString *) dataUrl searchText: (NSString *) searchText
{
    NSURL *url = [NSURL URLWithString:dataUrl];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:searchText forKey:@"searchText"];
    
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *jsonResult = [request responseString];
        NSArray *resultArray = [jsonResult objectFromJSONString];
        
        NSMutableArray *result = [[NSMutableArray alloc] init];
        for (int j=0; j<[resultArray count]; j++) {
            NSDictionary *detail = [resultArray objectAtIndex:j];
            NSString *introduce = [detail objectForKey:@"titleName"];
            NSString *imageUrl = [detail objectForKey:@"imageUrl"];
            int mid = [[detail objectForKey:@"moveId"] intValue];
            MainTitleObject *tmp = [[MainTitleObject alloc] init];
            tmp.imageUrl = imageUrl;
            tmp.introduce = introduce;
            tmp.mid = mid;
            [result addObject:tmp];
        }
        return result;
    }
    return nil;
}
@end
