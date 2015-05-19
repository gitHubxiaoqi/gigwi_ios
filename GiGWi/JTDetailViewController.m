//
//  JTDetailViewController.m
//  GiGWi
//
//  Created by 小七 on 15-4-22.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTDetailViewController.h"
#import "JTQuerenDingdanViewController.h"

@interface JTDetailViewController ()<UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
      UIScrollView * _bigScrollView;
      UIWebView * _webView;
      int p;
    UILabel * _countLab;
    UIView * _tanchuView;
    
    UITableView * _tableView;
    NSMutableArray * _titleIDArr;
    NSMutableArray * _titleArr;
    NSMutableArray * _nameIDArr;
    NSMutableArray * _nameArr;
    
    UILabel * _chooseLab;
    
    NSMutableArray * _jiluArr;
    NSMutableString * _jiluStr;
}
@property(nonatomic ,strong)JTSortModel * model;
@end

@implementation JTDetailViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    JTAppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    appDelegate.tabBarView.hidden=NO;
}
-(void)viewDidAppear:(BOOL)animated
{
    JTAppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    appDelegate.tabBarView.hidden=YES;

    if (p==1)
    {
        [self sendPost];
        _webView=[[UIWebView alloc] initWithFrame:CGRectMake(10, 30, self.view.frame.size.width-20, 30)];
        _webView.tag=1111;
        [_webView setScalesPageToFit:NO];
        _webView.scrollView.scrollEnabled=NO;
        _webView.backgroundColor=[UIColor whiteColor];
        [_webView loadHTMLString:_model.description1 baseURL:nil];
        _webView.delegate=self;
       
        [self readyUIAgain];
    }
    p=2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    p=1;
    _model=[[JTSortModel alloc] init];
    _titleIDArr=[[NSMutableArray alloc] initWithCapacity:0];
    _titleArr=[[NSMutableArray alloc] initWithCapacity:0];
    _nameIDArr=[[NSMutableArray alloc] initWithCapacity:0];
    _nameArr=[[NSMutableArray alloc] initWithCapacity:0];
    _jiluArr=[[NSMutableArray alloc] initWithCapacity:0];
    _jiluStr=[[NSMutableString alloc] init];
    [_jiluStr setString:@""];
    [self readyUI];
}
-(void)readyUI
{
    self.view.backgroundColor=BG_COLOR;
    self.navigationController.navigationBar.hidden=YES;
 
    _bigScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50)];
    _bigScrollView.backgroundColor=BG_COLOR;
    [self.view addSubview:_bigScrollView];
    
    UIButton * leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame=CGRectMake(20,20, 40,40);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"商品详情-返回键.png"] forState:UIControlStateNormal];
    leftBtn.tag=10;
    [leftBtn addTarget:self action:@selector(leftBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    
    UIView * bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50)];
    [self.view addSubview:bottomView];
    
    UIButton * linkBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    [linkBtn1 setBackgroundImage:[UIImage imageNamed:@"加入购物车-2.png"] forState:UIControlStateNormal];
    [linkBtn1 addTarget:self action:@selector(jiaru) forControlEvents:UIControlEventTouchUpInside];
    linkBtn1.frame=CGRectMake(0, 0, SCREEN_WIDTH/2.0, 50);
    [bottomView addSubview:linkBtn1];
    
    UIButton * linkBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
    [linkBtn2 setBackgroundImage:[UIImage imageNamed:@"立即购买.png"] forState:UIControlStateNormal];
    [linkBtn2 addTarget:self action:@selector(goumai) forControlEvents:UIControlEventTouchUpInside];
    linkBtn2.frame=CGRectMake(SCREEN_WIDTH/2.0, 0, SCREEN_WIDTH/2.0, 50);
    [bottomView addSubview:linkBtn2];
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //拦截网页图片  并修改图片大小
    [webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth=300;" //缩放系数
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "myimg.height = myimg.height * (maxwidth/oldwidth)*1.5;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    
    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    int height = [height_str intValue];
    
    CGRect frame = webView.frame;
    frame.size.height= height+5;
    webView.frame = frame;
    webView.tag=9999;
}
-(void)readyUIAgain
{
    
    UIImageView * imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3.0)];
    [imageView setImageWithURL:[NSURL URLWithString:_model.imgUrlStr] placeholderImage:[UIImage imageNamed:@"adapter_default_icon.png"]];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    [_bigScrollView addSubview:imageView];
    
    UIView * view1=[[UIView alloc] initWithFrame:CGRectMake(0, imageView.frame.size.height, self.view.frame.size.width, 120)];
    view1.backgroundColor=[UIColor clearColor];
    [_bigScrollView addSubview:view1];
    
    UILabel * titleLab=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.view.frame.size.width-20, 20)];
    titleLab.text=self.model.title;
    titleLab.font=[UIFont systemFontOfSize:16];
    titleLab.textColor=[UIColor blackColor];
    titleLab.numberOfLines=0;
    CGSize titleAutoSize=[self.model.title boundingRectWithSize:CGSizeMake(self.view.frame.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleLab.font} context:nil].size;
    if (titleAutoSize.height<20)
    {
        titleAutoSize.height=20;
    }
    
    titleLab.frame=CGRectMake(10, 5, self.view.frame.size.width-20, titleAutoSize.height);
    [view1 addSubview:titleLab];
    
    UILabel * linelab1=[[UILabel alloc] initWithFrame:CGRectMake(0, titleAutoSize.height+5, SCREEN_WIDTH, 0.5)];
    linelab1.backgroundColor=[UIColor lightGrayColor];
    [view1 addSubview:linelab1];
    
    UILabel * priceLab=[[UILabel alloc] initWithFrame:CGRectMake(10, titleAutoSize.height+10, SCREEN_WIDTH-20, 40)];
    NSString * priceStr=@"";
    if (_model.cost==nil||[[NSString stringWithFormat:@"%@",_model.cost] isEqualToString:@""]||[_model.cost intValue]==0)
    {
        priceStr=@"暂无标价";
        priceLab.textColor=[UIColor orangeColor];
        priceLab.font=[UIFont systemFontOfSize:18];
    }
    else
    {
        priceStr=[NSString stringWithFormat:@"￥%@",_model.cost];
        priceLab.textColor=NAV_COLOR;
        priceLab.font=[UIFont systemFontOfSize:24];
    }
    priceLab.text=priceStr;
    [view1 addSubview:priceLab];
    
    UILabel * youjiLab=[[UILabel alloc] initWithFrame:CGRectMake(10, titleAutoSize.height+10+priceLab.frame.size.height, (SCREEN_WIDTH-20)/3.0, 20)];
    youjiLab.text=@"卖家包邮";
    youjiLab.font=[UIFont systemFontOfSize:14];
    youjiLab.textAlignment=NSTextAlignmentLeft;
    youjiLab.textColor=[UIColor grayColor];
    [view1 addSubview:youjiLab];
    
    UILabel * xiaoliangLab=[[UILabel alloc] initWithFrame:CGRectMake(10+ (SCREEN_WIDTH-20)/3.0, titleAutoSize.height+10+priceLab.frame.size.height, (SCREEN_WIDTH-20)/3.0, 20)];
    NSString * countStr=@"";
    if (_model.xiaoliangNum==nil||[[NSString stringWithFormat:@"%@",_model.xiaoliangNum] isEqualToString:@""]||[_model.xiaoliangNum intValue]==0)
    {
        countStr=@"暂无销量";
    }
    else
    {
        countStr=[NSString stringWithFormat:@"销量%@笔",_model.xiaoliangNum];
    }
    xiaoliangLab.text=countStr;
    xiaoliangLab.font=[UIFont systemFontOfSize:14];
    xiaoliangLab.textAlignment=NSTextAlignmentCenter;
    xiaoliangLab.textColor=[UIColor grayColor];
    [view1 addSubview:xiaoliangLab];
    
    UILabel * dizhiLab=[[UILabel alloc] initWithFrame:CGRectMake(10+ (SCREEN_WIDTH-20)/3.0*2, titleAutoSize.height+10+priceLab.frame.size.height, (SCREEN_WIDTH-20)/3.0, 20)];
    dizhiLab.text=[NSString stringWithFormat:@"%@%@",_model.provinceStr,_model.cityStr];
    dizhiLab.font=[UIFont systemFontOfSize:14];
    dizhiLab.textAlignment=NSTextAlignmentRight;
    dizhiLab.textColor=[UIColor grayColor];
    [view1 addSubview:dizhiLab];

    UILabel * linelab2=[[UILabel alloc] initWithFrame:CGRectMake(0, titleAutoSize.height+10+priceLab.frame.size.height+20+5, SCREEN_WIDTH, 0.5)];
    linelab2.backgroundColor=[UIColor lightGrayColor];
    [view1 addSubview:linelab2];
    
    view1.frame=CGRectMake(0, imageView.frame.size.height, SCREEN_WIDTH, titleAutoSize.height+10+priceLab.frame.size.height+20+10);
    
    UIView * view2=[[UIView alloc] initWithFrame:CGRectMake(0, imageView.frame.size.height+view1.frame.size.height, self.view.frame.size.width, 50)];
    view2.backgroundColor=[UIColor clearColor];
    [_bigScrollView addSubview:view2];
    
    UIButton * chooseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    chooseBtn.backgroundColor=[UIColor whiteColor];
    chooseBtn.frame=CGRectMake(0, 0, SCREEN_WIDTH, 40);
    [chooseBtn addTarget:self action:@selector(choose) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:chooseBtn];
    
    _chooseLab=[[UILabel alloc] initWithFrame:CGRectMake(10, 0,SCREEN_WIDTH-55, CGRectGetHeight(chooseBtn.frame))];
    _chooseLab.textColor=[UIColor blackColor];
    _chooseLab.font=[UIFont systemFontOfSize:16];
    _chooseLab.text=@"请选择分类";
    [chooseBtn addSubview:_chooseLab];
    
    UIImageView * chooseImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"右箭头.png"]];
    chooseImgView.frame=CGRectMake(SCREEN_WIDTH-25, 14, 10, 12);
    [chooseBtn addSubview:chooseImgView];
    

    UIView * view3=[[UIView alloc] initWithFrame:CGRectMake(0, imageView.frame.size.height+view1.frame.size.height+view2.frame.size.height, self.view.frame.size.width, 50)];
    view3.backgroundColor=[UIColor whiteColor];
    [_bigScrollView addSubview:view3];
    
    UILabel * descriptionLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0,80, 29)];
    descriptionLab.text=@"商品详情";
    descriptionLab.textColor=[UIColor brownColor];
    descriptionLab.textAlignment=NSTextAlignmentCenter;
    descriptionLab.font=[UIFont systemFontOfSize:16];
    [view3 addSubview:descriptionLab];
    
    UILabel * lineLab3=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(descriptionLab.frame), SCREEN_WIDTH, 1)];
    lineLab3.backgroundColor=BG_COLOR;
    [view3 addSubview:lineLab3];
    
    while (_webView.tag!=9999)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    [view3 addSubview:_webView];
    
    view3.frame=CGRectMake(0, imageView.frame.size.height+view1.frame.size.height+view2.frame.size.height,SCREEN_WIDTH, 30+_webView.frame.size.height+5);

    _bigScrollView.contentSize=CGSizeMake(SCREEN_WIDTH, imageView.frame.size.height+view1.frame.size.height+view2.frame.size.height+30+_webView.frame.size.height+5+10);
    
    UIButton * leftBtn=(UIButton *)[_bigScrollView viewWithTag:10];
    [_bigScrollView bringSubviewToFront:leftBtn];

    //弹出View
    _tanchuView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _tanchuView.backgroundColor=[UIColor clearColor];
    _tanchuView.hidden=YES;
    [self.view addSubview:_tanchuView];
    
    UIView * shaowView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
    shaowView.backgroundColor=[UIColor blackColor];
    shaowView.alpha=0.5;
    [_tanchuView addSubview:shaowView];
    
    CGFloat hight=0;
    if (_titleArr.count<=3)
    {
        hight=60*_titleArr.count;
    }
    else
    {
        hight=60*3;
    }
    
    UIView * chooseView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-170-hight, SCREEN_WIDTH, 170+hight)];
    chooseView.backgroundColor=[UIColor whiteColor];
    [_tanchuView addSubview:chooseView];
    
    UIImageView * tanchuImgView=[[UIImageView alloc] initWithFrame:CGRectMake(15, -20, 75, 85)];
    [tanchuImgView setImageWithURL:[NSURL URLWithString:_model.imgUrlStr] placeholderImage:[UIImage imageNamed:@"adapter_default_icon.png"]];
    [chooseView addSubview:tanchuImgView];
    
    UILabel * costLab=[[UILabel alloc] initWithFrame:CGRectMake(110, 0, SCREEN_WIDTH-110-60, 25)];
    costLab.text=priceStr;
    costLab.font=[UIFont systemFontOfSize:18];
    costLab.textColor=NAV_COLOR;
    [chooseView addSubview:costLab];
    
    UILabel * kucunLab=[[UILabel alloc] initWithFrame:CGRectMake(110, 25, SCREEN_WIDTH-110-60, 20)];
    kucunLab.text=[NSString stringWithFormat:@"库存%@件",_model.kucunNum];
    kucunLab.font=[UIFont systemFontOfSize:13];
    kucunLab.textColor=[UIColor grayColor];
    [chooseView addSubview:kucunLab];

    UILabel * yanceLab=[[UILabel alloc] initWithFrame:CGRectMake(110, 45,  SCREEN_WIDTH-110-60, 20)];
    yanceLab.text=@"请选择分类";
    yanceLab.font=[UIFont systemFontOfSize:13];
    yanceLab.textColor=[UIColor grayColor];
    [chooseView addSubview:yanceLab];
    
    UIButton * exitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    exitBtn.frame=CGRectMake(SCREEN_WIDTH-50, 5, 30, 30);
    [exitBtn setBackgroundImage:[UIImage imageNamed:@"叉.png"] forState:UIControlStateNormal];
    [exitBtn addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    [chooseView addSubview:exitBtn];
    
    UILabel * tanchuLineLab1=[[UILabel alloc] initWithFrame:CGRectMake(15, 70, SCREEN_WIDTH-25, 0.5)];
    tanchuLineLab1.backgroundColor=[UIColor lightGrayColor];
    [chooseView addSubview:tanchuLineLab1];
    
 
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 71, SCREEN_WIDTH, hight) style:UITableViewStylePlain];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [chooseView addSubview:_tableView];
    
    
    UILabel * tanchuLineLab2=[[UILabel alloc] initWithFrame:CGRectMake(15,71+hight+1, SCREEN_WIDTH-25, 0.5)];
    tanchuLineLab2.backgroundColor=[UIColor lightGrayColor];
    [chooseView addSubview:tanchuLineLab2];
    
    UILabel * countTitleLab=[[UILabel alloc] initWithFrame:CGRectMake(15, 71+hight+1+20,150, 20)];
    countTitleLab.text=@"购买数量";
    countTitleLab.font=[UIFont systemFontOfSize:16];
    countTitleLab.textColor=[UIColor lightGrayColor];
    [chooseView addSubview:countTitleLab];
    
    UIButton * jianBtn=[UIButton buttonWithType: UIButtonTypeCustom];
    [jianBtn setBackgroundImage:[UIImage imageNamed:@"减-大.png"] forState:UIControlStateNormal];
    [jianBtn addTarget:self action:@selector(jian:) forControlEvents:UIControlEventTouchUpInside];
    jianBtn.frame=CGRectMake(SCREEN_WIDTH-140, 71+hight+1+20-5, 30, 30);
    [chooseView addSubview:jianBtn];
    
    UIImageView * countImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"购买数量框-大.png"]];
    countImgView.frame=CGRectMake(SCREEN_WIDTH-140+30, 71+hight+1+20-5, 50, 30);
    [chooseView addSubview:countImgView];
    
    _countLab=[[UILabel alloc] initWithFrame:CGRectMake(2, 2, 46, 26)];
    _countLab.font=[UIFont systemFontOfSize:24];
    _countLab.textColor=[UIColor blackColor];
    _countLab.textAlignment=NSTextAlignmentCenter;
    _countLab.text=@"1";
    [countImgView addSubview:_countLab];
    
    UIButton * jiaBtn=[UIButton buttonWithType: UIButtonTypeCustom];
    [jiaBtn setBackgroundImage:[UIImage imageNamed:@"加-大.png"] forState:UIControlStateNormal];
    [jiaBtn addTarget:self action:@selector(jia) forControlEvents:UIControlEventTouchUpInside];
    jiaBtn.frame=CGRectMake(SCREEN_WIDTH-140+80, 71+hight+1+20-5, 30, 30);
    [chooseView addSubview:jiaBtn];
    
    UIButton * sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame=CGRectMake(0, 71+hight+1+20+30+10, SCREEN_WIDTH, 38);
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.backgroundColor=NAV_COLOR;
    sureBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [chooseView addSubview:sureBtn];

}
-(void)choose
{
    NSLog(@"选颜色分类");
    _tanchuView.hidden=NO;
}
-(void)jiaru
{
    NSLog(@"加入购物车");

    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"] isEqualToString:@"0"])
    {
        UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您尚未登录，请先登录。。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK,我知道了。。", nil];
        [alertView show];
        JTLoginViewController * loginVC=[[JTLoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    
    for (int i=0; i<[_titleArr count]; i++)
    {
       NSString * jiluStr= [_jiluArr objectAtIndex:i];
        if ([jiluStr isEqualToString:@""])
        {
            NSString * str=@"请选择分类...";
            [JTAlertViewAnimation startAnimation:str view:self.view];
            return;
        }
    }
    
    JTAppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
    if ([SOAPRequest checkNet])
    {
        
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:_model.idStr,@"goodsId",[NSString stringWithFormat:@"%d",appdelegate.appUser.userID],@"userId",_countLab.text,@"count",_jiluStr, @"property", nil];
        
        NSDictionary * zaojiaoDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Cart_Add] jsonDic:jsondic]];
        
        if ([[NSString stringWithFormat:@"%@",[zaojiaoDic objectForKey:@"resultCode"]]isEqualToString:@"1000"])
        {
            NSString * str=@"添加成功！";
            [JTAlertViewAnimation startAnimation:str view:self.view];
        }
        else
        {
            NSString * str=@"服务器异常，请稍后重试...";
            [JTAlertViewAnimation startAnimation:str view:self.view];
        }
        
    }
}
-(void)goumai
{
    NSLog(@"立即购买");
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"] isEqualToString:@"0"])
    {
        UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您尚未登录，请先登录。。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK,我知道了。。", nil];
        [alertView show];
        JTLoginViewController * loginVC=[[JTLoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    
    for (int i=0; i<[_titleArr count]; i++)
    {
        NSString * jiluStr= [_jiluArr objectAtIndex:i];
        if ([jiluStr isEqualToString:@""])
        {
            NSString * str=@"请选择分类...";
            [JTAlertViewAnimation startAnimation:str view:self.view];
            return;
        }
    }
    
    JTSortModel * model=[[JTSortModel alloc] init];
    model.goodsId=_model.idStr;
    model.title=_model.title;
    model.cost=_model.cost;
    model.youhuiCost=_model.youhuiCost;
    model.propertyStr=_jiluStr;
    model.imgUrlStr=_model.imgUrlStr;
    NSArray * arr=[[NSArray alloc] initWithObjects:model, nil];
    NSArray * countArr=[[NSArray alloc] initWithObjects:_countLab.text, nil];
    JTQuerenDingdanViewController * querenVC=[[JTQuerenDingdanViewController alloc] init];
    querenVC.listModelArr=[[NSArray alloc] initWithArray:arr];
    querenVC.countArr=[[NSArray alloc] initWithArray:countArr];
    querenVC.totalPrice=[_model.cost floatValue]*[_countLab.text floatValue];
    [self.navigationController pushViewController:querenVC animated:YES];
    

}
-(void)chooseColor:(UIButton *)sender
{

    int count=(int)sender.tag/10000;
    int count1=(int)(sender.tag-10000*count-70)/100;
    NSLog(@"点击第%d分类第%d个按钮",count,count1);

    [_jiluArr removeObjectAtIndex:count];
    
    for (int i=0; i<[[_nameArr objectAtIndex:count] count]; i++)
    {
        UIButton * btn=(UIButton *)[_tanchuView viewWithTag:10000*count+i*100+70];
        btn.selected=NO;
    }
    sender.selected=YES;
    [_jiluArr insertObject:[NSString stringWithFormat:@"%@:%@",[_titleArr objectAtIndex:count],[[_nameArr objectAtIndex:count] objectAtIndex:count1]] atIndex:count];
    
}
-(void)jian:(UIButton *)sender
{
    if ([_countLab.text intValue]>1)
    {
     _countLab.text=[NSString stringWithFormat:@"%d",[_countLab.text intValue]-1];
    }
}
-(void)jia
{
    _countLab.text=[NSString stringWithFormat:@"%d",[_countLab.text intValue]+1];
}
-(void)sure
{
    [_jiluStr setString:@""];
    for (int i=0; i<_jiluArr.count; i++)
    {
        NSString * str=[_jiluArr objectAtIndex:i];
        if (![str isEqualToString:@""])
        {
            [_jiluStr appendString:str];
            [_jiluStr appendString:@";"];
        }
    }
    if (![_jiluStr isEqualToString:@""])
    {
        _chooseLab.text=_jiluStr;
    }
    _tanchuView.hidden=YES;
}
-(void)exit
{
  _tanchuView.hidden=YES;
}
-(void)leftBtnCilck
{
    if (self.gouWuCheVC!=nil)
    {
        self.gouWuCheVC.p=1;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titleArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int count=(int)SCREEN_WIDTH/60;
    int count1=(int)[[_nameArr objectAtIndex:indexPath.section] count]/count+1;
    return 30+30*count1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        UILabel * lab=[[UILabel alloc] initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH-30, 20)];
        lab.text=[NSString stringWithFormat:@"%@:",[_titleArr objectAtIndex:indexPath.section]];
        lab.textColor=[UIColor brownColor];
        lab.font=[UIFont systemFontOfSize:15];
        [cell addSubview:lab];
        
        int count=(int)SCREEN_WIDTH/60;
        
        for (int i=0; i<[[_nameArr objectAtIndex:indexPath.section] count]; i++)
        {
            UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundImage:[UIImage imageNamed:@"选择框未选.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"选择框已选.png"] forState:UIControlStateSelected];
            [btn setTitle:[[_nameArr objectAtIndex:indexPath.section] objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            btn.titleLabel.font=[UIFont systemFontOfSize:13];
            btn.frame=CGRectMake(15+i%count*(40+20), 30+i/count*30, 40, 25);
            [btn addTarget:self action:@selector(chooseColor:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=10000*indexPath.section+100*i+70;
            [cell addSubview:btn];
        }
    }

    

    
    return cell;
    
}


#pragma mark- 发请求
-(void)sendPost
{
    
    JTAppDelegate * appDelegate= [UIApplication sharedApplication].delegate;
    NSString * userID=@"";
    userID=[NSString stringWithFormat:@"%d",appDelegate.appUser.userID];
    if ([userID isEqualToString:@""])
    {
        userID=@"0";
    }
    
    if ([SOAPRequest checkNet])
    {
        
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:self.idStr,@"id", nil];
        
        NSDictionary * zaojiaoDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_ShopGoods_getGoodInfo] jsonDic:jsondic]];
        
        if ([[NSString stringWithFormat:@"%@",[zaojiaoDic objectForKey:@"resultCode"]]isEqualToString:@"1000"])
        {
            NSDictionary * resultDic=[[NSDictionary alloc] initWithDictionary:[zaojiaoDic objectForKey:@"sg"] ];
            _model.idStr=[resultDic objectForKey:@"id"];
            _model.provinceStr=@"江苏";
            _model.cityStr=@"南京";
            _model.title=[resultDic objectForKey:@"name"];
            _model.cost=[resultDic objectForKey:@"salesPrice"];
            _model.youhuiCost=[resultDic objectForKey:@"straightPrice"];
            _model.kucunNum=[resultDic objectForKey:@"goodsNum"];
            _model.imgUrlStr=[resultDic objectForKey:@"image"];
            _model.description1=[resultDic objectForKey:@"description"];
            _model.xiaoliangNum=[resultDic objectForKey:@"salesNum"];
            
            NSArray * bigArr=[[NSArray alloc] initWithArray:[resultDic objectForKey:@"attriList"]];
            for (int i=0; i<bigArr.count; i++)
            {
                NSString * titleIDStr=[[bigArr objectAtIndex:i] objectForKey:@"id"];
                NSString * titleStr=[[bigArr objectAtIndex:i] objectForKey:@"value"];
                [_titleIDArr addObject:titleIDStr];
                [_titleArr addObject:titleStr];
                
                NSMutableArray * nameMidIDArr=[[NSMutableArray alloc] initWithCapacity:0];
                NSMutableArray * nameMidArr=[[NSMutableArray alloc] initWithCapacity:0];
                NSArray * smallArr=[[NSArray alloc] initWithArray:[[bigArr objectAtIndex:i] objectForKey:@"dtList"]];
                for (int i=0; i<smallArr.count; i++)
                {
                    NSString * nameIDStr=[[smallArr objectAtIndex:i] objectForKey:@"id"];
                    NSString * nameStr=[[smallArr objectAtIndex:i] objectForKey:@"value"];
                    [nameMidIDArr addObject:nameIDStr];
                    [nameMidArr addObject:nameStr];
                }
                [_nameIDArr addObject:nameMidIDArr];
                [_nameArr addObject:nameMidArr];
                [_jiluArr addObject:@""];
            }
            
            
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
