//
//  Request.m
//  Qyli
//
//  Created by 小七 on 14-8-1.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import "SOAPRequest.h"
#import "Reachability.h"
#import "ASIHTTPRequest.h"


@implementation SOAPRequest

+(BOOL)checkNet
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags) {
        NSLog(@"Error. Could not recover network reachability flags");
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
    NSURL *testURL = [NSURL URLWithString:@"http://www.google.com/"];
    NSURLRequest *testRequest = [NSURLRequest requestWithURL:testURL  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0];
    NSURLConnection *testConnection = [[NSURLConnection alloc] initWithRequest:testRequest delegate:self];
    BOOL isChek=((isReachable && !needsConnection) || !nonWiFi) ? (testConnection ? YES : NO) : NO;
    if (isChek==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络不通，请监测网络！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [alert show];
    }
    return isChek;
}

//成功的ASI带参请求
+(NSDictionary *)getResponseByPostURL:(NSString *)urlString jsonDic:(NSDictionary *)jsonDic
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error: &error];
    NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
    NSLog(@"客户端发送的JSON为+++++++++++++++++++++++++++++++++++++++:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
   
     ASIHTTPRequest *request = [ ASIHTTPRequest requestWithURL :[NSURL URLWithString:urlString]];
    [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:10];
    [request setPostBody:tempJsonData];
     //关闭网络复用
    //[request setShouldAttemptPersistentConnection:NO];
    
    __weak ASIHTTPRequest *request1 =request;
    [request startAsynchronous];
    
    [request setStartedBlock:^{
    }];
    [request setCompletionBlock :^{
        request1.tag=9999;
    }];
    [request setFailedBlock :^{
        request1.tag=9999;
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"无法链接到服务器。。。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];

    }];
//!request.responseString||[request.responseString isEqualToString:@""]||
    while (request.tag!=9999)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    NSLog(@"服务器返回的JSON为************************************:%@",request.responseString);

    SBJSON * json=[[SBJSON alloc] init];
    NSDictionary * dic=[json objectWithString:request.responseString error:nil];
    return dic;
}
//成功的ASI无参请求
+(NSDictionary *)getResponseByGetURL:(NSString *)urlString
{
    NSLog(@"客户端发送的JSON为+++++++++++++++++++++++++++++++++++++++:%@",urlString);
    
    ASIHTTPRequest *request = [ ASIHTTPRequest requestWithURL :[NSURL URLWithString:urlString]];
    [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"GET"];
    [request setTimeOutSeconds:10];
    [request startAsynchronous];
    
    [request setStartedBlock:^{

    }];
    [request setCompletionBlock :^{

    }];
    [request setFailedBlock :^{
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"无法链接到服务器。。。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }];
    
    while (!request.responseString||[request.responseString isEqualToString:@""])
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    NSLog(@"服务器返回的JSON为************************************:%@",request.responseString);

    SBJSON * json=[[SBJSON alloc] init];
    NSDictionary * dic=[json objectWithString:request.responseString error:nil];
    return dic;
    
}



@end
