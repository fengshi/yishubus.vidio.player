//
//  StringUtil.h
//  56SDK
//
//  Created by renren on 9/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject

/** 将NSDictionary中的key和value配对形成NSString  */
+(NSString*)keyValuePairsJionWithDictionary:(NSDictionary*)dic;

/** 将NSDictionary中的key和value配对形成NSString，value是经过url的encode的  */
+(NSString*)keyValuePairsUrlEncodeJionWithDictionary:(NSDictionary*)dic;

/** 将NSString按一定规则，转换成NSDictionary  */
+(NSDictionary*)dictionaryConvertWithString:(NSString*)string;

/** 判断NSString是否为空  */
+(BOOL)isStringNil:(NSObject *)str;

/** NSString形式的系统时间，字符串长度为10 */
+(NSString*)systemTime;

/** 当前的用户ID */
+(NSString*)currentUserID;

/** 当前SDK的版本号 */
+(NSString*)currentVersionNumber;

/** 当前设备ID */
+(NSString*)currentMachineID;

/** 当前的设备信息 */
+(NSString*)currentMachineInfo;

/** 本地路径下的文件大小 */
+(NSString*)fileSizeWithUrl:(NSString*)url;

/** 本地路径下的文件名 */
+(NSString*)fileNameWithUrl:(NSString*)url;

/** 本地路径下的文件后缀名 */
+(NSString*)suffixNameWithUrl:(NSString*)url;

/** 文件的后缀名 */
+(NSString*)suffixNameWithFileName:(NSString*)fileName;

/** 去掉小数点后面的字符 */
+(NSString *)trimZero:(NSString *)str;

/** 对url进行encode */
+(NSString*)urlEncode:(NSString *)unencodedString;

/** 3DES的加解密*/
+(NSString*)encodeWith3DES:(NSString*)string;

+(NSString*)decodeWith3DES:(NSString*)string;

+(NSString*)getClientInfo;

#pragma mark -
#pragma mark - Kev Value Save To UserDefault

+(void)saveUserDefaultWithKey:(NSString *)key Value:(id)value;

+(id)valueForUserDefaultWithKey:(NSString *)key;

@end
