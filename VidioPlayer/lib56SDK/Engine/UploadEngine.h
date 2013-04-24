//
//  UploadEngine.h
//  56SDK
//
//  Created by renren on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"

enum{
    
    VideoUploadErrorCode_ParamNil = 0,  //参数为空，不合法
    VideoUploadErrorCode_VideoPathNotExist = 1,  //上传视频地址不存在
    VideoUploadErrorCode_ConnectionFail = 2,  //网络连接失败
    VideoUploadErrorCode_Close = 3,    //用户关闭连接
    VideoUploadErrorCode_HaveExistUploding = 4,  //当前已存在上传，不可同时进行多个上传，如需开启另外上传，需要调用当前engine的close方法
    
    VideoUploadErrorCode_UnkownError = 11  //未知错误
    
}VideoUploadErrorCode;


@protocol UploadEngineDelegate <NSObject>


/**
    描述:
        Engine上传完成，回调此方法
    参数:
        result: 作为该上传视频的标识唯一性字段vid
        info:   上传初始设定附带的信息
    注意:
 */
-(void)finishedUpload:(NSString*)result userInfo:(NSDictionary*)info;



/**
    描述:
        Engine上传失败，回调此方法。当调用了Engine的close方法时，也会回调此方法。
    参数:
        error:     NSError对象内的errorCode和domain包含了错误信息
        videoInfo: 视频传输中断或错误，返回该字符串，如需续传视频，建议保存该字符串，续传只需调用uploadVideoForResume，将该字符
                    串传入，视频便会从断点处开始传输。如本地视频被移除，将报错，不再重新开始传输。
                    该字符串需要判空，如果为空，则说明在正式上传前，各参数检查没通过，需要根据error中的errorCode来做相应判断
        info:      上传初始设定附带的信息
    注意:此方法的返回的videoInfo,是下次续传必需的唯一信息。需要在必要的时候，保存videoInfo.
 */
-(void)failUpload:(NSError*)error videoResumeInfo:(NSString*)videoInfo userInfo:(NSDictionary*)info;



/*
    描述:
        上传的进度回调函数，其精度被模糊化处理，即不会被多次调用，只在重要节点被调用。
    参数:
        progress: 当前传输的进度，值类似为0.5，该进度只是一个粗略的数值，进度的增加不会精确到0.1
        info:     上传初始设定附带的信息
    注意:
 */
-(void)progressUpload:(float)progress userInfo:(NSDictionary*)info;

@end



@interface UploadEngine : NSObject


#pragma mark - 
#pragma mark - Initlizer


-(void)setDelegate:(id)delegate;

/** 退出并移除delegate */
-(void)clearDelegatesAndCancel;


+(UploadEngine*)sharedUploadEngine;


/** 初始化上传 */
+ (void)initializer;




#pragma mark - 
#pragma mark - Upload


/**
    描述：
        新发起的上传视频，需要传递一系列必须的参数。
    参数：
        version: 应用的版本号，比如"1.0"
        tag: 视频所属的标签，比如“电影”，“搞笑”等
        title: 视频的标题
        desc: 视频的详细介绍
        video_type: 视频的类型，只能是以下三种任一: @"normal"（标清）,@"clear"（高清）,@"super"（超清）.只需传入@"normal"或其他，不可多种同时传输
        video_local_path:视频所在路径，若检测不到路径，将报错，建议检查后再传输
        sid: 上传者id,第三方用户标识
        info: 回调将返回该结果
 
    注意：上传是一个相对耗流量和网络的过程，只支持同时单个上传。
 */
-(void)uploadVideoWithLocalPath:(NSString*)videoLocalPath 
                     videoTitle:(NSString*)videoTitle 
                       videoTag:(NSString*)videoTag 
               videoDescription:(NSString*)videoDesc 
                      videoType:(NSString*)videoType 
                            sID:(NSString*)sid
                           userInfo:(NSDictionary*)info;



/** 
    描述：
        重启断点续传，需要传递上次上传返回的字符串  
    参数：
        videoResumeInfo: 上次上传断裂时返回的结果
        info: 回调将返回该结果
 */
-(void)uploadVideoWithResumeInfo:(NSString*)videoResumeInfo userInfo:(NSDictionary*)info;


/** 
 断开当前的上传，如需下次续传，需要保存回调失败返回的resumeInfo字符串。 
 */
-(void)close;



@end
