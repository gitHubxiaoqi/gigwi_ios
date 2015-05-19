//
//  JTtuijianViewController.m
//  GiGWi
//
//  Created by 小七 on 15-4-24.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTtuijianViewController.h"
#import "JTTuijianTableViewCell.h"
#import "JTSmallTableViewCell1.h"

@interface JTtuijianViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    int p;
    int q;
    int pageNum;
    NSMutableArray * _listModelArr;
    
    NSString * _typeIdStr;
    
    UIButton * _selectedBtn1;
    UIButton * _selectedBtn2;
}

@end

@implementation JTtuijianViewController
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
    _typeIdStr=@"UnSettled";
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
    navTitailLab.text=@"我的推荐";
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
    
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,20+NAV_HEIGHT+55, self.view.frame.size.width, self.view.frame.size.height-20-NAV_HEIGHT-55) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [_tableView addHeaderWithTarget:self action:@selector(CompanyListHeaderRefreshing)];
    [_tableView addFooterWithTarget:self  action:@selector(footerRefresh)];
    _tableView.headerRefreshingText =@HeaderRefreshingText;
    _tableView.footerRefreshingText=@FooterRefreshingText;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    UIView * topView=[[UIView alloc] initWithFrame:CGRectMake(0,20+NAV_HEIGHT, self.view.frame.size.width, 55)];
    topView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:topView];
    
    _selectedBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    _selectedBtn1.frame=CGRectMake(20,10, (SCREEN_WIDTH-40)/2.0, 35);
    [_selectedBtn1 setImage:[UIImage imageNamed:@"未结算-2.png"] forState:UIControlStateSelected];
    [_selectedBtn1 setImage:[UIImage imageNamed:@"未结算-1.png"] forState:UIControlStateNormal];
    [_selectedBtn1 addTarget:self action:@selector(qiehuan:) forControlEvents:UIControlEventTouchUpInside];
    _selectedBtn1.selected=YES;
    [topView addSubview:_selectedBtn1];
    
    
    _selectedBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
    _selectedBtn2.frame=CGRectMake((SCREEN_WIDTH-40)/2.0+20, 10, (SCREEN_WIDTH-40)/2.0, 35);
    [_selectedBtn2 setImage:[UIImage imageNamed:@"已结算-2.png"] forState:UIControlStateSelected];
    [_selectedBtn2 setImage:[UIImage imageNamed:@"已结算-1.png"] forState:UIControlStateNormal];
    [_selectedBtn2 addTarget:self action:@selector(qiehuan:) forControlEvents:UIControlEventTouchUpInside];
    _selectedBtn2.selected=NO;
    [topView addSubview:_selectedBtn2];

    
}
-(void)qiehuan:(UIButton *)sender
{
    
    if (sender==_selectedBtn1)
    {
        _selectedBtn1.selected=YES;
        _selectedBtn2.selected=NO;
        _typeIdStr=@"UnSettled";
        [self sendPost];
    }
    else if (sender==_selectedBtn2)
    {
        _selectedBtn1.selected=NO;
        _selectedBtn2.selected=YES;
        _typeIdStr=@"Settled";
        [self sendPost];
    }
}

-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{;
    
    JTSortModel * model=[[JTSortModel alloc] init];
    model=[_listModelArr objectAtIndex:indexPath.row];
    
    return 30+model.orderGoodsArr.count*80+30+10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _listModelArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JTTuijianTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[JTTuijianTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor=[UIColor clearColor];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    JTSortModel * model=[[JTSortModel alloc] init];
    model=[_listModelArr objectAtIndex:indexPath.row];
    
    cell.userNameLab.text=[NSString stringWithFormat:@"买家:%@",model.name];
    
    cell.youhuimaNumLab.hidden=YES;
    //cell.youhuimaNumLab.text=[NSString stringWithFormat:@"优惠码:%@",model.score];
    
    for (int i=0; i<model.orderGoodsArr.count; i++)
    {
        JTSortModel * smallModel=[[JTSortModel alloc] init];
        smallModel=[model.orderGoodsArr objectAtIndex:i];
        
        JTSmallTableViewCell1 * smallCell=[[JTSmallTableViewCell1 alloc] initWithFrame:CGRectMake(0, 30+i*80, SCREEN_WIDTH, 80)];
        [smallCell ready:smallModel];
        [cell addSubview:smallCell];
    }
    
    cell.bgView3.frame=CGRectMake(0, 30+model.orderGoodsArr.count*80, SCREEN_WIDTH,30);

    cell.totalLab.text=[NSString stringWithFormat:@"实付款:%.2f元",[model.shifukuanNum floatValue]];
    cell.ewaiLab.text=[NSString stringWithFormat:@"收益:￥%.2f",[model.offer floatValue]];
    
    return cell;
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
    NSString * yaoqingmaStr=@"";
    if (appdelegate.appUser.yaoqingma==nil||[appdelegate.appUser.yaoqingma isEqualToString:@""])
    {
        //yaoqingmaStr=@"ppppp";
    }
    else
    {
        yaoqingmaStr=appdelegate.appUser.yaoqingma;
    }
    
    if ([SOAPRequest checkNet])
    {
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:_typeIdStr,@"settlement",@"1",@"pageNum",@"20",@"pageSize",yaoqingmaStr,@"invitationCode", nil];
        
        NSDictionary * zaojiaoListDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Order_InvitationOrder] jsonDic:jsondic]];
        
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
                    sortModel.offer=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"order"] objectForKey:@"rebate"];
                    sortModel.name=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"order"] objectForKey:@"buyerName"];
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
                    sortModel.offer=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"order"] objectForKey:@"rebate"];
                    sortModel.name=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"order"] objectForKey:@"buyerName"];
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
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:@"ppppp",@"invitationCode",_typeIdStr,@"settlement",[NSString stringWithFormat:@"%d",pageNum],@"pageNum",@"20",@"pageSize", nil];
        
        NSDictionary * zaojiaoListDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Order_InvitationOrder] jsonDic:jsondic]];
        
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
                sortModel.offer=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"order"] objectForKey:@"rebate"];
                sortModel.name=[[[zaojiaoListArr objectAtIndex:i] objectForKey:@"order"] objectForKey:@"buyerName"];
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
