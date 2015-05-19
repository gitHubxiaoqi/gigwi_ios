//
//  JTSearchViewController.m
//  GiGWi
//
//  Created by 小七 on 15-4-22.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTSearchViewController.h"

@interface JTSearchViewController ()
{
    UITextField * _seachTextField;
}

@end

@implementation JTSearchViewController
-(void)viewWillDisappear:(BOOL)animated
{
    JTAppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    appDelegate.tabBarView.hidden=NO;
}
-(void)viewDidAppear:(BOOL)animated
{
    JTAppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    appDelegate.tabBarView.hidden=YES;
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

    
    UIButton * leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame=CGRectMake(10,30, 40,40);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"商品详情-返回键.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    
    UIImageView * searchImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"搜索页-搜索框.png"]];
    searchImgView.frame=CGRectMake(55, 55, SCREEN_WIDTH-60-55-20, 10);
    [self.view addSubview:searchImgView];
    
    _seachTextField=[[UITextField alloc] initWithFrame:CGRectMake(65,40, SCREEN_WIDTH-60-55-20-20, 20)];
    _seachTextField.placeholder=@"请输入要搜索的关键字";
    _seachTextField.font=[UIFont systemFontOfSize:13];
    _seachTextField.textColor=[UIColor blackColor];
    [_seachTextField becomeFirstResponder];
    [self.view addSubview:_seachTextField];
    
    UIButton * searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(SCREEN_WIDTH-70, 40, 60, 30);
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"搜索按钮.png"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
}
-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)search
{
    [self.view endEditing:YES];
    NSLog(@"搜索字符串为:%@",_seachTextField.text);
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
