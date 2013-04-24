//
//  EncryptTools.h
//  56Client
//
//  Created by renren on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMBase64.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>

enum
{
    HashMd5,
    HashSha1,
    HashSha256,
    HashSha512,
};

typedef NSInteger HashSort;

@interface EncryptUtil : NSObject

//Hash 算法
+ (NSString *)hashFile:(NSString *)filePath with:(HashSort)hashKind;
+ (NSString *)hashData:(NSData *)data with:(HashSort)hashKind;
+ (NSString *)hashString:(NSString *)string with:(HashSort)hashKind;

+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)key;

@end
