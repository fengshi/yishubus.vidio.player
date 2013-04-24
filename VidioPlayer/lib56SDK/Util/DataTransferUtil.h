//
//  DataTransferUtil.h
//  56SDK
//
//  Created by renren on 9/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTransferUtil : NSObject

/** 取消 */
- (void)cancel;

/** 数据传输 */
- (void)transfer:(NSDictionary*)attr;

/** 当前是否正存在上传 */
- (BOOL)existCurrentDataTransfering;

/** 初始化上传 */
+ (void)initializer;

@end
