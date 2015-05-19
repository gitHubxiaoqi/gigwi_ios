//
//  JTSetNameViewController.m
//  Qyli
//
//  Created by 小七 on 14-8-4.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import "JTSetNameViewController.h"
#import "JTAppDelegate.h"

@interface JTSetNameViewController ()
{

    UITextField * _textField;
}

@end

@implementation JTSetNameViewController

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
    navTitailLab.text=@"用户名";
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
    
    UIImageView * imgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"input_content_bg.png"]];
    imgView.userInteractionEnabled=YES;
    imgView.frame=CGRectMake(10, 74, self.view.frame.size.width-20, 35);
    [self.view addSubview:imgView];
    
    _textField=[[UITextField alloc] initWithFrame:CGRectMake(5, 0, self.view.frame.size.width-20-5*2, 35)];
    _textField.text=self.pVC.myUser.userName;
    [_textField becomeFirstResponder];
    [imgView addSubview:_textField];
    
    UIButton * saveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setBackgroundImage:[UIImage imageNamed:@"保存退出登录框.png"] forState:UIControlStateNormal];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    saveBtn.frame=CGRectMake(10, 120, self.view.frame.size.width-20, 35);
    [saveBtn addTarget:self action:@selector(saveBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];

}
-(void)saveBtn
{
    [self xiugai];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)xiugai
{
    if ([SOAPRequest checkNet])
    {
        
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self.pVC.myUser.userID],@"userId",_textField.text,@"nickName",@"",@"headPortrait", nil];
        
        NSDictionary * editUserDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_SaveEditUser] jsonDic:jsondic]];
        
        if ([[editUserDic objectForKey:@"resultCode"] intValue]!=1000)
        {
            if ([editUserDic objectForKey:@"errorMessage"]!=nil)
            {
                NSString * str=[editUserDic objectForKey:@"errorMessage"];
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
            else
            {
                NSString * str=@"服务器异常，请稍后重试...";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
            
        }
        else if ([[editUserDic objectForKey:@"resultCode"] intValue]==1000)
        {
            JTAppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
            appdelegate.appUser.userName=_textField.text;
            
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
