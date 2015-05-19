//
//  JTPeopleViewController.m
//  GiGWi
//
//  Created by 小七 on 15-4-21.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTPeopleViewController.h"
#import "JTPersonalMegViewController.h"
#import "JTGouwucheViewController.h"
#import "JTSettingViewController.h"
#import "JTtuijianViewController.h"
#import "JTDingdanListViewController.h"


@interface JTPeopleViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tabView;
    NSArray * _titleArr;
    NSArray * _imgNameArr;
    
    UIView * view1;
    UILabel * lab1;
     UILabel * lab2;
    UIImageView * photoImgView1;
    
    UIView * view2;
}

@end

@implementation JTPeopleViewController
-(void)viewWillAppear:(BOOL)animated
{
     JTAppDelegate * appDelegate=[UIApplication sharedApplication].delegate;

    if ( [[[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"] intValue]==1)
    {
        [self.view bringSubviewToFront:view1];
        lab1.text=[NSString stringWithFormat:@"%@",appDelegate.appUser.userName];
        if (![appDelegate.appUser.yaoqingma isEqualToString:@""]&&appDelegate.appUser.yaoqingma!=nil)
        {
            lab2.text=[NSString stringWithFormat:@"邀请码:%@",appDelegate.appUser.yaoqingma];
        }
        [photoImgView1 setImageWithURL:[NSURL URLWithString:appDelegate.appUser.headPortraitImgUrlStr] placeholderImage:[UIImage imageNamed:@"头像.png"]];
    }
    else
    {
        [self.view bringSubviewToFront:view2];

    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self readyUI];
}
-(void)readyUI
{
    self.view.backgroundColor=BG_COLOR;
    self.navigationController.navigationBar.hidden=YES;
    
    //登录模块
    
    
    //会员登录
    view1=[[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT*3/10.0)];
    [self.view addSubview:view1];
    
    UIImageView *bgImgView1=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"个人中心背景.png"]];
    bgImgView1.frame=CGRectMake(0, 0,SCREEN_WIDTH ,CGRectGetHeight(view1.frame));
    [view1 addSubview:bgImgView1];
    
    photoImgView1=[[UIImageView alloc] initWithFrame:CGRectMake(30, (CGRectGetHeight(view1.frame))/4.0, (CGRectGetHeight(view1.frame))/2.0, (CGRectGetHeight(view1.frame))/2.0)];
    photoImgView1.layer.masksToBounds=YES;
    photoImgView1.layer.cornerRadius=(CGRectGetHeight(view1.frame))/4.0;
    [view1 addSubview:photoImgView1];
    
    lab1= [[UILabel alloc] initWithFrame:CGRectMake(60+(CGRectGetHeight(view1.frame))/2.0, ((CGRectGetHeight(view1.frame))-40)/2.0, SCREEN_WIDTH-(CGRectGetHeight(view1.frame))/2.0-60-20,40)];
    lab1.textColor=[UIColor whiteColor];
    lab1.font=[UIFont systemFontOfSize:24];
    [view1 addSubview:lab1];
    
    lab2= [[UILabel alloc] initWithFrame:CGRectMake(60+(CGRectGetHeight(view1.frame))/2.0, ((CGRectGetHeight(view1.frame))-40)/2.0+40, SCREEN_WIDTH-(CGRectGetHeight(view1.frame))/2.0-60-20,40)];
    lab2.textColor=[UIColor whiteColor];
    lab2.font=[UIFont systemFontOfSize:20];
    [view1 addSubview:lab2];
    

    
    
    view2=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*3/10.0)];
    view2.backgroundColor=[UIColor clearColor];
    [self.view addSubview:view2];
    
    UIImageView *bgImgView2=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"个人中心背景.png"]];
    bgImgView2.frame=CGRectMake(0, 0,SCREEN_WIDTH ,CGRectGetHeight(view2.frame));
    [view2 addSubview:bgImgView2];
    
    UILabel * lab3=[[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetHeight(view2.frame)/2.0-30, SCREEN_WIDTH, 30)];
    lab3.text=@"欢迎来到GiGwi";
    lab3.textColor=[UIColor whiteColor];
    lab3.textAlignment=NSTextAlignmentCenter;
    lab3.font=[UIFont systemFontOfSize:18];
    [view2 addSubview:lab3];
    
    UIButton * loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame=CGRectMake((self.view.frame.size.width-120)/2.0,CGRectGetHeight(view2.frame)/2.0+5, 120, 30);
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"登录注册背景框.png"] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录  /  注册" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [loginBtn addTarget:self action:@selector(goLogin) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:loginBtn];

    
    _tabView=[[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetHeight(view1.frame),SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetHeight(view1.frame)-NAV_HEIGHT) style:UITableViewStylePlain];
    _tabView.dataSource=self;
    _tabView.delegate=self;
    _tabView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tabView.backgroundColor=BG_COLOR;
    [self.view addSubview:_tabView];
    
    _titleArr=@[@"个人信息",@"我的订单",@"我的购物车",@"我的推荐",@"设置"];
    _imgNameArr=@[@"个人信息.png",@"我的订单.png",@"我的购物车.png",@"我的推荐.png",@"设置.png"];

}
-(void)goLogin
{
    JTLoginViewController * loginVC=[[JTLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _titleArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    UILabel * lab=[[UILabel alloc] initWithFrame:CGRectMake(40, 12, 200, 20)];
    lab.font=[UIFont systemFontOfSize:14];
    lab.textColor=[UIColor grayColor];
    [cell addSubview:lab];
    UIImageView * imgView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 20, 20)];
    [cell addSubview:imgView];
    UIImageView * imgView2=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30, 15, 8, 10)];
    imgView2.image=[UIImage imageNamed:@"右箭头.png"];
    [cell addSubview:imgView2];
    
    UILabel * lineLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 43.5, SCREEN_WIDTH, 0.5)];
    lineLab.backgroundColor=[UIColor lightGrayColor];
    [cell addSubview:lineLab];
    
    lab.text=[_titleArr objectAtIndex:indexPath.row] ;
    imgView.image=[UIImage imageNamed:[_imgNameArr objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"] isEqualToString:@"0"])
    {
        JTLoginViewController * loginVC=[[JTLoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请先登录哦。。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK，我知道了。。", nil];
        [alertView show];
        
    }
    else
    {
        switch (indexPath.row)
        {
            case 0:
            {
                //个人信息
                JTPersonalMegViewController * pVC=[[JTPersonalMegViewController alloc] init];
                [self.navigationController pushViewController:pVC animated:YES];

            }
                break;
            case 1:
            {
                //订单
                JTDingdanListViewController * myVC=[[JTDingdanListViewController alloc] init];
                [self.navigationController pushViewController:myVC animated:YES];
            }
                break;
            case 2:
            {
                JTGouwucheViewController * myCoVc= [[JTGouwucheViewController alloc] init];
                [self.navigationController pushViewController:myCoVc animated:YES];
            }
                break;
            case 3:
            {
                JTtuijianViewController * myCoVc= [[JTtuijianViewController alloc] init];
                [self.navigationController pushViewController:myCoVc animated:YES];
                
            }
                break;
            case 4:
            {
                JTSettingViewController * setVC=[[JTSettingViewController alloc] init];
                [self.navigationController pushViewController:setVC animated:YES];
                
            }
                break;
                
            default:
                break;
        }
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
