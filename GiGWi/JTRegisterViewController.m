//
//  JTRegisterViewController.m
//  Qyli
//
//  Created by 小七 on 14-7-31.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import "JTRegisterViewController.h"
#import "JTProtocalViewController.h"

@interface JTRegisterViewController ()<UITextFieldDelegate>
{
    UIButton * _selectedBtn;
    UIScrollView * _bigScrollView;
    
    UITextField * _phoneTextField;
    UITextField * _sPswTextField;
    UITextField * _yanzhengmaTextField;

    UITextField * _userNameTextField;
    UITextField * _zPswTextField;
    UITextField * _againPswTextField;
    
    UIView * _view1;
    UIView *_view2;
    
    NSString * _phoneKey;
    
    BOOL isAgreen;

}

@end

@implementation JTRegisterViewController

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
    isAgreen=0;
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
    navTitailLab.text=@"注册";
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
    //背景滚动视图
    _bigScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height-64-49)];
    [self.view addSubview:_bigScrollView];
    _bigScrollView.contentSize=CGSizeMake(self.view.frame.size.width,[UIScreen mainScreen].bounds.size.height-64-49+146);

    //自定义选项卡
    UIButton * btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setImage:[UIImage imageNamed:@"手机注册-2.png"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"手机注册-1.png"] forState:UIControlStateDisabled];
    btn1.frame=CGRectMake(0, 0,self.view.frame.size.width/2.0, 40);
    [btn1 addTarget:self action:@selector(changeStyle:) forControlEvents:UIControlEventTouchUpInside];
    btn1.tag=10;
    _selectedBtn=btn1;
    btn1.enabled=NO;
    [_bigScrollView addSubview:btn1];

    UIButton * btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setImage:[UIImage imageNamed:@"账号注册-2.png"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"账号注册-1.png"] forState:UIControlStateDisabled];
    btn2.frame=CGRectMake(self.view.frame.size.width/2.0,0, self.view.frame.size.width/2.0, 40);
    [btn2 addTarget:self action:@selector(changeStyle:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag=20;
    [_bigScrollView addSubview:btn2];
    
    //手机注册UI
    _view1=[[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 180)];
    _view1.backgroundColor=[UIColor clearColor];
    [_bigScrollView addSubview:_view1];
    
    UIImageView * phoneImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"输入手机号框.png"]];
    phoneImgView.frame=CGRectMake(10, 10, self.view.frame.size.width-20, 40);
    [_view1 addSubview:phoneImgView];
    
    _phoneTextField=[[UITextField alloc] initWithFrame:CGRectMake(90, 10, self.view.frame.size.width-100-10, 40)];
    _phoneTextField.placeholder=@"请输入手机号";
    _phoneTextField.delegate=self;
    _phoneTextField.font=[UIFont systemFontOfSize:13];
    [_view1 addSubview:_phoneTextField];
    
    UIImageView * sPswImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"输入密码框.png"]];
    sPswImgView.frame=CGRectMake(10, 70, self.view.frame.size.width-20, 40);
    [_view1 addSubview:sPswImgView];
    
    _sPswTextField=[[UITextField alloc] initWithFrame:CGRectMake(90, 70, self.view.frame.size.width-100-10, 40)];
    _sPswTextField.placeholder=@"请输入密码";
    _sPswTextField.secureTextEntry=YES;
     _sPswTextField.delegate=self;
    _sPswTextField.font=[UIFont systemFontOfSize:13];
    [_view1 addSubview:_sPswTextField];

    
    UIImageView * yanzhengmaImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"输入验证码框.png"]];
    yanzhengmaImgView.frame=CGRectMake(10, 130, self.view.frame.size.width-20-100-10, 40);
    [_view1 addSubview:yanzhengmaImgView];
    
    _yanzhengmaTextField=[[UITextField alloc] initWithFrame:CGRectMake(90, 130, self.view.frame.size.width-100-10-100-10, 40)];
    _yanzhengmaTextField.placeholder=@"请输入验证码";
    _yanzhengmaTextField.font=[UIFont systemFontOfSize:13];
      _yanzhengmaTextField.delegate=self;
    [_view1 addSubview:_yanzhengmaTextField];
    
    UIButton * yanzhengmabtn=[UIButton buttonWithType:UIButtonTypeCustom];
    yanzhengmabtn.backgroundColor=NAV_COLOR;
    [yanzhengmabtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [yanzhengmabtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    yanzhengmabtn.titleLabel.font=[UIFont systemFontOfSize:15];
    yanzhengmabtn.frame=CGRectMake(self.view.frame.size.width-100-10, 130, 100, 40);
    [yanzhengmabtn addTarget:self action:@selector(getMessage) forControlEvents:UIControlEventTouchUpInside];
    [_view1 addSubview:yanzhengmabtn];
    
    
    //账户注册UI
    _view2=[[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 180)];
    _view2.backgroundColor=[UIColor clearColor];
    _view2.hidden=YES;
    [_bigScrollView addSubview:_view2];
    
    UIImageView * nameImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"输入用户名框.png"]];
    nameImgView.frame=CGRectMake(10, 10, self.view.frame.size.width-20, 40);
    [_view2 addSubview:nameImgView];
    
    _userNameTextField=[[UITextField alloc] initWithFrame:CGRectMake(90, 10, self.view.frame.size.width-100-10, 40)];
    _userNameTextField.placeholder=@"请输入用户名";
      _userNameTextField.delegate=self;
    _userNameTextField.font=[UIFont systemFontOfSize:13];
    [_view2 addSubview:_userNameTextField];
    
    
    UIImageView * zPswImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"输入密码框.png"]];
    zPswImgView.frame=CGRectMake(10, 70, self.view.frame.size.width-20, 40);
    [_view2 addSubview:zPswImgView];
    
    _zPswTextField=[[UITextField alloc] initWithFrame:CGRectMake(90, 70, self.view.frame.size.width-100-10, 40)];
    _zPswTextField.placeholder=@"请输入密码";
    _zPswTextField.secureTextEntry=YES;
      _zPswTextField.delegate=self;
    _zPswTextField.font=[UIFont systemFontOfSize:13];
    [_view2 addSubview:_zPswTextField];
    
    UIImageView * againPsdImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"再次输入密码框.png"]];
    againPsdImgView.frame=CGRectMake(10, 130, self.view.frame.size.width-20, 40);
    [_view2 addSubview:againPsdImgView];
    
    _againPswTextField=[[UITextField alloc] initWithFrame:CGRectMake(90, 130, self.view.frame.size.width-100-10, 40)];
    _againPswTextField.secureTextEntry=YES;
      _againPswTextField.delegate=self;
    _againPswTextField.placeholder=@"请再次输入密码";
    _againPswTextField.font=[UIFont systemFontOfSize:13];
    [_view2 addSubview:_againPswTextField];

    
    //同意隐私协议
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"选择框.png"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"选中背景框.png"] forState:UIControlStateSelected];

    btn.selected=YES;
    isAgreen=1;
    btn.frame=CGRectMake(10, 230,22, 20);
    [btn addTarget:self action:@selector(agreenProtocal:) forControlEvents:UIControlEventTouchUpInside];
    [_bigScrollView addSubview:btn];
    
    
    UIButton * protocalBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [protocalBtn setTitle:@"同意GiGwi协议" forState:UIControlStateNormal];
    [protocalBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    protocalBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    protocalBtn.frame=CGRectMake(30, 230,100, 20);
    [protocalBtn addTarget:self action:@selector(lookProtocal) forControlEvents:UIControlEventTouchUpInside];
    [_bigScrollView addSubview:protocalBtn];
    
    
    //注册按钮
    UIButton * registerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"立即注册按钮.png"] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(goRegister) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.frame=CGRectMake(10,260, self.view.frame.size.width-20, 35);
    [_bigScrollView addSubview:registerBtn];
    
    _bigScrollView.contentSize=CGSizeMake(SCREEN_WIDTH, 300);
    
}
-(void)getMessage
{
    if ([SOAPRequest checkNet])
    {
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:_phoneTextField.text,@"phone", nil];
        
        NSDictionary * yanzhengDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_Regist_SendPhoneCodeMsgURL] jsonDic:jsondic]];
        
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

-(void)agreenProtocal:(UIButton *)sender
{
    if (isAgreen==1)
    {
        sender.selected=NO;
    }
    else
    {
        sender.selected=YES;
    }
    isAgreen=!isAgreen;
}
-(void)lookProtocal
{
    JTProtocalViewController * pVC=[[JTProtocalViewController alloc] init];
    [self presentViewController:pVC  animated:YES completion:nil];
}
-(void)leftBtnCilck
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)changeStyle:(UIButton *)sender
{
    if (sender!=_selectedBtn)
    {
        _selectedBtn.enabled=YES;
        sender.enabled=NO;
        _selectedBtn=sender;
    }

    if (sender.tag==10)
    {
        _view1.hidden=NO;
        _view2.hidden=YES;
    }
    else
    {
        _view1.hidden=YES;
        _view2.hidden=NO;
    }
    
}
-(void)goRegister
{
    [self.view endEditing:YES];
    if (isAgreen==0)
    {
        NSString * str=@"您尚未同意服务条款，注册失败！";
        [JTAlertViewAnimation startAnimation:str view:self.view];
        return;
    }
    if (_selectedBtn.tag==10)
    {
        if ([_phoneTextField.text isEqualToString:@""]||[_sPswTextField.text isEqualToString:@""]||[_yanzhengmaTextField.text isEqualToString:@""])
        {
            NSString * str=@"请正确填写注册信息！";
            [JTAlertViewAnimation startAnimation:str view:self.view];
            return;
        }
        if ([SOAPRequest checkNet])
        {
            NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:_phoneTextField.text,@"phone",[MyMD5 md5:_sPswTextField.text],@"password",_phoneKey,@"phoneKey",_yanzhengmaTextField.text,@"phoneCode", nil];
            
            NSDictionary * registerPhoneDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_Regist_SaveRegisterUserPhoneURL] jsonDic:jsondic]];
            if ([[registerPhoneDic objectForKey:@"resultCode"] intValue]!=1000)
            {
                
                if ([registerPhoneDic objectForKey:@"errorMessage"]!=nil)
                {
                    NSString * str=[registerPhoneDic objectForKey:@"errorMessage"];
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                }
                else if ([[registerPhoneDic objectForKey:@"resultCode"] intValue]==2000)
                {
                    NSString * str=@"手机验证码已过期";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                }
                else if ([[registerPhoneDic objectForKey:@"resultCode"] intValue]==2005)
                {
                    NSString * str=@"手机验证码错误";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                }
                else if ([[registerPhoneDic objectForKey:@"resultCode"] intValue]==2004)
                {
                    NSString * str=@"手机号已经存在，不能重复注册！";
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
                _loginVC.nameTextField.text=_phoneTextField.text;
                _loginVC.psdTextField.text=_sPswTextField.text;
                NSString * str=@"手机注册成功！";
                [JTAlertViewAnimation startAnimation:str view:self.view];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
            
        }


    }
    else
    {
        if ([_userNameTextField.text isEqualToString:@""]||[_zPswTextField.text isEqualToString:@""]||[_againPswTextField.text isEqualToString:@""])
        {
            NSString * str=@"请正确填写注册信息！";
            [JTAlertViewAnimation startAnimation:str view:self.view];
            return;
        }
        if (![_zPswTextField.text isEqualToString:_againPswTextField.text])
        {
            NSString * str=@"请注意：两次所输密码不一致！";
            [JTAlertViewAnimation startAnimation:str view:self.view];
            return;
        }
        if ([SOAPRequest checkNet])
        {
            NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:_userNameTextField.text,@"loginName",[MyMD5 md5:_againPswTextField.text],@"password", nil];
            
            NSDictionary * registerDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_Regist_SaveRegisterUserURL] jsonDic:jsondic]];
            
            if ([[registerDic objectForKey:@"resultCode"] intValue]==1000)
            {
                
                _loginVC.nameTextField.text=_userNameTextField.text;
                _loginVC.psdTextField.text=_againPswTextField.text;
                NSString * str=@"账户注册成功！";
                [JTAlertViewAnimation startAnimation:str view:self.view];
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }
            else
            {
                if ([registerDic objectForKey:@"errorMessage"]!=nil)
                {
                    NSString * str=[registerDic objectForKey:@"errorMessage"];
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                }
                else if ([[registerDic objectForKey:@"resultCode"] intValue]==2002)
                {
                    NSString * str=@"登录名已存在!";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                }
                else
                {
                    NSString * str=@"服务器异常，请稍后重试...";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                }
                
            }

        }

    
    }

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _bigScrollView.contentSize=CGSizeMake(SCREEN_WIDTH, 550);

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _bigScrollView.contentSize=CGSizeMake(SCREEN_WIDTH, 300);
    [self.view endEditing:YES];
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
