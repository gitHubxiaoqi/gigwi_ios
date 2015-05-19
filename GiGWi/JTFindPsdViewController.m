//
//  JTFindPsdViewController.m
//  Qyli
//
//  Created by 小七 on 14-8-1.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import "JTFindPsdViewController.h"
#import "JTFindPsw2ViewController.h"

@interface JTFindPsdViewController ()<UITextFieldDelegate>
{
    NSString * _phoneKey;
    UITextField * _phoneTextField;
    UITextField * _yanzhengmaTextField;
    
}
@property(strong,nonatomic)UILabel * checkCodeNumberLabel;
@end

@implementation JTFindPsdViewController

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
    UIImageView * nameImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"输入手机号框.png"]];
    nameImgView.frame=CGRectMake(10, 74, self.view.frame.size.width-20, 40);
    [self.view addSubview:nameImgView];
    
    _phoneTextField=[[UITextField alloc] initWithFrame:CGRectMake(90, 74, self.view.frame.size.width-100-10, 40)];
    _phoneTextField.placeholder=@"请输入手机号";
    _phoneTextField.delegate=self;
    _phoneTextField.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:_phoneTextField];
    
    UIImageView * psdImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"输入验证码框.png"]];
    psdImgView.frame=CGRectMake(10, 124, self.view.frame.size.width-20-100-10, 40);
    [self.view addSubview:psdImgView];
    
    _yanzhengmaTextField=[[UITextField alloc] initWithFrame:CGRectMake(90, 124, self.view.frame.size.width-100-10-100-10, 40)];
    _yanzhengmaTextField.placeholder=@"请输入验证码";
    _yanzhengmaTextField.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:_yanzhengmaTextField];
    
    UIButton * btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.backgroundColor=NAV_COLOR;
    [btn1 setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.titleLabel.font=[UIFont systemFontOfSize:15];
    btn1.frame=CGRectMake(self.view.frame.size.width-100-10, 124, 100, 40);
    [btn1 addTarget:self action:@selector(getMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    //下一步
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor=NAV_COLOR;
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:15];
    btn.frame=CGRectMake(10, 180, self.view.frame.size.width-20, 35);
    [btn addTarget:self action:@selector(Next) forControlEvents:UIControlEventTouchUpInside];
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
-(void)getMessage
{
    if ([SOAPRequest checkNet])
    {
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:_phoneTextField.text,@"phone", nil];
        
        NSDictionary * yanzhengDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_SendPhoneCodeMsg] jsonDic:jsondic]];
        
        if ([[yanzhengDic objectForKey:@"resultCode"] intValue]!=1000)
        {
            
            if ([yanzhengDic objectForKey:@"errorMessage"]!=nil)
            {
                NSString * str=[yanzhengDic objectForKey:@"errorMessage"];
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
            else if ([[yanzhengDic objectForKey:@"resultCode"] intValue]==2001)
            {
                NSString * str=@"2分钟之内发送过验证码";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
            else
            {
                NSString * str=@"服务器异常，请稍后重试...";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
            
        }
        else
        {
            _phoneKey=[yanzhengDic objectForKey:@"phoneKey"];
        }
        
    }
    
}
-(void)Next
{
    [self.view endEditing:YES];
    if ([_phoneTextField.text isEqualToString:@""]||[_yanzhengmaTextField.text isEqualToString:@""])
    {
        NSString * str=@"请正确填写以上信息";
        [JTAlertViewAnimation startAnimation:str view:self.view];
        return;
    }
    if ([SOAPRequest checkNet])
    {
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:_phoneTextField.text,@"phone",_phoneKey,@"phoneKey",_yanzhengmaTextField.text,@"phoneCode", nil];
        
        NSDictionary * phoneDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_ValidatePhoneCodeForgotPassword] jsonDic:jsondic]];
        if ([[phoneDic objectForKey:@"resultCode"] intValue]!=1000)
        {
            
            if ([phoneDic objectForKey:@"errorMessage"]!=nil)
            {
                NSString * str=[phoneDic objectForKey:@"errorMessage"];
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
            else if ([[phoneDic objectForKey:@"resultCode"] intValue]==2005)
            {
                NSString * str=@"手机验证码错误";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
            else if ([[phoneDic objectForKey:@"resultCode"] intValue]==2000)
            {
                NSString * str=@"手机验证码已过期";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
            else
            {
                NSString * str=@"服务器异常，请稍后重试...";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
            
        }
        else if ([[phoneDic objectForKey:@"resultCode"] intValue]==1000)
        {
            JTFindPsw2ViewController * findVC2=[[JTFindPsw2ViewController alloc] init];
            findVC2.phoneNum=_phoneTextField.text;
            [self.navigationController pushViewController:findVC2 animated:YES];
        }

    }

    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField==_phoneTextField)
    {
        if ([SOAPRequest checkNet])
        {
            NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:textField.text,@"phone", nil];
            
            NSDictionary * phoneDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_ValidatephoneBindingForgotPassword] jsonDic:jsondic]];
            
            if ([[phoneDic objectForKey:@"resultCode"] intValue]!=1000)
            {
                
                if ([phoneDic objectForKey:@"errorMessage"]!=nil)
                {
                    NSString * str=[phoneDic objectForKey:@"errorMessage"];
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                }
                else if ([[phoneDic objectForKey:@"resultCode"] intValue]==2007)
                {
                    UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"该手机号未经过绑定,不能用来找回密码！" delegate:nil cancelButtonTitle:@"OK，我知道了。。" otherButtonTitles:nil, nil];
                    [alertView show];
                }
                
             }
        }

    }
 
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
