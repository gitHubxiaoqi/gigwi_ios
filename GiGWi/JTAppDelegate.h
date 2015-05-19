//
//  AppDelegate.h
//  GiGWi
//
//  Created by 小七 on 15-4-21.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"JTTabBarViewController.h"

@interface JTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)JTTabBarViewController * tabBarViewController;
@property(nonatomic,strong)UIView * tabBarView;
@property(nonatomic,strong)JTUser * appUser;


@property(nonatomic,strong)NSMutableArray * provinceTitleArr;
@property(nonatomic,strong)NSMutableArray *  cityTitleArr;
@property(nonatomic,strong)NSMutableArray * quTitleArr;
@property(nonatomic,strong)NSMutableArray *  provinceIDArr;
@property(nonatomic,strong)NSMutableArray * cityIDArr;
@property(nonatomic,strong)NSMutableArray * quIDArr;

@end

