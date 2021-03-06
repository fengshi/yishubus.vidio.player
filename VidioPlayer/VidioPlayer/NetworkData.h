//
//  NetworkData.h
//  VidioPlayer
//
//  Created by shi feng on 13-3-18.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkData : NSObject

+ (NSMutableArray *) mainTitleData: (NSString *) dataUrl;
+ (NSMutableArray *) mainColumnData: (NSString *) dataUrl;
+ (NSMutableArray *) videoSetData: (NSString *) dataUrl mid: (int) mid;
+ (NSMutableArray *) catelogData: (NSString *) dataUrl;
+ (NSMutableArray *) catelogDetailData: (NSString *) dataUrl columnId: (int) columnId number:(int)number;
+ (NSMutableArray *) searchData: (NSString *) dataUrl searchText: (NSString *) searchText;

@end
