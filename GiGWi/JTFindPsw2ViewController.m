//
//  JTFindPsw2ViewController.m
//  GiGWi
//
//  Created by 小七 on 15-4-22.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTFindPsw2ViewController.h"

@interface JTFindPsw2ViewController ()
{
    UITextField * _newPswTextField;
    UITextField * _againPswTextField;
}
@end

@implementation JTFindPsw2ViewController
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
- (void)viewDidLoad {
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
    
    UILabel * navTitailLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    navTitailLab.text=@"找回密码";
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
    //用户名和密码
    UIImageView * nameImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"输入密码框.png"]];
    nameImgView.frame=CGRectMake(10, 74, self.view.frame.size.width-20, 40);
    [self.view addSubview:nameImgView];
    
    _newPswTextField=[[UITextField alloc] initWithFrame:CGRectMake(90, 74, self.view.frame.size.width-100-10, 40)];
    _newPswTextField.placeholder=@"请输入密码";
    _newPswTextField.secureTextEntry=YES;
    _newPswTextField.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:_newPswTextField];
    
    UIImageView * psdImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"再次输入密码框.png"]];
    psdImgView.frame=CGRectMake(10, 124, self.view.frame.size.width-20, 40);
    [self.view addSubview:psdImgView];
    
    _againPswTextField=[[UITextField alloc] initWithFrame:CGRectMake(90, 124, self.view.frame.size.width-100-10, 40)];
    _againPswTextField.secureTextEntry=YES;
    _againPswTextField.placeholder=@"请再次输入密码";
    _againPswTextField.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:_againPswTextField];
    
    
    //下一步
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor=NAV_COLOR;
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:15];
    btn.frame=CGRectMake(10, 180, self.view.frame.size.width-20, 35);
    [btn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
}
-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)finish
{
    [self.view endEditing:YES];
    if ([_newPswTextField.text isEqualToString:@""]||[_againPswTextField.text isEqualToString:@""])
    {
        NSString * str=@"请正确填写以上信息";
        [JTAlertViewAnimation startAnimation:str view:self.view];
        return;
    }
    if (![_newPswTextField.text isEqualToString:_againPswTextField.text])
    {
        NSString * str=@"请注意：两次所输密码不一致！";
        [JTAlertViewAnimation startAnimation:str view:self.view];
        return;
    }
    if ([SOAPRequest checkNet])
    {
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:_phoneNum,@"phone",[MyMD5 md5:_againPswTextField.text],@"password", nil];
        
        NSDictionary * phoneDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_ChangePasswordForgotPassword] jsonDic:jsondic]];
        if ([[phoneDic objectForKey:@"resultCode"] intValue]!=1000)
        {
            
            if ([phoneDic objectForKey:@"errorMessage"]!=nil)
            {
                NSString * str=[phoneDic objectForKey:@"errorMessage"];
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
            else
            {
                NSString * str=@"服务器异常，请稍后重试...";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
            
        }
        else if([[phoneDic objectForKey:@"resultCode"] intValue]==1000)
        {
            UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"密码重置成功！" delegate:nil cancelButtonTitle:@"OK，我知道了。。" otherButtonTitles:nil, nil];
            [alertView show];
            
            int count=(int)[self.navigationController.viewControllers indexOfObject:self]-2;
            JTLoginViewController * logVC=(JTLoginViewController *)[self.navigationController .viewControllers objectAtIndex:count];
            logVC.nameTextField.text=_phoneNum;
            logVC.psdTextField.text=_againPswTextField.text;
            [self.navigationController popToViewController:logVC animated:YES];
            
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
