//
//  JTLoginViewController.m
//  Qyli
//
//  Created by 小七 on 14-7-31.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import "JTLoginViewController.h"

#import "JTRegisterViewController.h"
#import "JTFindPsdViewController.h"


@interface JTLoginViewController ()
{
    BOOL isSave;
}
@end

@implementation JTLoginViewController

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
    self.view.backgroundColor=BG_COLOR;
    self.navigationController.navigationBar.hidden=YES;
    //自定义导航条    
    UIView * navLab=[[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 44)];
    navLab.userInteractionEnabled=YES;
    navLab.backgroundColor=NAV_COLOR;
    [self.view addSubview:navLab];
    
    UILabel * navTitailLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/2.0, 44)];
    navTitailLab.text=@"登录";
    navTitailLab.textAlignment=NSTextAlignmentCenter;
    navTitailLab.textColor=[UIColor whiteColor];
    navTitailLab.font=[UIFont systemFontOfSize:18];
    [navLab addSubview:navTitailLab];
    
    UIButton * leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame=CGRectMake(0, 0, 80, NAV_HEIGHT);
    [leftBtn addTarget:self action:@selector(leftBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    [navLab addSubview:leftBtn];
    
    UIImageView * backImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"返回按钮.png"]];
    backImgView.frame=CGRectMake(20, (NAV_HEIGHT-15)/2, 10, 15);
    [leftBtn addSubview:backImgView];
    
    
    UIButton * rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(self.view.frame.size.width-70-6, 0, 70, 44);
    [rightBtn setTitle:@"| 注册" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navLab addSubview:rightBtn];
    
    //用户名和密码
    UIImageView * nameImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"输入账号框.png"]];
    nameImgView.frame=CGRectMake(10, 74, self.view.frame.size.width-20, 40);
    [self.view addSubview:nameImgView];
    
    _nameTextField=[[UITextField alloc] initWithFrame:CGRectMake(90, 74, self.view.frame.size.width-100-10, 40)];
    _nameTextField.placeholder=@"请输入用户名/邮箱/手机号";
    _nameTextField.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:_nameTextField];
    
    UIImageView * psdImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"输入密码框.png"]];
    psdImgView.frame=CGRectMake(10, 124, self.view.frame.size.width-20, 40);
    [self.view addSubview:psdImgView];
    
    _psdTextField=[[UITextField alloc] initWithFrame:CGRectMake(90, 124, self.view.frame.size.width-100-10, 40)];
    _psdTextField.secureTextEntry=YES;
    _psdTextField.placeholder=@"请输入密码";
    _psdTextField.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:_psdTextField];
    
    //自动登录、找回密码、登录
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"选择框.png"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"选中背景框.png"] forState:UIControlStateSelected];
    btn.selected=YES;
    isSave=1;
    btn.frame=CGRectMake(15, 180, 22, 20);
    [btn addTarget:self action:@selector(savePsd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel * autoLab=[[UILabel alloc] initWithFrame:CGRectMake(45, 182, 60, 16)];
    autoLab.text=@"记住密码";
    autoLab.font=[UIFont systemFontOfSize:14];
    autoLab.textColor=[UIColor lightGrayColor];
    [self.view addSubview:autoLab];
    

    
    UILabel * getpsdLab=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-70-10, 182, 70, 16)];
    getpsdLab.text=@"忘记密码 ?";
    getpsdLab.textColor=NAV_COLOR;
    getpsdLab.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:getpsdLab];
    
    
    UIButton * findBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    findBtn.frame=CGRectMake(self.view.frame.size.width-70-10, 182, 70, 16);
    [findBtn addTarget:self action:@selector(findPsd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:findBtn];

    
    UIButton * loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame=CGRectMake(10, 210, self.view.frame.size.width-20, 35);
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"登录按钮.png"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBtnClick
{
    JTRegisterViewController * registerVC=[[JTRegisterViewController alloc] init];
    registerVC.loginVC=self;
    [self presentViewController:registerVC animated:YES completion:nil];
}

-(void)savePsd:(UIButton *)sender
{
   
    if (!isSave)
    {
        sender.selected=YES;
    }
    else
    {
        sender.selected=NO;
    
    }
    isSave=!isSave;
}
-(void)loginBtnClick
{
    [self.view endEditing:YES];
    if ([_nameTextField.text isEqualToString:@""]||[_psdTextField.text isEqualToString:@""])
    {
        NSString * str=@"用户名或密码不能为空！";
        [JTAlertViewAnimation startAnimation:str view:self.view];
    }
    else
    {
        if ([SOAPRequest checkNet])
        {
            NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:_nameTextField.text,@"loginName",[MyMD5 md5:_psdTextField.text],@"password", nil];
            
            NSDictionary * dic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_LoginURL] jsonDic:jsondic]];
            
            if ([[dic objectForKey:@"resultCode"] intValue]==1001)
            {
                NSString * str=@"用户名或密码已变更或过期，请检测后重新登录";
                [JTAlertViewAnimation startAnimation:str view:self.view];

            }
            else if([[dic objectForKey:@"resultCode"] intValue]==2009)
            {
                NSString * str=@"用户名不存在";
                [JTAlertViewAnimation startAnimation:str view:self.view];

            }
            else if([[dic objectForKey:@"resultCode"] intValue]==2010)
            {
                NSString * str=@"密码不正确";
                [JTAlertViewAnimation startAnimation:str view:self.view];

            }
            else if([[dic objectForKey:@"resultCode"] intValue]==1000)
            {
                UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"登录成功！" delegate:nil cancelButtonTitle:nil   otherButtonTitles:@"OK，我知道了。。", nil];
                [alertView show];
                
                
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isLogin"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                JTUser * user=[[JTUser alloc] init];
                NSDictionary * userDic=[dic objectForKey:@"user"];
                user.userID=[[userDic objectForKey:@"id"] intValue];
                user.loginName=[userDic objectForKey:@"loginName"];
                user.password=[userDic objectForKey:@"password"];
                user.userName=[userDic objectForKey:@"nickName"];
                user.headPortraitImgUrlStr=[userDic objectForKey:@"imageValue"];
                user.email=[userDic objectForKey:@"email"];
                user.phone=[userDic objectForKey:@"phone"];
                
                user.provinceID=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"provinceId"];
                user.cityID=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"cityId"];
                user.regionId=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"regionId"];
                user.streetId=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"streetId"];
                user.provinceValue=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"provinceValue"];
                user.cityValue=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"cityValue"];
                user.regionName=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"regionValue"];
                user.streetName=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"streetValue"];
                user.address=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"recipientAddress"];
                user.adressName=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"name"];
                user.adressTel=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"phone"];
                user.yaoqingma=[[userDic objectForKey:@"defultConsigneeAddress"] objectForKey:@"invitationCode"];
                
                JTAppDelegate * appDelegate=[UIApplication sharedApplication].delegate;
                appDelegate.appUser=user;

                
                if (isSave)
                {
                    [[NSUserDefaults standardUserDefaults] setObject:user.loginName forKey:@"loginName"];
                    [[NSUserDefaults standardUserDefaults] setObject:user.password forKey:@"password"];
                     [[NSUserDefaults standardUserDefaults] synchronize];
                }
                else
                {
                    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"loginName"])
                    {
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginName"];
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    }
                
                }
        
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            else
            {
                NSString * str=@"服务器异常，请稍后重试...";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }

        }
    }
    
}

-(void)findPsd
{
    JTFindPsdViewController * findVC=[[JTFindPsdViewController alloc] init];
    findVC.loginVC=self;
    [self.navigationController pushViewController:findVC animated:YES];
    
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
