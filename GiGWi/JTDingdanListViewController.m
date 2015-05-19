//
//  JTDingdanListViewController.m
//  GiGWi
//
//  Created by 小七 on 15-4-24.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTDingdanListViewController.h"
#import "JTDingdanListTableViewCell.h"
#import "JTDetailViewController.h"
#import "JTWuliuViewController.h"
#import "JTSmallTableViewCell1.h"

@interface JTDingdanListViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView * _tableView;
    int p;
    int q;
    int pageNum;
    NSMutableArray * _listModelArr;
    
    UIButton * _seletedBtn;
    
    NSString * _typeIdStr;
    
    UIAlertView * _quxiaoAlertView;
    UIAlertView * _querenAlertView;
    UIAlertView * _tuikuanAlertView;
}

@end

@implementation JTDingdanListViewController
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
        [self sendPost];
    }
    p=2;
    
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
    q=3;
    pageNum=1;
    _listModelArr=[[NSMutableArray alloc] initWithCapacity:0];
    _typeIdStr=@"";
    _seletedBtn=[UIButton buttonWithType:UIButtonTypeCustom];
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
    navTitailLab.text=@"我的订单";
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
    
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,20+NAV_HEIGHT+35, self.view.frame.size.width, self.view.frame.size.height-20-NAV_HEIGHT-35) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [_tableView addHeaderWithTarget:self action:@selector(CompanyListHeaderRefreshing)];
    [_tableView addFooterWithTarget:self  action:@selector(footerRefresh)];
    _tableView.headerRefreshingText =@HeaderRefreshingText;
    _tableView.footerRefreshingText=@FooterRefreshingText;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
   UIView * topView=[[UIView alloc] initWithFrame:CGRectMake(0, 20+NAV_HEIGHT, self.view.frame.size.width, 35)];
    topView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:topView];
    
    NSArray * normalTitleArr=[[NSArray alloc] initWithObjects:@"全部-2.png",@"待付款-2.png",@"待发货-2.png",@"待收货-2.png", nil];
    NSArray * selectedTitleArr=[[NSArray alloc] initWithObjects:@"全部-1.png",@"待付款-1.png",@"待发货-1.png",@"待收货-1.png", nil];
    
    for (int i=0; i<4; i++)
    {
        UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(i*SCREEN_WIDTH/4.0, 0, SCREEN_WIDTH/4.0, 35);
        [btn setImage:[UIImage imageNamed:[normalTitleArr objectAtIndex:i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[selectedTitleArr objectAtIndex:i]] forState:UIControlStateSelected];
        btn.tag=10+i;
        [btn addTarget:self action:@selector(qiehuanType:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:btn];
        if (i==0)
        {
            btn.selected=YES;
            _seletedBtn=btn;
        }
    }
    
}
-(void)qiehuanType:(UIButton *)sender
{
    if (sender==_seletedBtn)
    {
        
    }
    else
    {
        sender.selected=YES;
        _seletedBtn.selected=NO;
        _seletedBtn=sender;
        switch (sender.tag-10)
        {
            case 0:
            {
                NSLog(@"全部");
               _typeIdStr=@"";
            }
                break;
            case 1:
            {
                NSLog(@"待付款");
                _typeIdStr=@"NoPaid";
            }
                break;
            case 2:
            {
                NSLog(@"待发货");
                _typeIdStr=@"NoDelivery";

            }
                break;
            case 3:
            {
                NSLog(@"待收货");
                _typeIdStr=@"NoReceived";

            }
                break;
            default:
                break;
        }
        [self sendPost];
    
    }

}
-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JTSortModel * model=[[JTSortModel alloc] init];
    model=[_listModelArr objectAtIndex:indexPath.row];
    
    return 35+model.orderGoodsArr.count*80+40+5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _listModelArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JTDingdanListTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[JTDingdanListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        cell.backgroundColor=[UIColor clearColor];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    JTSortModel * model=[[JTSortModel alloc] init];
    model=[_listModelArr objectAtIndex:indexPath.row];
    
    if ([model.typeID isEqualToString:@"NoPaid"])
    {
        cell.typeLab.text=@"待付款";
        cell.deletaBtn.hidden=YES;
        cell.ewaiBtn1.hidden=NO;
        [cell.ewaiBtn1 setTitle:@"取消订单" forState:UIControlStateNormal];
        [cell.ewaiBtn1 addTarget:self action:@selector(quxiaodingdan:) forControlEvents:UIControlEventTouchUpInside];
        cell.ewaiBtn1.tag=indexPath.row+20000;
        cell.ewaiBtn2.hidden=NO;
        [cell.ewaiBtn2 setTitle:@"去付款" forState:UIControlStateNormal];
        [cell.ewaiBtn2 addTarget:self action:@selector(qufukuan:) forControlEvents:UIControlEventTouchUpInside];
        cell.ewaiBtn2.tag=indexPath.row+30000;
    }
    else if ([model.typeID isEqualToString:@"NoDelivery"])
    {
        cell.typeLab.text=@"待发货";
        cell.deletaBtn.hidden=YES;
        cell.ewaiBtn1.hidden=NO;
        [cell.ewaiBtn1 setTitle:@"取消订单" forState:UIControlStateNormal];
        [cell.ewaiBtn1 addTarget:self action:@selector(quxiaodingdan:) forControlEvents:UIControlEventTouchUpInside];
        cell.ewaiBtn1.tag=indexPath.row+20000;
//        cell.ewaiBtn2.hidden=NO;
//        [cell.ewaiBtn2 setTitle:@"提醒发货" forState:UIControlStateNormal];
//        [cell.ewaiBtn2 addTarget:self action:@selector(tixingfahuo:) forControlEvents:UIControlEventTouchUpInside];
//        cell.ewaiBtn2.tag=indexPath.row+30000;
        cell.ewaiBtn2.hidden=YES;

    }
    else if ([model.typeID isEqualToString:@"NoReceived"])
    {
        cell.typeLab.text=@"待收货";
        cell.deletaBtn.hidden=YES;
        cell.ewaiBtn1.hidden=NO;
        [cell.ewaiBtn1 setTitle:@"查看物流" forState:UIControlStateNormal];
        [cell.ewaiBtn1 addTarget:self action:@selector(chakanwuliu:) forControlEvents:UIControlEventTouchUpInside];
        cell.ewaiBtn1.tag=indexPath.row+20000;
        cell.ewaiBtn2.hidden=NO;
        [cell.ewaiBtn2 setTitle:@"确认收货" forState:UIControlStateNormal];
        [cell.ewaiBtn2 addTarget:self action:@selector(querenshouhuo:) forControlEvents:UIControlEventTouchUpInside];
        cell.ewaiBtn2.tag=indexPath.row+30000;

        
    }
    else if ([model.typeID isEqualToString:@"Received"])
    {
        cell.typeLab.text=@"已收货";
        cell.deletaBtn.hidden=NO;
        [cell.deletaBtn addTarget:self action:@selector(deleteDingdan:) forControlEvents:UIControlEventTouchUpInside];
        cell.deletaBtn.tag=indexPath.row+10000;
        cell.ewaiBtn1.hidden=YES;
        cell.ewaiBtn2.hidden=NO;
        [cell.ewaiBtn2 setTitle:@"申请退货" forState:UIControlStateNormal];
        [cell.ewaiBtn2 addTarget:self action:@selector(shenqingtuikuan:) forControlEvents:UIControlEventTouchUpInside];
        cell.ewaiBtn2.tag=indexPath.row+30000;

        
    }
    else if ([model.typeID isEqualToString:@"Returning"])
    {
        cell.typeLab.text=@"退货中";
        cell.deletaBtn.hidden=YES;
        cell.ewaiBtn1.hidden=YES;
        cell.ewaiBtn2.hidden=YES;
     }
    else if ([model.typeID isEqualToString:@"Refunding"])
    {
        cell.typeLab.text=@"退款中";
        cell.deletaBtn.hidden=YES;
        cell.ewaiBtn1.hidden=YES;
        cell.ewaiBtn2.hidden=YES;
        
    }
    else if ([model.typeID isEqualToString:@"Refunded"])
    {
        cell.typeLab.text=@"已退款";
        cell.deletaBtn.hidden=YES;
        cell.ewaiBtn1.hidden=YES;
        cell.ewaiBtn2.hidden=YES;
        
    }
    else if ([model.typeID isEqualToString:@"Completed"])
    {
        cell.typeLab.text=@"已完成";
        cell.deletaBtn.hidden=YES;
//        cell.deletaBtn.hidden=NO;
//        [cell.deletaBtn addTarget:self action:@selector(deleteDingdan:) forControlEvents:UIControlEventTouchUpInside];
//        cell.deletaBtn.tag=indexPath.row+10000;
        cell.ewaiBtn1.hidden=YES;
        cell.ewaiBtn2.hidden=YES;
        
    }
    
    for (int i=0; i<model.orderGoodsArr.count; i++)
    {
        JTSortModel * smallModel=[[JTSortModel alloc] init];
        smallModel=[model.orderGoodsArr objectAtIndex:i];
        
        JTSmallTableViewCell1 * smallCell=[[JTSmallTableViewCell1 alloc] initWithFrame:CGRectMake(0, 35+i*80, SCREEN_WIDTH, 80)];
        [smallCell ready:smallModel];
        [cell addSubview:smallCell];
    }
    
    cell.bgView3.frame=CGRectMake(0, 35+model.orderGoodsArr.count*80, SCREEN_WIDTH,40);

    cell.totalLab.text=[NSString stringWithFormat:@"实付款:%.2f元",[model.shifukuanNum floatValue]];
    
    
    return cell;
}
-(void)quxiaodingdan:(UIButton *)sender
{
    int count=(int)sender.tag-20000;
    NSLog(@"订单%d取消订单",count);
    
    _quxiaoAlertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定要取消该订单吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"暂不", nil];
    _quxiaoAlertView.tag=count+1000;
    [_quxiaoAlertView show];
    
}
-(void)qufukuan:(UIButton *)sender
{
    int count=(int)sender.tag-30000;
   
    JTSortModel * model=[[JTSortModel alloc] init];
    model=[_listModelArr objectAtIndex:count];
    NSLog(@"订单%d去付款,需付款金额:%@",count,model.shifukuanNum);

}
-(void)tixingfahuo:(UIButton *)sender
{
    int count=(int)sender.tag-30000;
    NSLog(@"订单%d提醒发货",count);
}
-(void)chakanwuliu:(UIButton *)sender
{
    int count=(int)sender.tag-20000;
    NSLog(@"订单%d查看物流",count);
    JTSortModel * model=[[JTSortModel alloc] init];
    model=[_listModelArr objectAtIndex:count];
    JTWuliuViewController * wuliuVC=[[JTWuliuViewController alloc] init];
//    wuliuVC.kuaidiTitle=model.wuliuGongsi;
//    wuliuVC.kuaidiName=model.wuliuGongsiPinyin;
//    wuliuVC.kuaidiId=model.wuliuDanhaoId;
    wuliuVC.kuaidiTitle=@"申通快递";
    wuliuVC.kuaidiName=@"shentong";
    wuliuVC.kuaidiId=@"968666740049";
    [self.navigationController pushViewController:wuliuVC animated:YES];
    
}
-(void)querenshouhuo:(UIButton *)sender
{
    int count=(int)sender.tag-30000;
    NSLog(@"订单%d确认收货",count);
    
    _querenAlertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请确认收到货物后再点击此按钮，以免财货两空" delegate:self cancelButtonTitle:@"确认收货" otherButtonTitles:@"取消", nil];
    _querenAlertView.tag=count+1000;
    [_querenAlertView show];
    
   
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView==_querenAlertView)
    {
        if (buttonIndex==0)
        {
            JTSortModel * model=[[JTSortModel alloc] init];
            model=[_listModelArr objectAtIndex:alertView.tag-1000];
            if ([SOAPRequest checkNet])
            {
                NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:model.idStr,@"id", nil];
                
                NSDictionary * editUserDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Order_Confirm] jsonDic:jsondic]];
                
                if ([[editUserDic objectForKey:@"resultCode"] intValue]==1000)
                {
                    [self sendPost];
                }
                else
                {
                    NSString * str=@"服务器异常，请稍后重试...";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                }
            }
            
        }

    }
    else if (alertView==_quxiaoAlertView)
    {
        if (buttonIndex==0)
        {
            JTSortModel * model=[[JTSortModel alloc] init];
            model=[_listModelArr objectAtIndex:alertView.tag-1000];
            if ([SOAPRequest checkNet])
            {
                NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:model.idStr,@"id", nil];
                
                NSDictionary * editUserDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Order_Cancel] jsonDic:jsondic]];
                
                if ([[editUserDic objectForKey:@"resultCode"] intValue]==1000)
                {
                    [self sendPost];
                }
                else
                {
                    NSString * str=@"服务器异常，请稍后重试...";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                }
            }

        }
    }
    else if (alertView==_tuikuanAlertView)
    {
        if (buttonIndex==0)
        {
            JTSortModel * model=[[JTSortModel alloc] init];
            model=[_listModelArr objectAtIndex:alertView.tag-1000];
            
            if ([SOAPRequest checkNet])
            {
                NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:model.idStr,@"id", nil];
                
                NSDictionary * editUserDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Order_Return] jsonDic:jsondic]];
                
                if ([[editUserDic objectForKey:@"resultCode"] intValue]==1000)
                {
                    [self sendPost];
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
-(void)deleteDingdan:(UIButton *)sender
{
    int count=(int)sender.tag-10000;
    NSLog(@"订单%d删除订单",count);
}
-(void)shenqingtuikuan:(UIButton *)sender
{
    int count=(int)sender.tag-30000;
    NSLog(@"订单%d申请退款",count);
    
    _tuikuanAlertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定要退换此商品吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    _tuikuanAlertView.tag=count+1000;
    [_tuikuanAlertView show];
    
}
-(void)sendPost
{
    pageNum=1;
    [_listModelArr removeAllObjects];
    [_tableView reloadData];
    q=3;
    [_tableView headerBeginRefreshing];
}
-(void)CompanyListHeaderRefreshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 刷新表格
        [self GetCompanyListData];
        [_tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_tableView headerEndRefreshing];
    });
}

-(void)footerRefresh
{
    pageNum++;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //请求数据
        [self loadMoreData];
        // 刷新表格
        [_tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_tableView footerEndRefreshing];
    });
}
-(void)GetCompanyListData
{
    
    JTAppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
    if ([SOAPRequest checkNet])
    {
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"pageNum",@"20",@"pageSize",[NSString stringWithFormat:@"%d",appdelegate.appUser.userID],@"userId",_typeIdStr,@"status", nil];
        
        NSDictionary * zaojiaoListDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Order_Page] jsonDic:jsondic]];
        
        if ([[NSString stringWithFormat:@"%@",[zaojiaoListDic objectForKey:@"resultCode"]] isEqualToString:@"1000"])
        {
            if (q==3)
            {
                if ([[zaojiaoListDic objectForKey:@"page"] count] ==0)
                {
                    NSString * str=@"未找到符合条件的数据！";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                    return;
                }
                NSArray * zaojiaoListArr=[zaojiaoListDic objectForKey:@"page"];
                for (int i=0; i<zaojiaoListArr.count; i++)
                {
                    
                    JTSortModel * sortModel=[[JTSortModel alloc] init];
                    sortModel.idStr=[[[zaojiaoListArr objectAtIndex:i]objectForKey:@"order"]  objectForKey:@"id"];
                    sortModel.typeID=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"order"] objectForKey:@"status"];
                    sortModel.shifukuanNum=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"order"] objectForKey:@"totalPrice"];
                    sortModel.wuliuGongsi=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"order"] objectForKey:@"company"];
                    sortModel.wuliuDanhaoId=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"order"] objectForKey:@"waybillNum"];
                    sortModel.wuliuGongsiPinyin=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"order"] objectForKey:@"companyPinyin"];
                    NSArray * goodsListArr=[[[zaojiaoListDic objectForKey:@"page"] objectAtIndex:i] objectForKey:@"orderGoods"];
                    NSMutableArray * goodsArr=[[NSMutableArray alloc] initWithCapacity:0];
                    for (int j=0; j<goodsListArr.count; j++)
                    {
                        JTSortModel * smallModel=[[JTSortModel alloc] init];
                        smallModel.idStr=[[goodsListArr objectAtIndex:j] objectForKey:@"id"];
                        smallModel.goodsId=[[goodsListArr objectAtIndex:j] objectForKey:@"goodsId"];
                        smallModel.title=[[goodsListArr objectAtIndex:j] objectForKey:@"goodsName"];
                        smallModel.cost=[[goodsListArr objectAtIndex:j] objectForKey:@"unitPrice"];
                        //smallModel.youhuiCost=[[goodsListArr objectAtIndex:j] objectForKey:@"straightPrice"];
                        smallModel.propertyStr=[[goodsListArr objectAtIndex:j] objectForKey:@"property"];
                        smallModel.goumaiNum=[[goodsListArr objectAtIndex:j] objectForKey:@"count"];
                        smallModel.imgUrlStr=[[goodsListArr objectAtIndex:j] objectForKey:@"imgUrl"];
                        [goodsArr addObject:smallModel];
                        
                    }
                    sortModel.orderGoodsArr=[[NSArray alloc] initWithArray:goodsArr];
                    
                    [_listModelArr addObject:sortModel];
                    
                }
                q=6;
            }
            else
            {
                pageNum=1;
                [_listModelArr removeAllObjects];
                
                if ([[zaojiaoListDic objectForKey:@"page"] count] ==0)
                {
                    NSString * str=@"未找到符合条件的数据！";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                    return;
                }
                NSArray * zaojiaoListArr=[zaojiaoListDic objectForKey:@"page"];
                for (int i=0; i<zaojiaoListArr.count; i++)
                {
                    
                    JTSortModel * sortModel=[[JTSortModel alloc] init];
                    sortModel.idStr=[[[zaojiaoListArr objectAtIndex:i]objectForKey:@"order"]  objectForKey:@"id"];
                    sortModel.typeID=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"order"] objectForKey:@"status"];
                    sortModel.shifukuanNum=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"order"] objectForKey:@"totalPrice"];
                    sortModel.wuliuGongsi=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"order"] objectForKey:@"company"];
                    sortModel.wuliuDanhaoId=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"order"] objectForKey:@"waybillNum"];
                    sortModel.wuliuGongsiPinyin=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"order"] objectForKey:@"companyPinyin"];
                    NSArray * goodsListArr=[[[zaojiaoListDic objectForKey:@"page"] objectAtIndex:i] objectForKey:@"orderGoods"];
                    NSMutableArray * goodsArr=[[NSMutableArray alloc] initWithCapacity:0];
                    for (int j=0; j<goodsListArr.count; j++)
                    {
                        JTSortModel * smallModel=[[JTSortModel alloc] init];
                        smallModel.idStr=[[goodsListArr objectAtIndex:j] objectForKey:@"id"];
                        smallModel.goodsId=[[goodsListArr objectAtIndex:j] objectForKey:@"goodsId"];
                        smallModel.title=[[goodsListArr objectAtIndex:j] objectForKey:@"goodsName"];
                        smallModel.cost=[[goodsListArr objectAtIndex:j] objectForKey:@"unitPrice"];
                        //smallModel.youhuiCost=[[goodsListArr objectAtIndex:j] objectForKey:@"straightPrice"];
                        smallModel.propertyStr=[[goodsListArr objectAtIndex:j] objectForKey:@"property"];
                        smallModel.goumaiNum=[[goodsListArr objectAtIndex:j] objectForKey:@"count"];
                        smallModel.imgUrlStr=[[goodsListArr objectAtIndex:j] objectForKey:@"imgUrl"];
                        [goodsArr addObject:smallModel];
                        
                    }
                    sortModel.orderGoodsArr=[[NSArray alloc] initWithArray:goodsArr];
                    
                    [_listModelArr addObject:sortModel];
                    
                }
            }
            
        }
        else
        {
            NSString * str=@"服务器异常，请稍后重试...";
            [JTAlertViewAnimation startAnimation:str view:self.view];
        }
        

    }
    
}
-(void)loadMoreData
{
    if ([SOAPRequest checkNet])
    {
        JTAppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",pageNum],@"pageNum",@"20",@"pageSize",[NSString stringWithFormat:@"%d",appdelegate.appUser.userID],@"userId",_typeIdStr,@"status",  nil];
        
        NSDictionary * zaojiaoListDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Order_Page] jsonDic:jsondic]];
        if ([[zaojiaoListDic objectForKey:@"resultCode"] intValue]==1000)
        {
            if ([[zaojiaoListDic objectForKey:@"page"]count]==0)
            {
                NSString * str=@"已全部加载完毕！";
                [JTAlertViewAnimation startAnimation:str view:self.view];
                pageNum--;
                return;
            }
            NSArray * zaojiaoListArr=[zaojiaoListDic objectForKey:@"page"] ;
            for (int i=0; i<zaojiaoListArr.count; i++)
            {
                JTSortModel * sortModel=[[JTSortModel alloc] init];
                sortModel.idStr=[[[zaojiaoListArr objectAtIndex:i]objectForKey:@"order"]  objectForKey:@"id"];
                sortModel.typeID=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"order"] objectForKey:@"status"];
                sortModel.shifukuanNum=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"order"] objectForKey:@"totalPrice"];
                sortModel.wuliuGongsi=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"order"] objectForKey:@"company"];
                sortModel.wuliuDanhaoId=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"order"] objectForKey:@"waybillNum"];
                sortModel.wuliuGongsiPinyin=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"order"] objectForKey:@"companyPinyin"];
                NSArray * goodsListArr=[[[zaojiaoListDic objectForKey:@"page"] objectAtIndex:i] objectForKey:@"orderGoods"];
                NSMutableArray * goodsArr=[[NSMutableArray alloc] initWithCapacity:0];
                for (int j=0; j<goodsListArr.count; j++)
                {
                    JTSortModel * smallModel=[[JTSortModel alloc] init];
                    smallModel.idStr=[[goodsListArr objectAtIndex:j] objectForKey:@"id"];
                    smallModel.goodsId=[[goodsListArr objectAtIndex:j] objectForKey:@"goodsId"];
                    smallModel.title=[[goodsListArr objectAtIndex:j] objectForKey:@"goodsName"];
                    smallModel.cost=[[goodsListArr objectAtIndex:j] objectForKey:@"unitPrice"];
                    //smallModel.youhuiCost=[[goodsListArr objectAtIndex:j] objectForKey:@"straightPrice"];
                    smallModel.propertyStr=[[goodsListArr objectAtIndex:j] objectForKey:@"property"];
                    smallModel.goumaiNum=[[goodsListArr objectAtIndex:j] objectForKey:@"count"];
                    smallModel.imgUrlStr=[[goodsListArr objectAtIndex:j] objectForKey:@"imgUrl"];
                    [goodsArr addObject:smallModel];
                    
                }
                sortModel.orderGoodsArr=[[NSArray alloc] initWithArray:goodsArr];
                
                [_listModelArr addObject:sortModel];
                
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
