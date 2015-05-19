//
//  JTQuerenDingdanViewController.m
//  GiGWi
//
//  Created by 小七 on 15-4-23.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTQuerenDingdanViewController.h"
#import "JTAdressListViewController.h"

#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#import "APAuthV2Info.h"

@interface JTQuerenDingdanViewController ()<UITextFieldDelegate>
{
    UIScrollView * _bigScrollView;
    int p;
    UITextField * _yaoqingmaTextField;
    UIButton * _yaoqingmaBtn;
    UILabel * _yaoqingmaLab;
    
    UITextField * _fapiaoTextField;
    UITextField * _liuyanTextField;
    
    float kuaidiFei;
    float youhuiFei;
    
    UIButton * _qurenBtn;
    
    UILabel * _totalLab;
}
@property(nonatomic,strong)JTSortModel * model;
@end

@implementation JTQuerenDingdanViewController
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
    if (p==1)
    {
       
    }
    p=2;
    
    [self sendPost];
    [self readyUIAgain];
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    JTAppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    appDelegate.tabBarView.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    p=1;
    kuaidiFei=0.00;
    youhuiFei=0.00;
    _model=[[JTSortModel alloc] init];

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
    navTitailLab.text=@"确认订单";
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
    
    _bigScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 20+NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-20-NAV_HEIGHT-60)];
    _bigScrollView.backgroundColor=BG_COLOR;
    _bigScrollView.contentSize=CGSizeMake(SCREEN_WIDTH, 70+90*self.listModelArr.count+40+40+20+80);
    [self.view addSubview:_bigScrollView];
    

    
    for (int i=0; i<_listModelArr.count; i++)
    {
        JTSortModel * model=[[JTSortModel alloc] init];
        model=[_listModelArr objectAtIndex:i];
        
        UIView * view=[[UIView alloc] initWithFrame:CGRectMake(0, 70+90*i, SCREEN_WIDTH, 90)];
        view.backgroundColor=[UIColor whiteColor];
        [_bigScrollView addSubview:view];
        
        UILabel * lineLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, 0.5)];
        lineLab.backgroundColor=[UIColor lightGrayColor];
        [view addSubview:lineLab];
        
        UIImageView * imgView=[[UIImageView alloc] initWithFrame:CGRectMake(10,10,60, 70)];
        [imgView setImageWithURL:[NSURL URLWithString:model.imgUrlStr] placeholderImage:[UIImage imageNamed:@"adapter_default_icon"]];
        [view addSubview:imgView];
        
        UILabel * titleLab=[[UILabel alloc] initWithFrame:CGRectMake(80,10,SCREEN_WIDTH-100-80,50)];
        titleLab.numberOfLines=0;
        titleLab.textColor=[UIColor grayColor];
        titleLab.font=[UIFont systemFontOfSize:13];
        titleLab.text=model.title;
        [view addSubview:titleLab];
        
        UILabel *yanseLab=[[UILabel alloc] initWithFrame:CGRectMake(80,60,SCREEN_WIDTH-100-80,20)];
        yanseLab.textColor=[UIColor lightGrayColor];
        yanseLab.font=[UIFont systemFontOfSize:12];
        yanseLab.text=model.propertyStr;
        yanseLab.numberOfLines=0;
        [view addSubview:yanseLab];
        
        UILabel * priceLab=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-95,15,90,25)];
        priceLab.textColor=NAV_COLOR;
        priceLab.font=[UIFont systemFontOfSize:18];
        priceLab.text=[NSString stringWithFormat:@"￥%.2f",[model.cost floatValue]];
        priceLab.textAlignment=NSTextAlignmentCenter;
        [view addSubview:priceLab];
        
        
        UILabel * countLab=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-95,40,90,20)];
        countLab.textColor=[UIColor grayColor];
        countLab.font=[UIFont systemFontOfSize:13];
        countLab.text=[NSString stringWithFormat:@"x%@",[_countArr objectAtIndex:i]];
        countLab.textAlignment=NSTextAlignmentCenter;
        [view addSubview:countLab];
        
        UILabel * shijiLab=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-95,60,90,20)];
        shijiLab.textColor=[UIColor brownColor];
        shijiLab.font=[UIFont systemFontOfSize:13];
        shijiLab.text=[NSString stringWithFormat:@"-%.2f/件",[model.cost floatValue]-[model.youhuiCost floatValue]];
        shijiLab.tag=100+i;
        shijiLab.hidden=YES;
        shijiLab.textAlignment=NSTextAlignmentCenter;
        [view addSubview:shijiLab];

    }
    
    UIButton * kuaidiBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    kuaidiBtn.frame=CGRectMake(0, 70+90*self.listModelArr.count, SCREEN_WIDTH, 40);
    kuaidiBtn.backgroundColor=[UIColor clearColor];
    //[kuaidiBtn addTarget:self action:@selector(kuaidi) forControlEvents:UIControlEventTouchUpInside];
    [_bigScrollView addSubview:kuaidiBtn];
    
    UILabel * kuaidiLab=[[UILabel alloc] initWithFrame:CGRectMake(0,0,100,40)];
    kuaidiLab.textColor=[UIColor grayColor];
    kuaidiLab.font=[UIFont systemFontOfSize:14];
    kuaidiLab.text=@"配送方式";
    kuaidiLab.textAlignment=NSTextAlignmentCenter;
    [kuaidiBtn addSubview:kuaidiLab];
    
    UILabel * kuaidiValueLab=[[UILabel alloc] initWithFrame:CGRectMake(100,10,SCREEN_WIDTH-100-30,20)];
    kuaidiValueLab.textColor=[UIColor brownColor];
    kuaidiValueLab.font=[UIFont systemFontOfSize:13];
    kuaidiValueLab.tag=50;
    kuaidiValueLab.text=[NSString stringWithFormat:@"快递：%.2f元",kuaidiFei];
    kuaidiValueLab.textAlignment=NSTextAlignmentRight;
    [kuaidiBtn addSubview:kuaidiValueLab];
    
//    UIImageView * kuaidiImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"右箭头.png"]];
//    kuaidiImgView.frame=CGRectMake(SCREEN_WIDTH-25, (40-15)/2, 10, 15);
//    [kuaidiBtn addSubview:kuaidiImgView];
    
    UILabel * kuaidiLineLab=[[UILabel alloc] initWithFrame:CGRectMake(0,39, SCREEN_WIDTH, 0.5)];
    kuaidiLineLab.backgroundColor=[UIColor lightGrayColor];
    [kuaidiBtn addSubview:kuaidiLineLab];
    
    _yaoqingmaBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_yaoqingmaBtn setImage:[UIImage imageNamed:@"选择框.png"] forState:UIControlStateNormal];
    [_yaoqingmaBtn setImage:[UIImage imageNamed:@"选中背景框.png"] forState:UIControlStateSelected];
    _yaoqingmaBtn.frame=CGRectMake(SCREEN_WIDTH-40,70+90*self.listModelArr.count+40+5, 30, 30);
    [_yaoqingmaBtn addTarget:self action:@selector(shiyong:) forControlEvents:UIControlEventTouchUpInside];
    [_bigScrollView addSubview:_yaoqingmaBtn];
    
    UILabel * yaoqingmaLab=[[UILabel alloc] initWithFrame:CGRectMake(3,70+90*self.listModelArr.count+40+10,100,20)];
    yaoqingmaLab.textColor=[UIColor grayColor];
    yaoqingmaLab.font=[UIFont systemFontOfSize:14];
    yaoqingmaLab.text=@"使用邀请码";
    yaoqingmaLab.textAlignment=NSTextAlignmentLeft;
    [_bigScrollView addSubview:yaoqingmaLab];
    
    UIImageView * inputImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"input_content_bg.png"]];
    inputImgView.frame=CGRectMake(80, 70+90*self.listModelArr.count+40+5, SCREEN_WIDTH-100-80, 30);
    [_bigScrollView addSubview:inputImgView];
    
    _yaoqingmaTextField=[[UITextField alloc] initWithFrame:CGRectMake(82, 70+90*self.listModelArr.count+40+10, SCREEN_WIDTH-100-84, 20)];
    _yaoqingmaTextField.delegate=self;
    [_bigScrollView addSubview:_yaoqingmaTextField];
    
    _yaoqingmaLab=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, 70+90*self.listModelArr.count+40+10, 50, 20)];
    _yaoqingmaLab.textColor=NAV_COLOR;
    _yaoqingmaLab.text=[NSString stringWithFormat:@"-%.2f",youhuiFei];
    _yaoqingmaLab.textAlignment=NSTextAlignmentCenter;
    _yaoqingmaLab.font=[UIFont systemFontOfSize:15];
    _yaoqingmaLab.hidden=YES;
    [_bigScrollView addSubview:_yaoqingmaLab];
    
    UILabel * fapiaoLab=[[UILabel alloc] initWithFrame:CGRectMake(3,70+90*self.listModelArr.count+40+10+40,100,20)];
    fapiaoLab.textColor=[UIColor brownColor];
    fapiaoLab.font=[UIFont systemFontOfSize:14];
    fapiaoLab.text=@"发票抬头:";
    fapiaoLab.textAlignment=NSTextAlignmentLeft;
    [_bigScrollView addSubview:fapiaoLab];
    
    UIImageView * inputImgView2=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"input_box_org.png"]];
    inputImgView2.frame=CGRectMake(80, 70+90*self.listModelArr.count+40+5+40, SCREEN_WIDTH-90, 30);
    [_bigScrollView addSubview:inputImgView2];
    
    _fapiaoTextField=[[UITextField alloc] initWithFrame:CGRectMake(82, 70+90*self.listModelArr.count+40+10+40, SCREEN_WIDTH-94, 20)];
    _fapiaoTextField.delegate=self;
    [_bigScrollView addSubview:_fapiaoTextField];
    
    UILabel * liuyanLab=[[UILabel alloc] initWithFrame:CGRectMake(3,70+90*self.listModelArr.count+40+10+40+40,100,20)];
    liuyanLab.textColor=[UIColor grayColor];
    liuyanLab.font=[UIFont systemFontOfSize:14];
    liuyanLab.text=@"买家留言:";
    liuyanLab.textAlignment=NSTextAlignmentLeft;
    [_bigScrollView addSubview:liuyanLab];
    
    UIImageView * inputImgView3=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"input_box_org.png"]];
    inputImgView3.frame=CGRectMake(80, 70+90*self.listModelArr.count+40+5+40+40, SCREEN_WIDTH-90, 30);
    [_bigScrollView addSubview:inputImgView3];
    
    _liuyanTextField=[[UITextField alloc] initWithFrame:CGRectMake(82, 70+90*self.listModelArr.count+40+10+40+40, SCREEN_WIDTH-94, 20)];
    _liuyanTextField.delegate=self;
    [_bigScrollView addSubview:_liuyanTextField];
    
    
   UIView * bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width, 60)];
    bottomView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bottomView];

    
    UILabel * hejicountLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 60)];
    hejicountLab.font=[UIFont systemFontOfSize:14];
    int count=0;
    for (int i=0; i<_countArr.count; i++)
    {
        count+= [[_countArr objectAtIndex:i] intValue];
    }
    hejicountLab.text=[NSString stringWithFormat:@"共%d件商品",count];
    hejicountLab.textAlignment=NSTextAlignmentCenter;
    hejicountLab.textColor=[UIColor grayColor];
    [bottomView addSubview:hejicountLab];
    
    _totalLab=[[UILabel alloc] initWithFrame:CGRectMake(90, 20, SCREEN_WIDTH-95-90, 20)];
    _totalLab.font=[UIFont systemFontOfSize:18];
    _totalLab.textColor=NAV_COLOR;
    _totalLab.textAlignment=NSTextAlignmentRight;
    _totalLab.text=[NSString stringWithFormat:@"合计:￥%.2f",_totalPrice+kuaidiFei];
    [bottomView addSubview:_totalLab];
    
    
    _qurenBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _qurenBtn.frame=CGRectMake(SCREEN_WIDTH-90, 10, 80, 40);
    _qurenBtn.backgroundColor=NAV_COLOR;
    [_qurenBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_qurenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _qurenBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [_qurenBtn addTarget:self action:@selector(queren) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_qurenBtn];


    
}
-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)readyUIAgain
{
    UIButton * adressBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    adressBtn.frame=CGRectMake(0, 0, SCREEN_WIDTH, 70);
    adressBtn.backgroundColor=[UIColor whiteColor];
    [adressBtn addTarget:self action:@selector(adress) forControlEvents:UIControlEventTouchUpInside];
    [_bigScrollView addSubview:adressBtn];
    
    UIImageView * imgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"地址图标.png"]];
    imgView.frame=CGRectMake(15, 20,30, 30);
    [adressBtn addSubview:imgView];
    
    if([self.adressModel.name isEqualToString:@""]||self.adressModel.name==nil)
    {
        if ([_model.name isEqualToString:@""]||_model.name==nil)
        {
            UILabel * tishiLab=[[UILabel alloc] initWithFrame:CGRectMake(50, 0,  SCREEN_WIDTH-30-50,70)];
            tishiLab.font=[UIFont systemFontOfSize:22];
            tishiLab.textColor=[UIColor brownColor];
            tishiLab.textAlignment=NSTextAlignmentCenter;
            tishiLab.text=@"请选择收货地址";
            [adressBtn addSubview:tishiLab];
        }
        else
        {
            self.adressModel=[[JTSortModel alloc] init];
            self.adressModel=_model;
            
            UILabel * nameLab=[[UILabel alloc] initWithFrame:CGRectMake(50, 10, SCREEN_WIDTH-30-100-50, 20)];
            nameLab.font=[UIFont systemFontOfSize:15];
            nameLab.textColor=[UIColor blackColor];
            nameLab.text=[NSString stringWithFormat:@"收货人:%@",_model.name];
            [adressBtn addSubview:nameLab];
            
            UILabel * telLab=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30-100, 10, 100, 20)];
            telLab.font=[UIFont systemFontOfSize:13];
            telLab.textColor=[UIColor grayColor];
            telLab.text=[NSString stringWithFormat:@"%@",_model.tel];
            [adressBtn addSubview:telLab];
            
            UILabel * adressLab=[[UILabel alloc] initWithFrame:CGRectMake(50, 30, SCREEN_WIDTH-30-50, 30)];
            adressLab.font=[UIFont systemFontOfSize:12];
            adressLab.textColor=[UIColor lightGrayColor];
            adressLab.numberOfLines=0;
            if ([_model.provinceStr isEqualToString:@""]||_model.provinceStr==nil)
            {
                _model.provinceStr=@"";
            }
            if ([_model.cityStr isEqualToString:@""]||_model.cityStr==nil)
            {
                _model.cityStr=@"";
            }
            if ([_model.quStr isEqualToString:@""]||_model.quStr==nil)
            {
                _model.quStr=@"";
            }
            if ([_model.street isEqualToString:@""]||_model.street==nil)
            {
                _model.street=@"";
            }
            if ([_model.infoAddress isEqualToString:@""]||_model.infoAddress==nil)
            {
                _model.infoAddress=@"";
            }
            adressLab.text=[NSString stringWithFormat:@"收货地址:%@%@%@%@%@",_model.provinceStr,_model.cityStr,_model.quStr,_model.street,_model.infoAddress];
            [adressBtn addSubview:adressLab];
           
        }

    }
    else
    {
        UILabel * nameLab=[[UILabel alloc] initWithFrame:CGRectMake(50, 10, SCREEN_WIDTH-30-100-50, 20)];
        nameLab.font=[UIFont systemFontOfSize:15];
        nameLab.textColor=[UIColor blackColor];
        nameLab.text=[NSString stringWithFormat:@"收货人:%@",self.adressModel.name];
        [adressBtn addSubview:nameLab];
        
        UILabel * telLab=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30-100, 10, 100, 20)];
        telLab.font=[UIFont systemFontOfSize:13];
        telLab.textColor=[UIColor grayColor];
        telLab.text=[NSString stringWithFormat:@"%@",self.adressModel.tel];
        [adressBtn addSubview:telLab];
        
        UILabel * adressLab=[[UILabel alloc] initWithFrame:CGRectMake(50, 30, SCREEN_WIDTH-30-50, 30)];
        adressLab.font=[UIFont systemFontOfSize:12];
        adressLab.textColor=[UIColor lightGrayColor];
        adressLab.numberOfLines=0;
        if ([self.adressModel.provinceStr isEqualToString:@""]||self.adressModel.provinceStr==nil)
        {
            self.adressModel.provinceStr=@"";
        }
        if ([self.adressModel.cityStr isEqualToString:@""]||self.adressModel.cityStr==nil)
        {
            self.adressModel.cityStr=@"";
        }
        if ([self.adressModel.quStr isEqualToString:@""]||self.adressModel.quStr==nil)
        {
            self.adressModel.quStr=@"";
        }
        if ([self.adressModel.street isEqualToString:@""]||self.adressModel.street==nil)
        {
            self.adressModel.street=@"";
        }
        if ([self.adressModel.infoAddress isEqualToString:@""]||self.adressModel.infoAddress==nil)
        {
            self.adressModel.infoAddress=@"";
        }
        adressLab.text=[NSString stringWithFormat:@"收货地址:%@%@%@%@%@",self.adressModel.provinceStr,self.adressModel.cityStr,self.adressModel.quStr,self.adressModel.street,self.adressModel.infoAddress];
        [adressBtn addSubview:adressLab];


    }
    UIImageView *jiantouImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"右箭头.png"]];
    jiantouImgView.frame=CGRectMake(SCREEN_WIDTH-25, (70-15)/2, 10, 15);
    [adressBtn addSubview:jiantouImgView];
}
-(void)adress
{
   [self.view endEditing:YES];
    JTAdressListViewController * adressVC=[[JTAdressListViewController alloc] init];
    adressVC.querenVC=self;
    [self.navigationController pushViewController:adressVC animated:YES];
}
//-(void)kuaidi
//{
//    [self.view endEditing:YES];
//    kuaidiFei=8.00;
//    UILabel *kuaidiValueLab=(UILabel *)[_bigScrollView viewWithTag:50];
//    kuaidiValueLab.text=[NSString stringWithFormat:@"快递：%.2f元",kuaidiFei];
//    _totalLab.text=[NSString stringWithFormat:@"合计:￥%.2f",_totalPrice+kuaidiFei-youhuiFei];
//}
-(void)shiyong:(UIButton *)sender
{
     [self.view endEditing:YES];
    if ([_yaoqingmaTextField.text isEqualToString:@""])
    {
        NSString * str=@"请输入有效的邀请码...";
        [JTAlertViewAnimation startAnimation:str view:self.view];
        return;
    }
    
    if (sender.selected==YES)
    {
        sender.selected=NO;
        _yaoqingmaLab.hidden=YES;
        youhuiFei=0.00;
        for (int i=0; i<_listModelArr.count; i++)
        {
            UILabel * shijiLab=(UILabel *)[_bigScrollView viewWithTag:100+i];
            shijiLab.hidden=YES;
        }
        _totalLab.text=[NSString stringWithFormat:@"合计:￥%.2f",_totalPrice-youhuiFei+kuaidiFei];
    }
    else
    {
        if ([SOAPRequest checkNet])
        {
            NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:_yaoqingmaTextField.text,@"invitationCode", nil];
            
            NSDictionary * editUserDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Invitation_CheckCode] jsonDic:jsondic]];
            
            if ([[editUserDic objectForKey:@"resultCode"] intValue]==1000)
            {
                sender.selected=YES;
                _yaoqingmaLab.hidden=NO;
                for (int i=0; i<_listModelArr.count; i++)
                {
                    JTSortModel * model=[[JTSortModel alloc] init];
                    model=[_listModelArr objectAtIndex:i];
                    youhuiFei+=([model.cost floatValue]-[model.youhuiCost floatValue])*[[_countArr objectAtIndex:i] floatValue];
                    
                    UILabel * shijiLab=(UILabel *)[_bigScrollView viewWithTag:100+i];
                    shijiLab.hidden=NO;
                }
                _yaoqingmaLab.text=[NSString stringWithFormat:@"-%.2f",youhuiFei];
                _totalLab.text=[NSString stringWithFormat:@"合计:￥%.2f",_totalPrice-youhuiFei+kuaidiFei];
                
            }
            else
            {
                NSString * str=@"邀请码认证失败";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
        }
    }

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _bigScrollView.contentSize=CGSizeMake(SCREEN_WIDTH, 70+90*self.listModelArr.count+40+40+20+80+253);
    [_bigScrollView scrollRectToVisible:CGRectMake(0, 70+90*self.listModelArr.count, SCREEN_WIDTH, SCREEN_HEIGHT-20-NAV_HEIGHT-60) animated:NO];
    
    if (textField==_yaoqingmaTextField)
    {
        _yaoqingmaBtn.selected=NO;
        _yaoqingmaLab.hidden=YES;
        youhuiFei=0.00;
        for (int i=0; i<_listModelArr.count; i++)
        {
            UILabel * shijiLab=(UILabel *)[_bigScrollView viewWithTag:100+i];
            shijiLab.hidden=YES;
        }
        _totalLab.text=[NSString stringWithFormat:@"合计:￥%.2f",_totalPrice-youhuiFei+kuaidiFei];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _bigScrollView.contentSize=CGSizeMake(SCREEN_WIDTH, 70+90*self.listModelArr.count+40+40+20+80);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [self.view endEditing:YES];
 _bigScrollView.contentSize=CGSizeMake(SCREEN_WIDTH, 70+90*self.listModelArr.count+40+40+20+80);
    return YES;
}
-(void)queren
{
    NSLog(@"确认订单");
    [self.view endEditing:YES];
    if([self.adressModel.name isEqualToString:@""]||self.adressModel.name==nil)
    {
        NSString * str=@"请选择收货人信息";
        [JTAlertViewAnimation startAnimation:str view:self.view];
        return;
    }
    if ([SOAPRequest checkNet])
    {
        JTAppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
        
        NSMutableArray * listArr=[[NSMutableArray alloc] initWithCapacity:0];
        for (int i=0; i<_listModelArr.count; i++)
        {
            JTSortModel * model=[[JTSortModel alloc] init];
            model=[_listModelArr objectAtIndex:i];
            NSDictionary * dic=[[NSDictionary alloc] initWithObjectsAndKeys: model.goodsId,@"goodsId",model.title,@"goodsName",model.cost,@"unitPrice",model.youhuiCost,@"straightPrice",[_countArr objectAtIndex:i],@"count",model.propertyStr,@"property",model.imgUrlStr,@"imgUrl",model.idStr,@"cartId", nil];
            [listArr addObject:dic];
        }
        
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",appdelegate.appUser.userID],@"userId",self.adressModel.name, @"name",[NSString stringWithFormat:@"%@%@%@%@%@",self.adressModel.provinceStr,self.adressModel.cityStr,self.adressModel.quStr,self.adressModel.street,self.adressModel.infoAddress], @"address",self.adressModel.tel, @"phone",_liuyanTextField.text, @"buyerMessage",_fapiaoTextField.text, @"invoiceTitle",listArr, @"orderGoods",[NSString stringWithFormat:@"%f",_totalPrice-youhuiFei+kuaidiFei],@"totalPrice",nil];
        
        NSDictionary * editUserDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Order_New] jsonDic:jsondic]];
        
        if ([[editUserDic objectForKey:@"resultCode"] intValue]==1000)
        {
            NSString * str=@"订单提交成功";
            [JTAlertViewAnimation startAnimation:str view:self.view];
            if (self.gouWuCheVC!=nil)
            {
                self.gouWuCheVC.p=1;
            }
            NSString * orderIdStr=[NSString stringWithFormat:@"%@",[[editUserDic objectForKey:@"order"] objectForKey:@"id"]];
            //[self pay:orderIdStr];
            
            [self pay];
            
        }
        else
        {
            NSString * str=@"服务器异常，请稍后重试...";
            [JTAlertViewAnimation startAnimation:str view:self.view];
        }
    }

}
-(void)sendPost
{
    
    JTAppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
    _model.name=appdelegate.appUser.adressName;
    _model.tel=appdelegate.appUser.adressTel;
    _model.provinceStr=appdelegate.appUser.provinceValue;
    _model.cityStr=appdelegate.appUser.cityValue;
    _model.quStr=appdelegate.appUser.regionName;
    _model.street=appdelegate.appUser.streetName;
    _model.infoAddress=appdelegate.appUser.address;
    _model.provinceIDStr=appdelegate.appUser.provinceID;
    _model.cityIDStr=appdelegate.appUser.cityID;
    _model.quIDStr=appdelegate.appUser.regionId;
    _model.streetIDStr=appdelegate.appUser.streetId;
    
}
-(void)pay:(NSString *)orderIdStr
{
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088911545170074";
    NSString *seller = @"xintianwanju@163.com";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALmU2YkBfP+DDAdqkdfd+qsWMfiE9eZ0ZGhx4QfwTqVlrWs4sz3HxauWUbyZsGCjnxFPgLZAzrtLHR7ZQtDcjyjoxsL9cq7eqNtVOBmQ8Psz3gFA5IKykbUmpMMTCgaUWI3UP104ldn5buZl1rBqFrOJwagS4cCDSv66gDVrhn6lAgMBAAECgYEAjgy1hf0xpJK2fmbAQ6+R06sljMiZQFEPGjMwwFbcnBV77Hp2GG/1iiWBYw9wxkf31dQ4/UgV9Z7FJ3u9fQmWObYS+IdoiXqYY7k4xfJ+fmd+/J6y84aIbdF1vrjKfzp6fgRPT2JTRoNOz6JibVe7VxEUicVQj+pvRWXX0gmzcIECQQD1Pubpg3PzbCAx0h/sNEUwXXjFF2cH21fRxTkyizCPBRWHRVgVX58pSqEOlqUHzsVgaJgl0uJxvqhlP9dpAG65AkEAwbgqALMw3BTKj/PPKu4llMuHswVLOL8etw/qpGnkYvjqRdiA34Iz67FKIbywGy3Jjww2hILOqWzm6bWUXK45TQJASJAfBJK3eRvR/su8VEg2/JN7i11cR8/XkSK4xMK4UGjhsM+Mu246ip4hP07Fb6T3c4ofEnnuNFeEPckA9HmDSQJBALWS3SvSyZU/l63eJOxkU61oKEVQTPVfjnaf4JtC9eMe1Neq2wCkle3xOz7sEVUoUahXFjKWOQbtIHMm020bkHECQCSKoBVjFysK9arKXioE0TSrSZFg54S28RawJ1aXnumhbooLUQXi3n316GNy+BeLxAuLsVSJGR3/F8VDuayR/A8=";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = orderIdStr; //订单ID（由商家自行制定）
    order.productName = @"商品标题1"; //商品标题
    order.productDescription =@"商品描述1"; //商品描述
    //order.amount = [NSString stringWithFormat:@"%.2f",_totalPrice-youhuiFei+kuaidiFei]; //商品价格
    order.amount = @"0.01";
    order.notifyURL =  @"http://www.gigwi.cn/AliNotify"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"GiGWi";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        NSArray* views = [[UIApplication sharedApplication] windows];
        UIWindow* windowtemp = views[0];
        if (windowtemp.hidden) {
            windowtemp.hidden = NO;
        }
        else
        {
            NSLog(@"no hidden");
        }
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            
            windowtemp.hidden=YES;
            if ([[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus" ]] isEqualToString:@"9000"])
            {
                NSLog(@"通知服务器付款已成功！");
                
                JTAppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
                NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",appdelegate.appUser.userID],@"userId",orderIdStr, @"id",nil];
                
                NSDictionary * editUserDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Order_Paid] jsonDic:jsondic]];
                
                if ([[editUserDic objectForKey:@"resultCode"] intValue]==1000)
                {
                    
                }
                else
                {
                    double delayInSeconds = 30.0;
                    __block JTQuerenDingdanViewController* bself = self;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [bself sendFuwuqi:orderIdStr]; });
                }

            }
        }];
        
    }


}

-(void)sendFuwuqi:(NSString *)orderIdStr
{
    JTAppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
    NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",appdelegate.appUser.userID],@"userId",orderIdStr, @"id",nil];
    
    [SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Order_Paid] jsonDic:jsondic];
}
#pragma mark -
#pragma mark   ==============产生随机订单号==============


- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}
-(void)pay
{
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088911545170074";
    NSString *seller = @"xintianwanju@163.com";
    NSString *privateKey = @" MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALmU2YkBfP+DDAdqkdfd+qsWMfiE9eZ0ZGhx4QfwTqVlrWs4sz3HxauWUbyZsGCjnxFPgLZAzrtLHR7ZQtDcjyjoxsL9cq7eqNtVOBmQ8Psz3gFA5IKykbUmpMMTCgaUWI3UP104ldn5buZl1rBqFrOJwagS4cCDSv66gDVrhn6lAgMBAAECgYEAjgy1hf0xpJK2fmbAQ6+R06sljMiZQFEPGjMwwFbcnBV77Hp2GG/1iiWBYw9wxkf31dQ4/UgV9Z7FJ3u9fQmWObYS+IdoiXqYY7k4xfJ+fmd+/J6y84aIbdF1vrjKfzp6fgRPT2JTRoNOz6JibVe7VxEUicVQj+pvRWXX0gmzcIECQQD1Pubpg3PzbCAx0h/sNEUwXXjFF2cH21fRxTkyizCPBRWHRVgVX58pSqEOlqUHzsVgaJgl0uJxvqhlP9dpAG65AkEAwbgqALMw3BTKj/PPKu4llMuHswVLOL8etw/qpGnkYvjqRdiA34Iz67FKIbywGy3Jjww2hILOqWzm6bWUXK45TQJASJAfBJK3eRvR/su8VEg2/JN7i11cR8/XkSK4xMK4UGjhsM+Mu246ip4hP07Fb6T3c4ofEnnuNFeEPckA9HmDSQJBALWS3SvSyZU/l63eJOxkU61oKEVQTPVfjnaf4JtC9eMe1Neq2wCkle3xOz7sEVUoUahXFjKWOQbtIHMm020bkHECQCSKoBVjFysK9arKXioE0TSrSZFg54S28RawJ1aXnumhbooLUQXi3n316GNy+BeLxAuLsVSJGR3/F8VDuayR/A8= ";


    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = @"商品标题1"; //商品标题
    order.productDescription =@"商品描述1"; //商品描述
    //order.amount = [NSString stringWithFormat:@"%.2f",_totalPrice-youhuiFei+kuaidiFei]; //商品价格
    order.amount = @"0.01";
    order.notifyURL =  @"http://www.qin16.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"GiGWi";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        NSArray* views = [[UIApplication sharedApplication] windows];
        UIWindow* windowtemp = views[0];
        if (windowtemp.hidden) {
            windowtemp.hidden = NO;
        }
        else
        {
            NSLog(@"no hidden");
        }
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            windowtemp.hidden=YES;
        
        }];

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
