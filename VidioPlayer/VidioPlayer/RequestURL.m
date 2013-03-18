//
//  RequestURL.m
//  VidioPlayer
//
//  Created by shi feng on 13-3-18.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import "RequestURL.h"
#import "Constants.h"

@implementation RequestURL

+(NSString *) getUrlByKey:(NSInteger)key
{
    switch (key) {
        case MAIN_TITLE_URL:
            return [MAIN stringByAppendingString:@"testAction.do?action=testPhone"];
            break;
            
        default:
            break;
    }
    return nil;
}
@end
