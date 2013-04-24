//
//  APIEngine.h
//  56SDK
//
//  Created by renren on 9/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


enum{
    
    APIRequestErrorCode_ParamNil = 0,  //参数为空，不合法
    
}APIRequestErrorCode;


@protocol APIEngineDelegate <NSObject>


/** 
    描述:
        请求成功，获得返回信息.
    参数:
        result: 返回的信息
        info:   请求时的附带信息
 
 */
-(void)finishedAPIReqeust:(NSString*)result userInfo:(NSDictionary*)info;


/**
    描述:
        请求失败.
    参数:
        error:  NSError对象包含errorCode和domain两个值，errorCode是Engine的errorCode和ASIHTTPRequest
                的errorCode的集合。
        info:   请求时的附带信息
 */
-(void)failAPIRequest:(NSError*)error userInfo:(NSDictionary*)info;


@end



@interface APIEngine : NSObject 


#pragma mark -
#pragma mark - 初始化及清除缓存

/** 设置delegate */
-(void)setDelegate:(id)delegate;

/** 退出并移除delegate */
-(void)clearDelegatesAndCancel;

 
/** 获得实例 */
+(APIEngine*)sharedAPIEngine;

/** 清除本地缓存，但实际没有本地缓存，所用总是返回为NO */
+(BOOL)clearCache;



#pragma mark -
#pragma mark - 激活Engine

/** 激活Engine */
+(void)activeEngineWithAppKey:(NSString*)appKey Secret:(NSString*)secret;



#pragma mark -
#pragma mark - 对Video的操作


/** 删除 */
- (void)deleteVideoWithID:(NSString*)vid userInfo:(NSDictionary*)info;

/** 修改 */
- (void)updateVideoWithID:(NSString*)vid title:(NSString*)vTitle tag:(NSString*)vTag description:(NSString*)vDescription userInfo:(NSDictionary*)info;

/** 调用本地播放器播放 */
- (void)playVideoWithUrl:(NSString*)url playerPresentedByViewController:(UIViewController*)viewController;

/** 根据关键字，搜索视频 */
- (void)searchVideoWithKeyWord:(NSString*)keywork number:(NSString*)num page:(NSString*)page userInfo:(NSDictionary*)info;



#pragma mark -
#pragma mark - 按所属类型获取Video列表


/** 获取某一频道的视频（支持分页） */
- (void)getVideosWithChannelCategoryID:(NSString*)cid number:(NSString*)num page:(NSString*)page userInfo:(NSDictionary*)info;

/** 获取某一分类的推荐视频（支持分页） */
- (void)getVideosWithRecommendCategoryID:(NSString*)mid number:(NSString*)num page:(NSString*)page userInfo:(NSDictionary*)info;

/** 获取某一分类的热门视频 （支持分页） */
- (void)getVideosWithHotCategoryID:(NSString*)cid number:(NSString*)num page:(NSString*)page userInfo:(NSDictionary*)info;



#pragma mark -
#pragma mark - 获取Video的属性


/**  根据ID获取video的所有相关信息 */
- (void)getVideoInfoWithID:(NSString*)vid userInfo:(NSDictionary*)info;

/**  根据ID获取video的播放地址 */
- (void)getVideoAddressWithID:(NSString*)vid userInfo:(NSDictionary*)info;



#pragma mark -
#pragma mark - 获取开发应用下的信息


/** 获取开发者账号下，某用户的所有已上传视频 */
- (void)getAppVideosWithUserID:(NSString*)sid number:(NSString*)num page:(NSString*)page userInfo:(NSDictionary*)info;

/** 获取开发者账号下的所有已上传视频 */
- (void)getAppVideosWithNumber:(NSString*)num page:(NSString*)page userInfo:(NSDictionary*)info;

/** 获取开发应用的信息 */
- (void)getAppInfoWithUserInfo:(NSDictionary*)userInfo;



@end
