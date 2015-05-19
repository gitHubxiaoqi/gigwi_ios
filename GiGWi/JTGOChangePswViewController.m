//
//  JTGOChangePswViewController.m
//  Qyli
//
//  Created by 小七 on 14-8-7.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import "JTGOChangePswViewController.h"

@interface JTGOChangePswViewController ()<UITextFieldDelegate>
{
    NSString * _newPsd;
    UIButton * sureBtn;
}

@end

@implementation JTGOChangePswViewController

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
    navTitailLab.text=@"修改密码";
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

    
    for (int i=0; i<3; i++)
    {
        UIImageView * imgView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 74+i*40, self.view.frame.size.width-20, 30)];
        imgView.image=[UIImage imageNamed:@"input_box_org.png"];
        imgView.userInteractionEnabled=YES;
        [self.view addSubview:imgView];
        UITextField * textField=[[UITextField alloc] initWithFrame:CGRectMake(10, 0, imgView.frame.size.width, imgView.frame.size.height)];
        textField.font=[UIFont systemFontOfSize:14];
        [imgView addSubview:textField];
        textField.tag=i+10;
        textField.delegate=self;
        textField.secureTextEntry=YES;
        switch (i)
        {
            case 0:
            {
                textField.placeholder=@"请输入原始密码";
            }
                break;
            case 1:
            {
                textField.placeholder=@"请输入新密码";
            }
                break;
            case 2:
            {
                textField.placeholder=@"确认新密码";
            }
                break;
                
            default:
                break;
        }
    }
    
    sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame=CGRectMake(10 , 200, self.view.frame.size.width-20, 35);
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"保存退出登录框.png"] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //sureBtn.enabled=NO;
    [self.view addSubview:sureBtn];
    
}
-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)sure
{
    
    JTAppDelegate * appdelegate=[UIApplication sharedApplication].delegate;

    NSString * passwordStr=@"";
    [self.view endEditing:YES];

    UITextField * textField=(UITextField *)[self.view viewWithTag:10];
    passwordStr=textField.text;
    UITextField * textField1=(UITextField *)[self.view viewWithTag:11];
    UITextField * textField2=(UITextField *)[self.view viewWithTag:12];
   
    if (![[MyMD5 md5:passwordStr] isEqualToString:appdelegate.appUser.password])
    {
       NSString * str=@"初始密码不正确，请重新输入...";
      [JTAlertViewAnimation startAnimation:str view:self.view];
        return;
    }
    else if (![textField1.text isEqualToString:textField2.text])
    {
        NSString * str=@"两次所输密码不一致，请重新输入...";
        [JTAlertViewAnimation startAnimation:str view:self.view];
        return;
    }
    if ([SOAPRequest checkNet])
    {
        [self.navigationController popViewControllerAnimated:YES];
        
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",appdelegate.appUser.userID],@"userId",[MyMD5 md5:passwordStr],@"password",[MyMD5 md5:_newPsd],@"newPassword", nil];
        
        NSDictionary * editPasswordDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_SaveEditPassword] jsonDic:jsondic]];

        if ([[editPasswordDic objectForKey:@"resultCode"] intValue]!=1000)
        {
             NSString * str=@"";
            if ([editPasswordDic objectForKey:@"errorMessage"]!=nil)
            {
                str=[editPasswordDic objectForKey:@"errorMessage"];
            }
            else if ([[editPasswordDic objectForKey:@"resultCode"] intValue]==2006)

            {
                str=@"密码错误...";
            }
            else
            {
                str=@"服务器异常，请稍后重试...";
            }
             [JTAlertViewAnimation startAnimation:str view:self.view];
        }
        else  if ([[editPasswordDic objectForKey:@"resultCode"] intValue]==1000)
        {
            UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"密码修改成功" delegate:nil cancelButtonTitle:nil   otherButtonTitles:@"OK，我知道了。。", nil];
            [alertView show];
        
            [[NSUserDefaults standardUserDefaults] setObject:[MyMD5 md5:_newPsd] forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            appdelegate.appUser.password=[MyMD5 md5:_newPsd];

            [self.navigationController popViewControllerAnimated:YES];
        }
    }

}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag)
    {
        case 10:
        {

            JTAppDelegate * appDelegate=[UIApplication sharedApplication].delegate;
            if (![[MyMD5 md5:textField.text] isEqualToString:appDelegate.appUser.password])
            {
                NSString * str=@"初始密码不正确！";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }

        }
            break;
        case 11:
        {
            if (textField.text.length==0)
            {
                NSString * str=@"密码不能为空！";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
            else
            {
                _newPsd=textField.text;
            }

        }
            break;
        case 12:
        {
            if (![textField.text isEqualToString:_newPsd])
            {
                NSString * str=@"请注意：两次所输密码不一致！";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
            else
            {
                sureBtn.enabled=YES;
            }
            break;
        }
        default:
            break;
    }

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
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
