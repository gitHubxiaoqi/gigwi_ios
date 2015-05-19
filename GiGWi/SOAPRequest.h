//
//  Request.h
//  Qyli
//
//  Created by 小七 on 14-8-1.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SOAPRequest : NSObject<NSURLConnectionDelegate>
+(NSDictionary *)getResponseByGetURL:(NSString *)urlString;
+(NSDictionary *)getResponseByPostURL:(NSString *)urlString jsonDic:(NSDictionary *)jsonDic;
+ (BOOL)checkNet;

@end
