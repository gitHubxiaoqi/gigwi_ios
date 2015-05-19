//
//  JTGOChangePhoneViewController.m
//  Qyli
//
//  Created by 小七 on 14-8-7.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import "JTGOChangePhoneViewController.h"

@interface JTGOChangePhoneViewController ()<UITextFieldDelegate>
{
    UIView * _contentView;
    int j;
    NSTimer * timer;
    int seconds;
    NSString * _phoneNum;
    NSString * _phoneKey;
    
    UIScrollView * _bigScrollView;
}
@end

@implementation JTGOChangePhoneViewController

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
    
    j=0;
    seconds=60;
    _bigScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:_bigScrollView];
    
    _bigScrollView.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+70-44);
    
    [self readyUI];
    _contentView=[[UIView alloc] initWithFrame:CGRectMake(10, 210-64, self.view.bounds.size.width-20,30)];
    [_bigScrollView addSubview:_contentView];
    
    UIView * view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
    view.tag=100;
    [self readySmallUI:(0) view:(view)];
    [_contentView addSubview:view];
}
-(void)readySmallUI:(int)i view:(UIView *)view
{
    switch (i)
    {
        case 0:
        {
            //2输入框
            JTAppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
            UIButton * Nextbtn=(UIButton *)[_bigScrollView viewWithTag:200];
            if (!appdelegate.appUser.phone)
            {
                UILabel * lab=[[UILabel alloc] initWithFrame:CGRectMake(0,0, 65, 30)];
                lab.text=@"账号密码";
                lab.font=[UIFont systemFontOfSize:14];
                lab.textAlignment=NSTextAlignmentLeft;
                lab.textColor=[UIColor blackColor];
                [view addSubview:lab];
                
                UIImageView * imgView=[[UIImageView alloc] initWithFrame:CGRectMake(65, 0, self.view.frame.size.width-20-65, 30)];
                imgView.image=[UIImage imageNamed:@"input_box_org.png"];
                imgView.userInteractionEnabled=YES;
                [view addSubview:imgView];
                
                UITextField * textField=[[UITextField alloc] initWithFrame:CGRectMake(10, 0, imgView.frame.size.width-10, imgView.frame.size.height)];
                textField.font=[UIFont systemFontOfSize:13];
                [imgView addSubview:textField];
                textField.placeholder=@"请输入账号密码";
                textField.tag=30;
                textField.secureTextEntry=YES;
                
                //设置view和contentView的高度
                CGRect rect=view.frame;
                rect.size.height=30;
                view.frame=rect;
                CGRect rect2=_contentView.frame;
                rect2.size.height=30;
                _contentView.frame=rect2;
                
                Nextbtn.frame=CGRectMake(10, 255-64, self.view.frame.size.width-20, 35);

            }
            else
            {
                UILabel * lab=[[UILabel alloc] initWithFrame:CGRectMake(0,0, 65, 30)];
                lab.text=@"手机号";
                lab.font=[UIFont systemFontOfSize:14];
                lab.textAlignment=NSTextAlignmentLeft;
                lab.textColor=[UIColor blackColor];
                [view addSubview:lab];
                
                UILabel * phoneLab=[[UILabel alloc] initWithFrame:CGRectMake(65, 0, self.view.frame.size.width-20-65, 30)];
                phoneLab.textColor=[UIColor orangeColor];
                phoneLab.text=appdelegate.appUser.phone;
                [view addSubview:phoneLab];
                
                UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
                [btn setBackgroundImage:[UIImage imageNamed:@"保存退出登录框.png"] forState:UIControlStateNormal];
                [btn setTitle:[NSString stringWithFormat:@"获取短信验证码%d",seconds] forState:UIControlStateNormal];
                btn.tag=90;
                [btn setTintColor:[UIColor whiteColor]];
                btn.titleLabel.font=[UIFont systemFontOfSize:14];
                btn.frame=CGRectMake(90, 35, 120, 30);
                [btn addTarget:self action:@selector(getMessage) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
                
                
                //2输入框
                
                UILabel * lab2=[[UILabel alloc] initWithFrame:CGRectMake(0,70, 65, 30)];
                lab2.text=@"验证码";
                lab2.font=[UIFont systemFontOfSize:14];
                lab2.textAlignment=NSTextAlignmentLeft;
                lab2.textColor=[UIColor blackColor];
                [view addSubview:lab2];
                
                UIImageView * imgView2=[[UIImageView alloc] initWithFrame:CGRectMake(65, 70, self.view.frame.size.width-20-65, 30)];
                imgView2.image=[UIImage imageNamed:@"input_box_org.png"];
                imgView2.userInteractionEnabled=YES;
                [view addSubview:imgView2];
                
                UITextField * textField2=[[UITextField alloc] initWithFrame:CGRectMake(10, 0, imgView2.frame.size.width-10, imgView2.frame.size.height)];
                textField2.font=[UIFont systemFontOfSize:13];
                [imgView2 addSubview:textField2];
                textField2.placeholder=@"请输入验证码";
                textField2.tag=55;
                textField2.delegate=self;
                textField2.secureTextEntry=YES;
                
                //设置view和contentView的高度
                CGRect rect=view.frame;
                rect.size.height=95;
                view.frame=rect;
                CGRect rect2=_contentView.frame;
                rect2.size.height=95;
                _contentView.frame=rect2;
                
                Nextbtn.frame=CGRectMake(10, _contentView.frame.origin.y+_contentView.frame.size.height+20, self.view.frame.size.width-20, 35);
                _phoneNum=appdelegate.appUser.phone;
            }
            
            
        }
            break;
        case 1:
        {
            //2输入框
            
            UILabel * lab=[[UILabel alloc] initWithFrame:CGRectMake(0,0, 65, 30)];
            lab.text=@"手机号";
            lab.font=[UIFont systemFontOfSize:14];
            lab.textAlignment=NSTextAlignmentLeft;
            lab.textColor=[UIColor blackColor];
            [view addSubview:lab];
            
            UIImageView * imgView=[[UIImageView alloc] initWithFrame:CGRectMake(65, 0, self.view.frame.size.width-20-65, 30)];
            imgView.image=[UIImage imageNamed:@"input_box_org.png"];
            imgView.userInteractionEnabled=YES;
            [view addSubview:imgView];
            
            UITextField * textField=[[UITextField alloc] initWithFrame:CGRectMake(10, 0, imgView.frame.size.width-10, imgView.frame.size.height)];
            textField.font=[UIFont systemFontOfSize:13];
            [imgView addSubview:textField];
            textField.placeholder=@"请输入手机号";
            textField.tag=40;
            textField.delegate=self;
            
            UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundImage:[UIImage imageNamed:@"保存退出登录框.png"] forState:UIControlStateNormal];
            [btn setTitle:[NSString stringWithFormat:@"获取短信验证码%d",seconds] forState:UIControlStateNormal];
            btn.tag=90;
            [btn setTintColor:[UIColor whiteColor]];
            btn.titleLabel.font=[UIFont systemFontOfSize:14];
            btn.frame=CGRectMake(90, 35, 120, 30);
            [btn addTarget:self action:@selector(getMessage) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];

            
            //2输入框
            
            UILabel * lab2=[[UILabel alloc] initWithFrame:CGRectMake(0,70, 65, 30)];
            lab2.text=@"验证码";
            lab2.font=[UIFont systemFontOfSize:14];
            lab2.textAlignment=NSTextAlignmentLeft;
            lab2.textColor=[UIColor blackColor];
            [view addSubview:lab2];
            
            UIImageView * imgView2=[[UIImageView alloc] initWithFrame:CGRectMake(65, 70, self.view.frame.size.width-20-65, 30)];
            imgView2.image=[UIImage imageNamed:@"input_box_org.png"];
            imgView2.userInteractionEnabled=YES;
            [view addSubview:imgView2];
            
            UITextField * textField2=[[UITextField alloc] initWithFrame:CGRectMake(10, 0, imgView2.frame.size.width-10, imgView2.frame.size.height)];
            textField2.font=[UIFont systemFontOfSize:13];
            [imgView2 addSubview:textField2];
            textField2.placeholder=@"请输入验证码";
            textField2.tag=50;
            textField2.delegate=self;
            textField2.secureTextEntry=YES;
            
            //设置view和contentView的高度
            CGRect rect=view.frame;
            rect.size.height=95;
            view.frame=rect;
            CGRect rect2=_contentView.frame;
            rect2.size.height=95;
            _contentView.frame=rect2;
            
        }
            break;
            
        default:
            break;
    }
    
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
    navTitailLab.text=@"更改手机认证";
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
    
    //3步骤
    NSArray * titleArr=[[NSArray alloc] initWithObjects:@"1.确认个人信息",@"2手机号绑定", nil];
    for (int i=0; i<2; i++)
    {
        UIImageView * imgView=[[UIImageView alloc] initWithFrame:CGRectMake(10+i*((self.view.frame.size.width-20)/2.0), 80-64, (self.view.frame.size.width-20)/2.0, 30)];
        imgView.tag=i+10;
        [_bigScrollView addSubview:imgView];
        
        UILabel * lab=[[UILabel alloc] initWithFrame:CGRectMake(10+i*((self.view.frame.size.width-20)/2.0), 80-64, (self.view.frame.size.width-20)/2.0, 30)];
        lab.tag=20+i;
        if (i==0)
        {
            lab.textColor=[UIColor whiteColor];
            imgView.image=[UIImage imageNamed:@"找回密码-1"];
        }
        else
        {
            imgView.image=[UIImage imageNamed:@"找回密码-3"];
        
        }
        lab.text=[titleArr objectAtIndex:i];
        lab.font=[UIFont systemFontOfSize:14];
        lab.textAlignment=NSTextAlignmentCenter;
        [_bigScrollView addSubview:lab];
    }
    
    //线lab
    UILabel * lineLab=[[UILabel alloc] initWithFrame:CGRectMake(10, 80+42-64, self.view.frame.size.width-20, 1)];
    lineLab.backgroundColor=[UIColor lightGrayColor];
    [_bigScrollView addSubview:lineLab];
    
    //说明lab
    UILabel * explineLab=[[UILabel alloc] initWithFrame:CGRectMake(10,125-64, self.view.frame.size.width-20, 20)];
    explineLab.text=@"绑定说明：";
    explineLab.font=[UIFont systemFontOfSize:14];
    explineLab.textAlignment=NSTextAlignmentLeft;
    explineLab.textColor=[UIColor blackColor];
    [_bigScrollView addSubview:explineLab];
    
    UILabel * explineLab2=[[UILabel alloc] initWithFrame:CGRectMake(10,145-64, self.view.frame.size.width-20, 60)];
    explineLab2.numberOfLines=0;
    explineLab2.text=@"1.认证后不可取消认证，可更改手机重新认证。\n2.新手机修改并通过认证后，可用于登录，旧手机不能继续使用。";
    explineLab2.font=[UIFont systemFontOfSize:13];
    explineLab2.textAlignment=NSTextAlignmentLeft;
    explineLab2.textColor=[UIColor grayColor];
    [_bigScrollView addSubview:explineLab2];
    
    
    
    //下一步
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"保存退出登录框.png"] forState:UIControlStateNormal];
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:15];
    btn.frame=CGRectMake(10, 255-64, self.view.frame.size.width-20, 35);
    btn.tag=200;
    [btn addTarget:self action:@selector(Next:) forControlEvents:UIControlEventTouchUpInside];
    [_bigScrollView addSubview:btn];
}
-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)Next:(UIButton *)sender
{
    [self.view endEditing:YES];
    if(j==0)
    {
        JTAppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
        if (!appdelegate.appUser.phone)
        {
            UITextField * textField=(UITextField *)[self.view viewWithTag:30];
            if (_lastVC.myUser!=nil)
            {
                if (![[MyMD5 md5:textField.text] isEqualToString:_lastVC.myUser.password])
                {
                    NSString * str=@"密码不正确！";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                    return;
                }
                
            }
            else
            {
                if (![[MyMD5 md5:textField.text] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]])
                {
                    NSString * str=@"密码不正确！";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                    return;
                }
                
            }
        }
        else
        {
            UITextField * yanzhengTextField=(UITextField *)[_bigScrollView viewWithTag:55];
            
            NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:_phoneNum,@"phone", yanzhengTextField.text,@"phoneCode", _phoneKey,@"phoneKey",nil];
            
            NSDictionary * yanzhengDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_ValidateCurrentBoundPhoneCodeForBindingPhone] jsonDic:jsondic]];
            
            if ([[yanzhengDic objectForKey:@"resultCode"] intValue]!=1000)
            {
                
                if ([yanzhengDic objectForKey:@"errorMessage"]!=nil)
                {
                    NSString * str=[yanzhengDic objectForKey:@"errorMessage"];
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                }
                else if ([[yanzhengDic objectForKey:@"resultCode"] intValue]==2005)
                {
                    NSString * str=@"手机验证码错误";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                }
                else if ([[yanzhengDic objectForKey:@"resultCode"] intValue]==2000)
                {
                    NSString * str=@"手机验证码已过期";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                }
                else
                {
                    NSString * str=@"服务器异常，请稍后重试...";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                }
                return;
            }
            else
            {
                seconds=1;
                NSString * str=@"恭喜，旧手机解绑成功";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
        
        }
        
    }
    
    if (j==1)
    {

            JTAppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
            UITextField * yanzhengTextFiled=(UITextField *)[self.view viewWithTag:50];
            
            if ([SOAPRequest checkNet])
            {
                NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",appdelegate.appUser.userID],@"userId", _phoneNum,@"phone",yanzhengTextFiled.text,@"phoneCode", _phoneKey,@"phoneKey", nil];
                
                NSDictionary * yanzhengDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_ValidatePhoneCodeAndSaveForBindingPhone] jsonDic:jsondic]];
                
                if ([[yanzhengDic objectForKey:@"resultCode"] intValue]!=1000)
                {
                    
                    if ([yanzhengDic objectForKey:@"errorMessage"]!=nil)
                    {
                        NSString * str=[yanzhengDic objectForKey:@"errorMessage"];
                        [JTAlertViewAnimation startAnimation:str view:self.view];
                    }
                    else if ([[yanzhengDic objectForKey:@"resultCode"] intValue]==2005)
                    {
                        NSString * str=@"手机验证码错误";
                        [JTAlertViewAnimation startAnimation:str view:self.view];
                    }
                    else if ([[yanzhengDic objectForKey:@"resultCode"] intValue]==2000)
                    {
                        NSString * str=@"手机验证码已过期";
                        [JTAlertViewAnimation startAnimation:str view:self.view];
                    }
                    else if ([[yanzhengDic objectForKey:@"resultCode"] intValue]==2004)
                    {
                        NSString * str=@"手机号已被绑定";
                        [JTAlertViewAnimation startAnimation:str view:self.view];
                    }
                    else
                    {
                        NSString * str=@"服务器异常，请稍后重试...";
                        [JTAlertViewAnimation startAnimation:str view:self.view];
                    }
                    return;
                }

                else
                {
                    UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"绑定成功！" delegate:nil cancelButtonTitle:@"OK，我知道了。。" otherButtonTitles:nil, nil];
                    [alertView show];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        
     }

    UIView * laterView=[self.view viewWithTag:100];
    [laterView removeFromSuperview];
    UIView * view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
    view.tag=100;
    
    if (j==0)
    {
        [self readySmallUI:1 view:view];
        UIImageView * imgView=(UIImageView *)[self.view viewWithTag:10];
        imgView.image=[UIImage imageNamed:@"找回密码-2"];
        UILabel * lab=(UILabel *)[self.view viewWithTag:20];
        lab.textColor=[UIColor blackColor];
        
        UIImageView * imgView2=(UIImageView *)[self.view viewWithTag:11];
        imgView2.image=[UIImage imageNamed:@"找回密码-4"];
        UILabel * lab2=(UILabel *)[self.view viewWithTag:21];
        lab2.textColor=[UIColor whiteColor];
        [sender setTitle:@"绑定" forState:UIControlStateNormal];
        j++;
    }
    [_contentView addSubview:view];
    sender.frame=CGRectMake(10, _contentView.frame.origin.y+_contentView.frame.size.height+20, self.view.frame.size.width-20, 35);
}
-(void)getMessage
{
    [self.view endEditing:YES];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    
    if ([SOAPRequest checkNet])
    {
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:_phoneNum,@"phone", nil];
        
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
-(void)timerFireMethod:(NSTimer *)theTimer
{
    UIButton * btn=(UIButton *)[self.view viewWithTag:90];
    if (seconds == 1)
    {
        [theTimer invalidate];
        seconds = 60;
        [btn setEnabled:YES];
        [btn setTitle:[NSString stringWithFormat:@"获取短信验证码%d",seconds] forState:UIControlStateNormal];
        
    }else
    {
        seconds--;
        [btn setEnabled:NO];
        [btn setTitle:[NSString stringWithFormat:@"获取短信验证码%d",seconds] forState:UIControlStateDisabled];
        
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag)
    {
        case 40:
        {
            _phoneNum=textField.text;

        }
            break;
        case 50:
        {
            
        }
            break;
        default:
            break;
    }

}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{

    if (textField.tag==50)
    {
        [_bigScrollView scrollRectToVisible:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height) animated:YES];
        [timer invalidate];
        seconds=60;
        UIButton * btn=(UIButton *)[self.view viewWithTag:90];
        [btn setEnabled:YES];
        [btn setTitle:[NSString stringWithFormat:@"获取短信验证码%d",seconds] forState:UIControlStateNormal];
        
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
