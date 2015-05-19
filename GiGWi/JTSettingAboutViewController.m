//
//  JTSettingAboutViewController.m
//  Qyli
//
//  Created by 小七 on 14-10-9.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import "JTSettingAboutViewController.h"

@interface JTSettingAboutViewController ()

@end

@implementation JTSettingAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    JTAppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    appDelegate.tabBarView.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    JTAppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    appDelegate.tabBarView.hidden=NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self readyUI];
}
-(void)readyUI
{
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.hidden=YES;
    //自定义导航条    
    UIView * navLab=[[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 44)];
    navLab.userInteractionEnabled=YES;
    navLab.backgroundColor=NAV_COLOR;
    [self.view addSubview:navLab];
    
    UILabel * navTitailLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    navTitailLab.text=@"关于";
    navTitailLab.textAlignment=NSTextAlignmentCenter;
    navTitailLab.textColor=[UIColor whiteColor];
    navTitailLab.font=[UIFont systemFontOfSize:20];
    [navLab addSubview:navTitailLab];
    
    UIButton * leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame=CGRectMake(0, 0, 80, NAV_HEIGHT);
    [leftBtn addTarget:self action:@selector(leftBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    [navLab addSubview:leftBtn];
    
    UIImageView * backImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"返回按钮.png"]];
    backImgView.frame=CGRectMake(20, (NAV_HEIGHT-15)/2, 10, 15);
    [leftBtn addSubview:backImgView];
    
    //背景滚动视图
    UIScrollView * bigScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    [self.view addSubview:bigScrollView];
    
    UIImageView * smallImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iTunesArtwork@2x.png"]];
    smallImgView.frame=CGRectMake((SCREEN_WIDTH-40)/2.0, 10, 40, 40);
    smallImgView.layer.cornerRadius=5;
    smallImgView.layer.masksToBounds=YES;
    [bigScrollView addSubview:smallImgView];
    
    UILabel * banbenLab=[[UILabel alloc] initWithFrame:CGRectMake(0,10+CGRectGetHeight(smallImgView.frame)+10, SCREEN_WIDTH, 20)];
    banbenLab.text=@"GiGwi  1.0版本";
    banbenLab.textColor=[UIColor brownColor];
    banbenLab.font=[UIFont systemFontOfSize:13];
    banbenLab.textAlignment=NSTextAlignmentCenter;
    [bigScrollView addSubview:banbenLab];
    
    UILabel * lineLab=[[UILabel alloc] initWithFrame:CGRectMake(10,10+CGRectGetHeight(smallImgView.frame)+10+CGRectGetHeight(banbenLab.frame), SCREEN_WIDTH-20, 0.5)];
    lineLab.backgroundColor=BG_COLOR;
    [bigScrollView addSubview:lineLab];
    
    
    UILabel * bgLab1=[[UILabel alloc] initWithFrame:CGRectMake(10,10+CGRectGetHeight(smallImgView.frame)+10+CGRectGetHeight(banbenLab.frame)+10, SCREEN_WIDTH-20, 25)];
    bgLab1.backgroundColor=[UIColor blackColor];
    bgLab1.alpha=0.2;
    [bigScrollView addSubview:bgLab1];
    
    UILabel * lab2=[[UILabel alloc] initWithFrame:CGRectMake(10,10+CGRectGetHeight(smallImgView.frame)+10+CGRectGetHeight(banbenLab.frame)+10, 100, 25)];
    lab2.text=@"企业简介：";
    lab2.font=[UIFont systemFontOfSize:14];
    lab2.textAlignment=NSTextAlignmentCenter;
    [bigScrollView addSubview:lab2];
    
    UILabel * shuomingLab1=[[UILabel alloc] initWithFrame:CGRectMake(10,10+CGRectGetHeight(smallImgView.frame)+10+CGRectGetHeight(banbenLab.frame)+10+CGRectGetHeight(lab2.frame)+5, self.view.frame.size.width-20,70)];
    shuomingLab1.numberOfLines=0;
    shuomingLab1.textColor=[UIColor grayColor];
    shuomingLab1.font=[UIFont systemFontOfSize:14];
    shuomingLab1.text=@"    清一丽网是南京本土儿童类信息分类门户网站。为南京家长提供所有儿童相关信息的一站式服务。成立于2013年，隶属于南京清一丽婴童用品有限公司。公司位于江苏省南京市雨花台区大周路39号。\n    为让广大用户切身享受到本地近距离的便捷信息服务。作为分类信息行业的后起之秀，清一丽网不断优化用户体验，增加功能满足最终用户的需求，以为广大用户提供“最真实、最有效、最全面”的信息服务为奋斗目标。我们会及时的发布、更新最新的信息。涵盖 择校、兴趣爱好、教育培训、儿童健康.....。\n    我们承诺所有信息均经过人工核实保证真实有效。每一位用户都是我们的宝贵资源。我们会尽我们的最大努力满足用户的需求。并始终站在用户的角度客观真实的反应事实。维护、声张用户的合法权益。\n    我们期待您的参与，和我们一起建设清一丽网。";
    CGSize autoSize=[shuomingLab1.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:shuomingLab1.font} context:nil].size;
    shuomingLab1.frame=CGRectMake(10,10+CGRectGetHeight(smallImgView.frame)+10+CGRectGetHeight(banbenLab.frame)+10+CGRectGetHeight(lab2.frame)+5, self.view.frame.size.width-20,autoSize.height);
    [bigScrollView addSubview:shuomingLab1];
    
    UILabel * bgLab2=[[UILabel alloc] initWithFrame:CGRectMake(10,10+CGRectGetHeight(smallImgView.frame)+10+CGRectGetHeight(banbenLab.frame)+10+CGRectGetHeight(lab2.frame)+5+CGRectGetHeight(shuomingLab1.frame)+5, SCREEN_WIDTH-20, 25)];
    bgLab2.backgroundColor=[UIColor blackColor];
    bgLab2.alpha=0.2;
    [bigScrollView addSubview:bgLab2];
    
    UILabel * lab3=[[UILabel alloc] initWithFrame:CGRectMake(10,10+CGRectGetHeight(smallImgView.frame)+10+CGRectGetHeight(banbenLab.frame)+10+CGRectGetHeight(lab2.frame)+5+CGRectGetHeight(shuomingLab1.frame)+5,100, 25)];
    lab3.text=@"联系我们：";
    lab3.font=[UIFont systemFontOfSize:14];
    lab3.textAlignment=NSTextAlignmentCenter;
    [bigScrollView addSubview:lab3];
    
    UILabel * shuomingLab=[[UILabel alloc] initWithFrame:CGRectMake(10,10+CGRectGetHeight(smallImgView.frame)+10+CGRectGetHeight(banbenLab.frame)+10+CGRectGetHeight(lab2.frame)+5+CGRectGetHeight(shuomingLab1.frame)+5+CGRectGetHeight(lab3.frame)+5, SCREEN_WIDTH-20,240)];
    shuomingLab.numberOfLines=0;
    shuomingLab.textColor=[UIColor grayColor];
    shuomingLab.font=[UIFont systemFontOfSize:14];
    shuomingLab.text=@"联系人：清一丽市场部\n联系电话：025-8963-8177\n邮箱：service@qin16.com\n地址：江苏省南京市雨花台区大周路39号\n传真：025-52829065";
    CGSize autoSize1=[shuomingLab.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:shuomingLab.font} context:nil].size;
    shuomingLab.frame=CGRectMake(10,10+CGRectGetHeight(smallImgView.frame)+10+CGRectGetHeight(banbenLab.frame)+10+CGRectGetHeight(lab2.frame)+5+CGRectGetHeight(shuomingLab1.frame)+5+CGRectGetHeight(lab3.frame)+5, self.view.frame.size.width-20,autoSize1.height);
    [bigScrollView addSubview:shuomingLab];


    bigScrollView.contentSize=CGSizeMake(SCREEN_WIDTH,10+CGRectGetHeight(smallImgView.frame)+10+CGRectGetHeight(banbenLab.frame)+10+CGRectGetHeight(lab2.frame)+5+CGRectGetHeight(shuomingLab1.frame)+5+CGRectGetHeight(lab3.frame)+5+autoSize1.height+10);
}
-(void)leftBtnCilck
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
