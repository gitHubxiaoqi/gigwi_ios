//
//  JTMainViewController.m
//  GiGWi
//
//  Created by 小七 on 15-4-21.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTMainViewController.h"
#import "JTMainTableViewCell.h"
#import "JTDetailViewController.h"
#import "JTSearchViewController.h"

@interface JTMainViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView * _tableView;
    int p;
    int q;
    int pageNum;
    
    NSMutableArray * _listModelArr;
}

@end

@implementation JTMainViewController
-(void)viewDidAppear:(BOOL)animated
{
    if (p==1)
    {
        [self onCheckVersion];
        [self sendPost];
    }
    p=2;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    p=1;
    q=3;
    pageNum=1;
    _listModelArr=[[NSMutableArray alloc] initWithCapacity:0];
    [self readyUI];
}
-(void)readyUI
{
    self.view.backgroundColor=BG_COLOR;
    self.navigationController.navigationBar.hidden=YES;
    
    //自定义导航条
    UIView * navBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, NAV_HEIGHT)];
    navBarView.backgroundColor=NAV_COLOR;
    [self.view addSubview:navBarView];
    
    UIImageView * logoImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iTunesArtwork@2x.png"]];
    logoImgView.frame=CGRectMake(25, 7, 30, 30);
    [navBarView addSubview:logoImgView];
    
    UILabel * navTitailLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    navTitailLab.text=@"GiGwi";
    navTitailLab.textAlignment=NSTextAlignmentCenter;
    navTitailLab.textColor=[UIColor whiteColor];
    navTitailLab.font=[UIFont systemFontOfSize:18];
    [navBarView addSubview:navTitailLab];

//    UIButton * rightBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame=CGRectMake(80,12,self.view.frame.size.width-10-80, 20);
//    [rightBtn setBackgroundImage:[UIImage imageNamed:@"首页-搜索框.png"] forState:UIControlStateNormal];
//    
//    UILabel * searchLab=[[UILabel alloc] initWithFrame:CGRectMake(30, 0, self.view.frame.size.width-10-80-30-10, 20)];
//    searchLab.text=@"请输入类别或关键字";
//    searchLab.textColor=[UIColor whiteColor];
//    searchLab.font=[UIFont systemFontOfSize:14];
//    [rightBtn addSubview:searchLab];
//    
//    [rightBtn addTarget:self action:@selector(searchBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [navBarView addSubview:rightBtn];
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,20+NAV_HEIGHT, self.view.frame.size.width, self.view.frame.size.height-20-NAV_HEIGHT-TAB_HEIGHT) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [_tableView addHeaderWithTarget:self action:@selector(CompanyListHeaderRefreshing)];
    [_tableView addFooterWithTarget:self  action:@selector(footerRefresh)];
    _tableView.headerRefreshingText =@HeaderRefreshingText;
    _tableView.footerRefreshingText=@FooterRefreshingText;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
}
//-(void)searchBtn:(UIButton *)sender
//{
//    JTSearchViewController * sVC=[[JTSearchViewController alloc]init];
//    [self.navigationController pushViewController:sVC animated:YES];
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10+(SCREEN_WIDTH-30)/2.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_listModelArr.count%2==0)
    {
        return _listModelArr.count/2;
    }
    else
    {
        return _listModelArr.count/2+1;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JTMainTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[JTMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor=[UIColor clearColor];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    JTSortModel * model1=[_listModelArr objectAtIndex:indexPath.row*2];
    JTSortModel * model2=[[JTSortModel alloc] init];
    if(_listModelArr.count%2==0)
    {
        model2=[_listModelArr objectAtIndex:indexPath.row*2+1];
    }
    else
    {
        if (indexPath.row<_listModelArr.count/2)
        {
             model2=[_listModelArr objectAtIndex:indexPath.row*2+1];
            cell.btn2.hidden=NO;
        }
        else
        {
            cell.btn2.hidden=YES;
        }
    
    }
    //左侧
    cell.btn1.tag=1000+indexPath.row*2;
    [cell.btn1 addTarget:self action:@selector(detail:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.imgView1 setImageWithURL:[NSURL URLWithString:model1.imgUrlStr] placeholderImage:[UIImage imageNamed:@"adapter_default_icon"]];
    cell.titleLab1.text=model1.title;
    NSString * priceStr1=@"";
    if (model1.cost==nil||[[NSString stringWithFormat:@"%@",model1.cost] isEqualToString:@""]||[model1.cost intValue]==0)
    {
        priceStr1=@"暂无标价";
        cell.priceLab1.textColor=[UIColor orangeColor];
    }
    else
    {
        priceStr1=[NSString stringWithFormat:@"￥%@",model1.cost];
        cell.priceLab1.textColor=NAV_COLOR;
    }
    cell.priceLab1.text=priceStr1;
    
    NSString * countStr1=@"";
    if (model1.xiaoliangNum==nil||[[NSString stringWithFormat:@"%@",model1.xiaoliangNum] isEqualToString:@""]||[model1.xiaoliangNum intValue]==0)
    {
        countStr1=@"0人付款";
    }
    else
    {
        countStr1=[NSString stringWithFormat:@"%@人付款",model1.xiaoliangNum];
    }
    cell.countLab1.text=countStr1;
    //右侧
    cell.btn2.tag=1000+indexPath.row*2+1;
    [cell.btn2 addTarget:self action:@selector(detail:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.imgView2 setImageWithURL:[NSURL URLWithString:model2.imgUrlStr] placeholderImage:[UIImage imageNamed:@"adapter_default_icon"]];
    cell.titleLab2.text=model2.title;
    NSString * priceStr2=@"";
    if (model2.cost==nil||[[NSString stringWithFormat:@"%@",model1.cost] isEqualToString:@""]||[model2.cost intValue]==0)
    {
        priceStr2=@"暂无标价";
        cell.priceLab2.textColor=[UIColor orangeColor];
    }
    else
    {
        priceStr2=[NSString stringWithFormat:@"￥%@",model2.cost];
        cell.priceLab2.textColor=NAV_COLOR;
    }
    cell.priceLab2.text=priceStr2;
    
    NSString * countStr2=@"";
    if (model2.xiaoliangNum==nil||[[NSString stringWithFormat:@"%@",model1.xiaoliangNum] isEqualToString:@""]||[model2.xiaoliangNum intValue]==0)
    {
        countStr2=@"0人付款";
    }
    else
    {
        countStr2=[NSString stringWithFormat:@"%@人付款",model2.xiaoliangNum];
    }
    cell.countLab2.text=countStr2;

    return cell;
}
-(void)detail:(UIButton *)sender
{
    int count=(int)sender.tag-1000;
    NSLog(@"点击了第%d个",count);
    JTSortModel *model=[_listModelArr objectAtIndex:count];
    JTDetailViewController *detailVC=[[JTDetailViewController alloc] init];
    detailVC.idStr=model.idStr;
    [self.navigationController pushViewController:detailVC animated:YES];
    
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
    
    if ([SOAPRequest checkNet])
    {
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"pageNum",@"20",@"pageSize", nil];
        
        NSDictionary * zaojiaoListDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_ShopGoods_page] jsonDic:jsondic]];
        
        if ([[NSString stringWithFormat:@"%@",[zaojiaoListDic objectForKey:@"resultCode"]] isEqualToString:@"1000"])
        {
            if (q==3)
            {
                if ([[zaojiaoListDic objectForKey:@"page"]count]==0)
                {
                    NSString * str=@"未找到符合条件的数据！";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                    return;
                }
                NSArray * zaojiaoListArr=[zaojiaoListDic objectForKey:@"page"] ;
                for (int i=0; i<zaojiaoListArr.count; i++)
                {
                    
                    JTSortModel * model=[[JTSortModel alloc] init];
                    model.imgUrlStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"image"];
                    model.title=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"name"];
                    model.cost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"salesPrice"];
                    model.xiaoliangNum=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"salesNum"];
                    model.idStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                    [_listModelArr addObject:model];
                    
                }
                q=6;
            }
            else
            {
                pageNum=1;
                [_listModelArr removeAllObjects];
                
                if ([[zaojiaoListDic objectForKey:@"page"]count]==0)
                {
                    NSString * str=@"未找到符合条件的数据！";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                    return;
                }
                NSArray * zaojiaoListArr=[zaojiaoListDic objectForKey:@"page"] ;
                for (int i=0; i<zaojiaoListArr.count; i++)
                {
                    
                    JTSortModel * model=[[JTSortModel alloc] init];
                    model.imgUrlStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"image"];
                    model.title=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"name"];
                    model.cost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"salesPrice"];
                    model.xiaoliangNum=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"salesNum"];
                    model.idStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                    [_listModelArr addObject:model];
                    
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
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",pageNum],@"pageNum",@"20",@"pageSize", nil];
        
        NSDictionary * zaojiaoListDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_ShopGoods_page] jsonDic:jsondic]];
        
        
        if ([[zaojiaoListDic objectForKey:@"resultCode"] intValue]==1000)
        {
            if ([[zaojiaoListDic objectForKey:@"page"] count]==0)
            {
                NSString * str=@"已全部加载完毕！";
                [JTAlertViewAnimation startAnimation:str view:self.view];
                pageNum--;
                return;
            }
            NSArray * zaojiaoListArr=[zaojiaoListDic objectForKey:@"page"] ;
            for (int i=0; i<zaojiaoListArr.count; i++)
            {
                JTSortModel * model=[[JTSortModel alloc] init];
                model.imgUrlStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"image"];
                model.title=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"name"];
                model.cost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"salesPrice"];
                model.xiaoliangNum=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"salesNum"];
                model.idStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                [_listModelArr addObject:model];
            }
            
        }
        else
        {
            NSString * str=@"服务器异常，请稍后重试...";
            [JTAlertViewAnimation startAnimation:str view:self.view];
        }
        
    }
    
}
-(void)onCheckVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    if ([SOAPRequest checkNet])
    {
        NSDictionary * zaojiaoDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_VersionUpdate_GetLastVersionForIOS] jsonDic:@{}]];
        if ( [[NSString stringWithFormat:@"%@",[zaojiaoDic objectForKey:@"resultCode"]] isEqualToString:@"1000"])
        {
            NSString *lastVersion =[[zaojiaoDic objectForKey:@"version"] objectForKey:@"versionCode"];
            if (![lastVersion isEqualToString:currentVersion]&&[lastVersion floatValue]>[currentVersion floatValue]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"有新的版本更新，是否前往更新？" delegate:self cancelButtonTitle:@"暂不" otherButtonTitles:@"更新", nil];
                [alert show];
                
            }
            
        }
        
    }
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/qyli/id991987497?mt=8"];
        [[UIApplication sharedApplication]openURL:url];
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
