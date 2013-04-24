//
//  ParametersSign.h
//  56SDK
//
//  Created by renren on 9/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EncryptUtil.h"

@interface ParametersSign : NSObject

/** 根据传输进来的参数进行签名 */
+ (NSString*)sign:(NSDictionary*)params; 

/** 根据传输进来的参数，对限制参数进行签名 */
+ (NSString*)signNoLimited:(NSDictionary *)params;

@end
