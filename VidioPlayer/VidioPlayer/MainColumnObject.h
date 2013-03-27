//
//  MainColumnObject.h
//  VidioPlayer
//
//  Created by shi feng on 13-3-27.
//  Copyright (c) 2013年 com.yishubus.vidioplayer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainColumnObject : NSObject

@property (nonatomic, strong) NSString *columnName;
@property (nonatomic, strong) NSMutableArray *columnDetails;
@property (nonatomic) int columnId;

@end