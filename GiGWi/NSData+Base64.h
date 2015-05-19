//
//  NSData+Base64.h
//  Base64Test
//
//  Created by 小七 on 14-8-13.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Base64)


void *NewBase65Decode(
                      const char *inputBuffer,
                      size_t length,
                      size_t *outputLength);

char *NewBase65Encode(
                      const void *inputBuffer,
                      size_t length,
                      bool separateLines,
                      size_t *outputLength);

+ (NSData *)dataFromBase64String:(NSString *)aString;
- (NSString *)base64EncodedString;

@end
