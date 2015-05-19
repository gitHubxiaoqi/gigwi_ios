//
//  AppDelegate.m
//  GiGWi
//
//  Created by 小七 on 15-4-21.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTAppDelegate.h"

#import <AlipaySDK/AlipaySDK.h>

@interface JTAppDelegate ()

@end

@implementation JTAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    _provinceTitleArr=[[NSMutableArray alloc] initWithCapacity:0];
    _cityTitleArr=[[NSMutableArray alloc] initWithCapacity:0];
    _provinceIDArr=[[NSMutableArray alloc] initWithCapacity:0];
    _cityIDArr=[[NSMutableArray alloc] initWithCapacity:0];
    _quTitleArr=[[NSMutableArray alloc] initWithCapacity:0];
    _quIDArr=[[NSMutableArray alloc] initWithCapacity:0];


    
    [self getArea];
    
     [self login];
    self.tabBarViewController=[[JTTabBarViewController alloc] init];
    self.window.rootViewController=self.tabBarViewController;
   

    return YES;
}
-(void)login
{
    
    self.appUser=[[JTUser alloc] init];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"loginName"]!=nil)
    {
        NSString * loginName=[[NSUserDefaults standardUserDefaults] objectForKey:@"loginName"];
        NSString * password=[[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
        
        if([SOAPRequest checkNet])
        {
            NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:loginName,@"loginName",password,@"password", nil];
            
            NSDictionary * loginDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_LoginURL] jsonDic:jsondic]];
            if([[loginDic objectForKey:@"resultCode"] intValue]==1000)
            {
                
                NSDictionary * userDic=[loginDic objectForKey:@"user"];
                self.appUser.userID=[[userDic objectForKey:@"id"] intValue];
                self.appUser.loginName=[userDic objectForKey:@"loginName"];
                self.appUser.password=[userDic objectForKey:@"password"];
                self.appUser.userName=[userDic objectForKey:@"nickName"];
                self.appUser.headPortraitImgUrlStr=[userDic objectForKey:@"imageValue"];
                self.appUser.email=[userDic objectForKey:@"email"];
                self.appUser.phone=[userDic objectForKey:@"phone"];
                
                self.appUser.provinceID=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"provinceId"];
                self.appUser.cityID=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"cityId"];
                self.appUser.regionId=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"regionId"];
                self.appUser.streetId=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"streetId"];
                self.appUser.provinceValue=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"provinceValue"];
                self.appUser.cityValue=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"cityValue"];
                self.appUser.regionName=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"regionValue"];
                self.appUser.streetName=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"streetValue"];
                self.appUser.address=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"recipientAddress"];
                self.appUser.adressName=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"name"];
                self.appUser.adressTel=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"phone"];
                self.appUser.yaoqingma=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"invitationCode"];
                
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isLogin"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            }
            
        }
    }
}

-(void)getArea
{
    if ([SOAPRequest checkNet])
    {
        NSDictionary * cityDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Area_getAllArea] jsonDic:@{}]];
        
        if ([[NSString stringWithFormat:@"%@",[cityDic objectForKey:@"resultCode"]] isEqualToString:@"1000"])
        {
            
            for (int i=0; i<[[cityDic objectForKey:@"areaList"] count]; i++)
            {
                NSString * provinceName=[[[cityDic objectForKey:@"areaList"] objectAtIndex:i] objectForKey:@"name"];
                NSString * provinceID=[[[cityDic objectForKey:@"areaList"] objectAtIndex:i] objectForKey:@"code"];
                if (provinceName!=nil)
                {
                    [_provinceTitleArr addObject:provinceName];
                }
                if (provinceID!=nil)
                {
                    [_provinceIDArr addObject:provinceID];
                }
                NSMutableArray * midArr=[[NSMutableArray alloc] initWithCapacity:0];
                NSMutableArray * midIDArr=[[NSMutableArray alloc] initWithCapacity:0];
                NSMutableArray * midArr2=[[NSMutableArray alloc] initWithCapacity:0];
                NSMutableArray * midIDArr2=[[NSMutableArray alloc] initWithCapacity:0];
                
                
                for (int a=0; a<[[[[cityDic objectForKey:@"areaList"] objectAtIndex:i] objectForKey:@"subArea"] count]; a++)
                {
                    NSString * cityName=[[[[[cityDic objectForKey:@"areaList"] objectAtIndex:i] objectForKey:@"subArea"] objectAtIndex:a] objectForKey:@"name"];
                    NSString * cityID=[[[[[cityDic objectForKey:@"areaList"] objectAtIndex:i] objectForKey:@"subArea"] objectAtIndex:a] objectForKey:@"code"];
                    if (cityName!=nil)
                    {
                        [midArr addObject:cityName];
                    }
                    if (cityID!=nil)
                    {
                        [midIDArr addObject:cityID];
                    }
                    
                    NSMutableArray * cqMidArr=[[NSMutableArray alloc] initWithCapacity:0];
                    NSMutableArray * cqMidIDArr=[[NSMutableArray alloc] initWithCapacity:0];

                    
                    for (int b=0; b<[[[[[[cityDic objectForKey:@"areaList"] objectAtIndex:i] objectForKey:@"subArea"] objectAtIndex:a] objectForKey:@"subArea"] count]; b++)
                    {
                        NSString * quName=[[[[[[[cityDic objectForKey:@"areaList"] objectAtIndex:i] objectForKey:@"subArea"] objectAtIndex:a] objectForKey:@"subArea"] objectAtIndex:b] objectForKey:@"name"];
                        NSString * quID=[[[[[[[cityDic objectForKey:@"areaList"] objectAtIndex:i] objectForKey:@"subArea"] objectAtIndex:a] objectForKey:@"subArea"] objectAtIndex:b] objectForKey:@"code"];

                        if (quName!=nil)
                        {
                            [cqMidArr addObject:quName];
                        }
                        if (quID!=nil)
                        {
                            [cqMidIDArr addObject:quID];
                        }


                    }
                    [midArr2 addObject:cqMidArr];
                    [midIDArr2 addObject:cqMidIDArr];


                    
                    
                }
                [_cityTitleArr addObject:midArr];
                [_cityIDArr addObject:midIDArr];
                [_quTitleArr addObject:midArr2];
                [_quIDArr addObject:midIDArr2];

                
                
            }
            
        }
    }
    
    
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //如果极简开发包不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给开 发包
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic) {
                                                      NSLog(@"result = %@",resultDic);
                                                  }]; }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
