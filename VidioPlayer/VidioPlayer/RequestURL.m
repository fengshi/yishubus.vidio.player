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
            return [MAIN stringByAppendingString:@"websitLessonAction.do?action=mobileIndexTitle"];
//            return [MAIN stringByAppendingString:@"testAction.do?action=testPhone"];
        case MAIN_COLUMN_URL:
            return [MAIN stringByAppendingString:@"websitLessonAction.do?action=mobileIndexLevel"];
//            return [MAIN stringByAppendingString:@"testAction.do?action=testPhoneColumn"];
        case VIDEO_SET_URL:
            return [MAIN stringByAppendingString:@"websitLessonAction.do?action=mobileLessonVideoList"];
//            return [MAIN stringByAppendingString:@"testAction.do?action=testPhoneVideoSet"];
        case CATELOG_URL:
            return [MAIN stringByAppendingString:@"websitLessonAction.do?action=mobileLevel"];
//            return [MAIN stringByAppendingString:@"testAction.do?action=testPhoneCatelog"];
        case CATELOG_DETAIL_URL:
            return [MAIN stringByAppendingString:@"websitLessonAction.do?action=mobileLessonList"];
//            return [MAIN stringByAppendingString:@"testAction.do?action=testPhoneCatelogDetail"];
        case SEARCH_URL:
            return [MAIN stringByAppendingString:@"websitLessonAction.do?action=mobileLessonSearch"];
//            return [MAIN stringByAppendingString:@"testAction.do?action=testPhoneSearch"];
        default:
            break;
    }
    return nil;
}
@end
