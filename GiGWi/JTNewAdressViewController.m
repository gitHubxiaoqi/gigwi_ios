//
//  JTNewAdressViewController.m
//  GiGWi
//
//  Created by 小七 on 15-4-24.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTNewAdressViewController.h"

@interface JTNewAdressViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView * _bigScrollView;
    UILabel * _shengshiquLab;
    UITextField * _nameTextField;
    UITextField * _infoAdressTextField;
    UITextField * _telTextField;
    UIButton * _changyongBtn;
    BOOL  isChangyong;
    
    
    UITableView * _provinceTabView;
    UITableView * _cityTableView;
    UITableView * _quTabView;
    UITableView * _streetTableView;
    
    NSMutableArray * _provinceTitleArr;
    NSMutableArray * _cityTitleArr;
    NSMutableArray * _quTitleArr;
    NSMutableArray * _provinceIDArr;
    NSMutableArray * _cityIDArr;
    NSMutableArray * _quIDArr;

    
    NSMutableArray * _streetIDArrSmall;
    NSMutableArray * _streetTitleArrSmall;
    
    UIView * _bgView;
    UIScrollView * _bgScrollView;

    
    
    int pcount;
    int ccount;
    int qcount;
    int scount;
    
    NSString * _pIDStr;
    NSString * _cIDStr;
    NSString * _qIDStr;
    NSString * _sIDStr;

}

@end

@implementation JTNewAdressViewController
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
    
    JTAppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    _provinceTitleArr=[[NSMutableArray alloc] initWithArray:appDelegate.provinceTitleArr];
    _cityTitleArr=[[NSMutableArray alloc] initWithArray:appDelegate.cityTitleArr];
    _provinceIDArr=[[NSMutableArray alloc] initWithArray:appDelegate.provinceIDArr];
    _cityIDArr=[[NSMutableArray alloc] initWithArray:appDelegate.cityIDArr];
    _quTitleArr=[[NSMutableArray alloc] initWithArray:appDelegate.quTitleArr];
    _quIDArr=[[NSMutableArray alloc] initWithArray:appDelegate.quIDArr];
    
    _streetIDArrSmall=[[NSMutableArray alloc] initWithCapacity:0];
    _streetTitleArrSmall=[[NSMutableArray alloc] initWithCapacity:0];
    
    pcount=0;
    ccount=0;
    qcount=0;
    scount=0;
    
    _pIDStr=@"";
    _cIDStr=@"";
    _qIDStr=@"";
    _sIDStr=@"";

    
    isChangyong=NO;
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
    if(self.adressModel==nil)
    {
        navTitailLab.text=@"新增收货地址";
    }
    else
    {
         navTitailLab.text=@"修改收货地址";
    }

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
    
    _bigScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 20+NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-20-NAV_HEIGHT)];
    _bigScrollView.backgroundColor=BG_COLOR;
    _bigScrollView.contentSize=CGSizeMake(SCREEN_WIDTH,CGRectGetHeight(_bigScrollView.frame));
    [self.view addSubview:_bigScrollView];

    if (self.adressModel==nil)
    {
        _nameTextField=[[UITextField alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 38)];
        _nameTextField.font=[UIFont systemFontOfSize:18];
        _nameTextField.textColor=[UIColor blackColor];
        _nameTextField.textAlignment=NSTextAlignmentLeft;
        _nameTextField.placeholder=@"收货人姓名";
        _nameTextField.delegate=self;
        [_bigScrollView addSubview:_nameTextField];
        
        UILabel * lineLab1=[[UILabel alloc] initWithFrame:CGRectMake(10, 39, SCREEN_WIDTH-20, 0.5)];
        lineLab1.backgroundColor=[UIColor lightGrayColor];
        [_bigScrollView addSubview:lineLab1];
        
        UILabel * quyuLab=[[UILabel alloc] initWithFrame:CGRectMake(20, 40, 40, 38)];
        quyuLab.textColor=[UIColor blackColor];
        quyuLab.textAlignment=NSTextAlignmentCenter;
        quyuLab.text=@"区域";
        quyuLab.font=[UIFont systemFontOfSize:18];
        [_bigScrollView addSubview:quyuLab];
        
        _shengshiquLab=[[UILabel alloc] initWithFrame:CGRectMake(60, 40, SCREEN_WIDTH-60-30, 38)];
        _shengshiquLab.textColor=[UIColor lightGrayColor];
        _shengshiquLab.textAlignment=NSTextAlignmentCenter;
        _shengshiquLab.text=@"请选择区域";
        _shengshiquLab.tag=102;
        _shengshiquLab.font=[UIFont systemFontOfSize:16];
        [_bigScrollView addSubview:_shengshiquLab];
        
        UIImageView * jiantouImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"右箭头.png"]];
        jiantouImgView.frame=CGRectMake(SCREEN_WIDTH-25, 52, 12, 15);
        [_bigScrollView addSubview:jiantouImgView];
        
        UILabel * lineLab2=[[UILabel alloc] initWithFrame:CGRectMake(10, 79, SCREEN_WIDTH-20, 0.5)];
        lineLab2.backgroundColor=[UIColor lightGrayColor];
        [_bigScrollView addSubview:lineLab2];
        
        _infoAdressTextField=[[UITextField alloc] initWithFrame:CGRectMake(20, 80, SCREEN_WIDTH-40, 38)];
        _infoAdressTextField.font=[UIFont systemFontOfSize:14];
        _infoAdressTextField.textColor=[UIColor grayColor];
        _infoAdressTextField.textAlignment=NSTextAlignmentLeft;
        _infoAdressTextField.placeholder=@"详细地址";
        _infoAdressTextField.delegate=self;
        [_bigScrollView addSubview:_infoAdressTextField];
        
        UILabel * lineLab3=[[UILabel alloc] initWithFrame:CGRectMake(10, 119, SCREEN_WIDTH-20, 0.5)];
        lineLab3.backgroundColor=[UIColor lightGrayColor];
        [_bigScrollView addSubview:lineLab3];

        
        _telTextField=[[UITextField alloc] initWithFrame:CGRectMake(20, 120, SCREEN_WIDTH-40, 38)];
        _telTextField.font=[UIFont systemFontOfSize:14];
        _telTextField.textColor=[UIColor blackColor];
        _telTextField.textAlignment=NSTextAlignmentLeft;
        _telTextField.placeholder=@"联系电话";
        _telTextField.delegate=self;
        [_bigScrollView addSubview:_telTextField];
        
        UILabel * lineLab4=[[UILabel alloc] initWithFrame:CGRectMake(10,159, SCREEN_WIDTH-20, 0.5)];
        lineLab4.backgroundColor=[UIColor lightGrayColor];
        [_bigScrollView addSubview:lineLab4];

        UILabel * changyongLab=[[UILabel alloc] initWithFrame:CGRectMake(20, 180, 150, 20)];
        changyongLab.text=@"设为常用地址";
        changyongLab.textColor=[UIColor blackColor];
        changyongLab.font=[UIFont systemFontOfSize:13];
        [_bigScrollView addSubview:changyongLab];
        
        _changyongBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _changyongBtn.frame=CGRectMake(SCREEN_WIDTH-60, 175, 30,30);
        [_changyongBtn setImage:[UIImage imageNamed:@"选择框.png"] forState:UIControlStateNormal];
        [_changyongBtn setImage:[UIImage imageNamed:@"选中背景框.png"] forState:UIControlStateSelected];
        [_changyongBtn addTarget:self action:@selector(sheweichangyong:) forControlEvents:UIControlEventTouchUpInside];
        [_bigScrollView addSubview:_changyongBtn];
        
    }
    else
    {
        _nameTextField=[[UITextField alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 38)];
        _nameTextField.font=[UIFont systemFontOfSize:18];
        _nameTextField.textColor=[UIColor blackColor];
        _nameTextField.textAlignment=NSTextAlignmentLeft;
        _nameTextField.text=self.adressModel.name;
        _nameTextField.placeholder=@"收货人姓名";
        _nameTextField.delegate=self;
        [_bigScrollView addSubview:_nameTextField];
        
        UILabel * lineLab1=[[UILabel alloc] initWithFrame:CGRectMake(10, 39, SCREEN_WIDTH-20, 0.5)];
        lineLab1.backgroundColor=[UIColor lightGrayColor];
        [_bigScrollView addSubview:lineLab1];
        
        
        _shengshiquLab=[[UILabel alloc] initWithFrame:CGRectMake(20, 40, SCREEN_WIDTH-20-30, 38)];
        _shengshiquLab.textColor=[UIColor blackColor];
        _shengshiquLab.textAlignment=NSTextAlignmentLeft;
        _shengshiquLab.text=[NSString stringWithFormat:@"%@  %@  %@  %@",self.adressModel.provinceStr,self.adressModel.cityStr,self.adressModel.quStr,self.adressModel.street];
        _shengshiquLab.tag=102;
        _shengshiquLab.font=[UIFont systemFontOfSize:16];
        [_bigScrollView addSubview:_shengshiquLab];
        
        UIImageView * jiantouImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"右箭头.png"]];
        jiantouImgView.frame=CGRectMake(SCREEN_WIDTH-25, 52, 12, 15);
        [_bigScrollView addSubview:jiantouImgView];
        
        UILabel * lineLab2=[[UILabel alloc] initWithFrame:CGRectMake(10, 79, SCREEN_WIDTH-20, 0.5)];
        lineLab2.backgroundColor=[UIColor lightGrayColor];
        [_bigScrollView addSubview:lineLab2];
        
        _infoAdressTextField=[[UITextField alloc] initWithFrame:CGRectMake(20, 80, SCREEN_WIDTH-40, 38)];
        _infoAdressTextField.font=[UIFont systemFontOfSize:14];
        _infoAdressTextField.textColor=[UIColor grayColor];
        _infoAdressTextField.textAlignment=NSTextAlignmentLeft;
        _infoAdressTextField.text=[NSString stringWithFormat:@"%@",self.adressModel.infoAddress];
        _infoAdressTextField.placeholder=@"详细地址";
        _infoAdressTextField.delegate=self;
        [_bigScrollView addSubview:_infoAdressTextField];
        
        UILabel * lineLab3=[[UILabel alloc] initWithFrame:CGRectMake(10, 119, SCREEN_WIDTH-20, 0.5)];
        lineLab3.backgroundColor=[UIColor lightGrayColor];
        [_bigScrollView addSubview:lineLab3];
        
        
        _telTextField=[[UITextField alloc] initWithFrame:CGRectMake(20, 120, SCREEN_WIDTH-40, 38)];
        _telTextField.font=[UIFont systemFontOfSize:14];
        _telTextField.textColor=[UIColor blackColor];
        _telTextField.textAlignment=NSTextAlignmentLeft;
        _telTextField.text=self.adressModel.tel;
        _telTextField.delegate=self;
        _telTextField.placeholder=@"联系电话";
        [_bigScrollView addSubview:_telTextField];
        
        UILabel * lineLab4=[[UILabel alloc] initWithFrame:CGRectMake(10,159, SCREEN_WIDTH-20, 0.5)];
        lineLab4.backgroundColor=[UIColor lightGrayColor];
        [_bigScrollView addSubview:lineLab4];
        
        UILabel * changyongLab=[[UILabel alloc] initWithFrame:CGRectMake(20, 180, 150, 20)];
        changyongLab.text=@"设为常用地址";
        changyongLab.textColor=[UIColor blackColor];
        changyongLab.font=[UIFont systemFontOfSize:13];
        [_bigScrollView addSubview:changyongLab];
        
        _changyongBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _changyongBtn.frame=CGRectMake(SCREEN_WIDTH-60, 175, 30,30);
        [_changyongBtn setImage:[UIImage imageNamed:@"选择框.png"] forState:UIControlStateNormal];
        [_changyongBtn setImage:[UIImage imageNamed:@"选中背景框.png"] forState:UIControlStateSelected];
        [_changyongBtn addTarget:self action:@selector(sheweichangyong:) forControlEvents:UIControlEventTouchUpInside];
        [_bigScrollView addSubview:_changyongBtn];
        
        if([self.adressModel.isChangyong intValue]==1)
        {
            _changyongBtn.selected=YES;
        }

    }
    
    UIButton * adressBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    adressBtn.frame=CGRectMake(0, 40, SCREEN_WIDTH, 40);
    adressBtn.backgroundColor=[UIColor clearColor];
    [adressBtn addTarget:self action:@selector(chooseArea) forControlEvents:UIControlEventTouchUpInside];
    [_bigScrollView addSubview:adressBtn];
    
    UIButton * saveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame=CGRectMake(10, 230, SCREEN_WIDTH-20, 40);
    saveBtn.backgroundColor=NAV_COLOR;
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font=[UIFont systemFontOfSize:20];
    [saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [_bigScrollView addSubview:saveBtn];
    
    
    _bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-80)];
    _bgView.backgroundColor=[UIColor whiteColor];
    
    _bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(_bgView.frame)-40)];
    _bgScrollView.scrollEnabled=NO;
    _bgScrollView.contentSize=CGSizeMake(2*SCREEN_WIDTH, CGRectGetHeight(_bgScrollView.frame));
    [_bgView addSubview:_bgScrollView];
    
    UILabel * pcLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_bgScrollView.frame), 40)];
    pcLab.backgroundColor=NAV_COLOR;
    pcLab.text=@"请选择所在省市";
    pcLab.font=[UIFont systemFontOfSize:18];
    pcLab.textColor=[UIColor whiteColor];
    pcLab.textAlignment=NSTextAlignmentCenter;
    [_bgScrollView addSubview:pcLab];
    
    UILabel * qsLab=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, CGRectGetWidth(_bgScrollView.frame), 40)];
    qsLab.backgroundColor=NAV_COLOR;
    qsLab.text=@"请选择所在区和街道";
    qsLab.font=[UIFont systemFontOfSize:18];
    qsLab.textColor=[UIColor whiteColor];
    qsLab.textAlignment=NSTextAlignmentCenter;
    [_bgScrollView addSubview:qsLab];
    
    UIButton * backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(SCREEN_WIDTH, 0, 50, 40);
    [backBtn addTarget:self action:@selector(backPC) forControlEvents:UIControlEventTouchUpInside];
    [_bgScrollView addSubview:backBtn];
    
    UIImageView * backImgView1=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"返回按钮.png"]];
    backImgView1.frame=CGRectMake(SCREEN_WIDTH+5, 12, 12, 15);
    [_bgScrollView addSubview:backImgView1];
    
    _provinceTabView=[[UITableView   alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH/2.0, CGRectGetHeight(_bgScrollView.frame)-40) style:UITableViewStylePlain];
    _provinceTabView.tag=301;
    _provinceTabView.delegate=self;
    _provinceTabView.dataSource=self;
    [_bgScrollView addSubview:_provinceTabView];
    
    _cityTableView=[[UITableView   alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0, 40, SCREEN_WIDTH/2.0, CGRectGetHeight(_bgScrollView.frame)-40) style:UITableViewStylePlain];
    _cityTableView.hidden=YES;
    _cityTableView.tag=302;
    _cityTableView.delegate=self;
    _cityTableView.dataSource=self;
    [_bgScrollView addSubview:_cityTableView];
    
    _quTabView=[[UITableView   alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 40, SCREEN_WIDTH/2.0, CGRectGetHeight(_bgScrollView.frame)-40) style:UITableViewStylePlain];
    _quTabView.tag=303;
    _quTabView.hidden=YES;
    _quTabView.delegate=self;
    _quTabView.dataSource=self;
    [_bgScrollView addSubview:_quTabView];
    
    _streetTableView=[[UITableView   alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*3/2.0, 40, SCREEN_WIDTH/2.0, CGRectGetHeight(_bgScrollView.frame)-40) style:UITableViewStylePlain];
    _streetTableView.tag=304;
    _streetTableView.hidden=YES;
    _streetTableView.delegate=self;
    _streetTableView.dataSource=self;
    [_bgScrollView addSubview:_streetTableView];
    
    UIButton * sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setBackgroundColor:NAV_COLOR];
    [sureBtn setTitle:@"确  定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    sureBtn.frame=CGRectMake(0, CGRectGetHeight(_bgView.frame)-40, SCREEN_WIDTH, 40);
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:sureBtn];
    
}
-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)save
{
    [self.view endEditing:YES];
    
    if ([_nameTextField.text isEqualToString:@""]||[_infoAdressTextField .text isEqualToString:@""]||[_telTextField.text isEqualToString:@""])
    {
        NSString * str=@"请完整填写以上信息";
        [JTAlertViewAnimation startAnimation:str view:self.view];
        return;
    }
    if (self.adressModel)
    {
        if ([[NSString stringWithFormat:@"%@",_pIDStr] isEqualToString:@""]||_pIDStr==nil)
        {
            if (self.adressModel.provinceIDStr!=nil)
            {
                _pIDStr=self.adressModel.provinceIDStr;
            }
            if (self.adressModel.cityIDStr!=nil)
            {
                _cIDStr=self.adressModel.cityIDStr;
            }
            if (self.adressModel.quIDStr!=nil)
            {
                _qIDStr=self.adressModel.quIDStr;
            }
            if (self.adressModel.streetIDStr!=nil)
            {
                _sIDStr=self.adressModel.streetIDStr;
            }
        }
    }

    
    if ([SOAPRequest checkNet])
    {
        JTAppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
       
        if(self.adressModel==nil)
        {
            NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:_nameTextField.text,@"name",_pIDStr,@"provinceId",_cIDStr,@"cityId",_qIDStr,@"regionId",_sIDStr,@"streetId",_infoAdressTextField.text,@"recipientAddress",_telTextField.text,@"phone",[NSString stringWithFormat:@"%d",appdelegate.appUser.userID],@"userId",[NSString stringWithFormat:@"%d",isChangyong],@"status", nil];
            
            NSDictionary * zaojiaoListDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_AddConsigneeAddress] jsonDic:jsondic]];
            if ([[NSString stringWithFormat:@"%@",[zaojiaoListDic objectForKey:@"resultCode"]] isEqualToString:@"1000"])
            {
                UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"地址添加成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
                self.adressListVC.p=1;
                [self.navigationController popViewControllerAnimated:YES];
                 [self getNewUser];
            }
            else
            {
                NSString * str=@"服务器异常，请稍后重试...";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }

        }
        else
        {
            NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:_adressModel.idStr,@"id",_nameTextField.text,@"name",_pIDStr,@"provinceId",_cIDStr,@"cityId",_qIDStr,@"regionId",_sIDStr,@"streetId",_infoAdressTextField.text,@"recipientAddress",_telTextField.text,@"phone",[NSString stringWithFormat:@"%d",appdelegate.appUser.userID],@"userId",[NSString stringWithFormat:@"%d",isChangyong],@"status", nil];
            
            NSDictionary * zaojiaoListDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_UpdateConsigneeAddress] jsonDic:jsondic]];
            if ([[NSString stringWithFormat:@"%@",[zaojiaoListDic objectForKey:@"resultCode"]] isEqualToString:@"1000"])
            {
                UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"地址修改成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
                self.adressListVC.p=1;
                [self.navigationController popViewControllerAnimated:YES];
                [self getNewUser];
            }
            else
            {
                NSString * str=@"服务器异常，请稍后重试...";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }

        }

        
    }

}
-(void)getNewUser
{
    JTAppDelegate * appdelegate=[UIApplication sharedApplication].delegate;

    if ([SOAPRequest checkNet])
    {
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",appdelegate.appUser.userID],@"userId", nil];
        
        NSDictionary * zaojiaoListDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_GetUserInfoById] jsonDic:jsondic]];
        if ([[NSString stringWithFormat:@"%@",[zaojiaoListDic objectForKey:@"resultCode"]] isEqualToString:@"1000"])
        {
            JTUser * user=[[JTUser alloc] init];
            NSDictionary * userDic=[zaojiaoListDic objectForKey:@"user"];
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

        }
        else
        {
            NSString * str=@"服务器异常，请稍后重试...";
            [JTAlertViewAnimation startAnimation:str view:self.view];
        }

    }
}
-(void)sheweichangyong:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (sender.selected==YES)
    {
        sender.selected=NO;
        isChangyong=NO;
    }
    else
    {
        sender.selected=YES;
        isChangyong=YES;
    }

}
-(void)chooseArea
{
    [self.view endEditing:YES];
    NSLog(@"选择区域");
    pcount=0;
    ccount=0;
    qcount=0;
    scount=0;
    
    _cityTableView.hidden=YES;
    _quTabView.hidden=YES;
    _streetTableView.hidden=YES;
    
    
    [_provinceTabView reloadData];
    [_cityTableView reloadData];
    [_quTabView reloadData];
    [_streetTableView reloadData];
    
    [self.view addSubview:_bgView];
    [_bgScrollView scrollRectToVisible:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(_bgScrollView.frame)) animated:NO];

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];

}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _bigScrollView.contentSize=CGSizeMake(SCREEN_WIDTH,280+250);

}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _bigScrollView.contentSize=CGSizeMake(SCREEN_WIDTH,280);

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableView.tag-300)
    {
        case 1:
        {
            return _provinceTitleArr.count;
        }
            break;
        case 2:
        {
            if (pcount!=0)
            {
                return [[_cityTitleArr objectAtIndex:pcount-1] count];
            }
            else
            {
                return 0;
            }
            
        }
            break;
        case 3:
        {
            if (pcount!=0&&ccount!=0)
            {
                return [[[_quTitleArr objectAtIndex:pcount-1] objectAtIndex:ccount-1] count];
            }
            else
            {
                return 0;
            }
            
        }
            break;
        case 4:
        {
            if (_streetTitleArrSmall.count!=0)
            {
                return _streetTitleArrSmall.count;
            }
            else
            {
                return 0;
            }
            
        }
            break;
            
        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        UILabel * lineLab=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(cell.frame)-0.5, CGRectGetWidth(tableView.frame), 0.5)];
        lineLab.backgroundColor=[UIColor brownColor];
        [cell addSubview:lineLab];
        
        UILabel * lineLab2=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(tableView.frame)-0.5, 0, 0.5, CGRectGetHeight(cell.frame))];
        lineLab2.backgroundColor=[UIColor brownColor];
        [cell addSubview:lineLab2];
        
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        
        switch (tableView.tag-300)
        {
            case 1:
            {
                cell.textLabel.text=[_provinceTitleArr objectAtIndex:indexPath.row];
            }
                break;
            case 2:
            {
                if (pcount!=0)
                {
                    cell.textLabel.text=[[_cityTitleArr objectAtIndex:pcount-1] objectAtIndex:indexPath.row];
                }
                
            }
                break;
            case 3:
            {
                if (pcount!=0&&ccount!=0)
                {
                    cell.textLabel.text=[[[_quTitleArr objectAtIndex:pcount-1] objectAtIndex:ccount-1] objectAtIndex:indexPath.row];
                }
                
            }
                break;
            case 4:
            {
                if (_streetTitleArrSmall.count!=0)
                {
                   cell.textLabel.text=[_streetTitleArrSmall objectAtIndex:indexPath.row];
                }
                
            }
                break;
                
            default:
                break;
        }
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (tableView.tag-300)
    {
        case 1:
        {
            _cityTableView.hidden=NO;
            pcount=(int)indexPath.row+1;
            
        }
            break;
        case 2:
        {
            [_bgScrollView scrollRectToVisible:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, CGRectGetHeight(_bgScrollView.frame)) animated:YES];
            _quTabView.hidden=NO;
            ccount=(int)indexPath.row+1;
            
        }
            break;
        case 3:
        {
            _streetTableView.hidden=NO;
            qcount=(int)indexPath.row+1;
            [self getStreet];
            
        }
            break;
        case 4:
        {
            scount=(int)indexPath.row+1;
            
            _pIDStr=[_provinceIDArr objectAtIndex:pcount-1];
            _cIDStr=[[_cityIDArr objectAtIndex:pcount-1] objectAtIndex:ccount-1];
            _qIDStr=[[[_quIDArr objectAtIndex:pcount-1] objectAtIndex:ccount-1] objectAtIndex:qcount-1];
            _sIDStr=[_streetIDArrSmall objectAtIndex:indexPath.row];
            UILabel * lab=(UILabel *)[_bigScrollView viewWithTag:102];
            lab.text=[NSString stringWithFormat:@"%@  %@  %@  %@",[_provinceTitleArr objectAtIndex:pcount-1],[[_cityTitleArr objectAtIndex:pcount-1] objectAtIndex:ccount-1],[[[_quTitleArr objectAtIndex:pcount-1] objectAtIndex:ccount-1] objectAtIndex:qcount-1],[_streetTitleArrSmall objectAtIndex:indexPath.row]];
            lab.textColor=[UIColor blackColor];
            
            [_bgView removeFromSuperview];
            
            
        }
            break;
            
        default:
            break;
    }
    [_provinceTabView reloadData];
    [_cityTableView reloadData];
    [_quTabView reloadData];
    [_streetTableView reloadData];
}
-(void)backPC
{
    [_bgScrollView scrollRectToVisible:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(_bgScrollView.frame)) animated:YES];
    _quTabView.hidden=YES;
    _streetTableView.hidden=YES;
    qcount=0;
    scount=0;
    ccount=0;
    
}
-(void)sure
{
    UILabel * lab=(UILabel *)[_bigScrollView viewWithTag:102];
    if (pcount==0)
    {
        lab.text=@"请选择区域";
        lab.textColor=[UIColor grayColor];
    }
    else if (pcount!=0&&ccount==0)
    {
        _pIDStr=[_provinceIDArr objectAtIndex:pcount-1];
        lab.text=[_provinceTitleArr objectAtIndex:pcount-1];
        lab.textColor=[UIColor blackColor];
    }
    else if (pcount!=0&&ccount!=0&&qcount==0)
    {
        _pIDStr=[_provinceIDArr objectAtIndex:pcount-1];
        _cIDStr=[[_cityIDArr objectAtIndex:pcount-1] objectAtIndex:ccount-1];
        lab.text=[NSString stringWithFormat:@"%@  %@",[_provinceTitleArr objectAtIndex:pcount-1],[[_cityTitleArr objectAtIndex:pcount-1] objectAtIndex:ccount-1]];
        lab.textColor=[UIColor blackColor];
    }
    else if (pcount!=0&&ccount!=0&&qcount!=0&&scount==0)
    {
        _pIDStr=[_provinceIDArr objectAtIndex:pcount-1];
        _cIDStr=[[_cityIDArr objectAtIndex:pcount-1] objectAtIndex:ccount-1];
        _qIDStr=[[[_quIDArr objectAtIndex:pcount-1] objectAtIndex:ccount-1] objectAtIndex:qcount-1];
        lab.text=[NSString stringWithFormat:@"%@  %@  %@",[_provinceTitleArr objectAtIndex:pcount-1],[[_cityTitleArr objectAtIndex:pcount-1] objectAtIndex:ccount-1],[[[_quTitleArr objectAtIndex:pcount-1] objectAtIndex:ccount-1] objectAtIndex:qcount-1]];
        lab.textColor=[UIColor blackColor];
    }
    else if (pcount!=0&&ccount!=0&&qcount!=0&&scount!=0)
    {
        _pIDStr=[_provinceIDArr objectAtIndex:pcount-1];
        _cIDStr=[[_cityIDArr objectAtIndex:pcount-1] objectAtIndex:ccount-1];
        _qIDStr=[[[_quIDArr objectAtIndex:pcount-1] objectAtIndex:ccount-1] objectAtIndex:qcount-1];
        _sIDStr=[_streetIDArrSmall objectAtIndex:scount-1];
        lab.text=[NSString stringWithFormat:@"%@  %@  %@  %@",[_provinceTitleArr objectAtIndex:pcount-1],[[_cityTitleArr objectAtIndex:pcount-1] objectAtIndex:ccount-1],[[[_quTitleArr objectAtIndex:pcount-1] objectAtIndex:ccount-1] objectAtIndex:qcount-1],[_streetTitleArrSmall objectAtIndex:scount-1]];
        lab.textColor=[UIColor blackColor];
    }
    
    [_bgView removeFromSuperview];
    
}
-(void)getStreet
{
    [_streetTitleArrSmall removeAllObjects];
    [_streetIDArrSmall removeAllObjects];
    scount=0;
    _sIDStr=@"";
    [_streetTableView reloadData];
    
    if ([SOAPRequest checkNet])
    {
        JTAppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
       NSString * code=[[[appdelegate.quIDArr objectAtIndex:pcount-1] objectAtIndex:ccount-1] objectAtIndex:qcount-1];
        
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:code,@"code", nil];
        
        NSDictionary * editUserDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Area_getStreets] jsonDic:jsondic]];
        
        if ([[editUserDic objectForKey:@"resultCode"] intValue]==1000)
        {
            NSArray * arr=[[NSArray alloc] initWithArray:[editUserDic objectForKey:@"areaList"]];
            for (int i=0; i<arr.count; i++)
            {
                NSString * streetIDStr=[[arr objectAtIndex:i] objectForKey:@"code"];
                NSString * streetTitleStr=[[arr objectAtIndex:i] objectForKey:@"name"];
                [_streetTitleArrSmall addObject:streetTitleStr];
                [_streetIDArrSmall addObject:streetIDStr];
            }
            [_streetTableView reloadData];
            
        }
        else
        {
            NSString * str=@"服务器异常，请稍后重试...";
            [JTAlertViewAnimation startAnimation:str view:self.view];
            
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
