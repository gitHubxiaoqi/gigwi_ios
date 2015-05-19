//
//  JTWuliuViewController.m
//  GiGWi
//
//  Created by 小七 on 15-4-30.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTWuliuViewController.h"
#import "JTWuliuTableViewCell.h"

@interface JTWuliuViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    int p;
    NSMutableArray * _listModelArr;
    
}

@end

@implementation JTWuliuViewController

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
   
    _listModelArr=[[NSMutableArray alloc] initWithCapacity:0];
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
    navTitailLab.text=@"物流详情";
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
   
    UIView * bgView=[[UIView alloc] initWithFrame:CGRectMake(0,20+NAV_HEIGHT+40, self.view.frame.size.width, self.view.frame.size.height-20-NAV_HEIGHT-40)];
    bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgView];
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,20, self.view.frame.size.width, self.view.frame.size.height-20-NAV_HEIGHT-40-20) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [bgView addSubview:_tableView];
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    UIView * topView=[[UIView alloc] initWithFrame:CGRectMake(0,20+NAV_HEIGHT, self.view.frame.size.width, 30)];
    topView.backgroundColor=[UIColor colorWithRed:94.0/255.0 green:107.0/255.0 blue:133.0/255.0 alpha:1];
    [self.view addSubview:topView];
    
    UILabel * titleLab=[[UILabel alloc] initWithFrame:CGRectMake(20, 5, 150, 20)];
    titleLab.textColor=[UIColor whiteColor];
    titleLab.font=[UIFont systemFontOfSize:16];
    titleLab.text=self.kuaidiTitle;
    [topView addSubview:titleLab];
    
    UILabel * danhaoLab=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0 , 5, SCREEN_WIDTH/2.0 -20, 20)];
    danhaoLab.textColor=[UIColor whiteColor];
    danhaoLab.font=[UIFont systemFontOfSize:13];
    danhaoLab.textAlignment=NSTextAlignmentRight;
    danhaoLab.text=[NSString stringWithFormat:@"运单编号:%@",self.kuaidiId];
    [topView addSubview:danhaoLab];
    
}
-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JTSortModel * model=[[JTSortModel alloc] init];
    model=[_listModelArr objectAtIndex:indexPath.row];
    
    CGSize autoSize=[model.title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    if (autoSize.height<20)
    {
        autoSize.height=20;
    }

    return autoSize.height+20+10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _listModelArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JTWuliuTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[JTWuliuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor=[UIColor clearColor];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    JTSortModel * model=[[JTSortModel alloc] init];
    model=[_listModelArr objectAtIndex:indexPath.row];
    
    CGSize autoSize=[model.title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell.titleLab.font} context:nil].size;
    if (autoSize.height<20)
    {
        autoSize.height=20;
    }
    cell.titleLab.frame=CGRectMake(40, 0, SCREEN_WIDTH-60, autoSize.height);
    cell.titleLab.text=model.title;
    cell.detaLab.frame=CGRectMake(40, autoSize.height, SCREEN_WIDTH-60, 20);
    cell.detaLab.text=model.registTime;

    if (indexPath.row==0)
    {
        cell.titleLab.textColor=[UIColor colorWithRed:84.0/255.0 green:165.0/255.0 blue:95.0/255.0 alpha:1];
        cell.detaLab.textColor=[UIColor colorWithRed:84.0/255.0 green:165.0/255.0 blue:95.0/255.0 alpha:1];
        cell.imgView.frame=CGRectMake(20, 3, 15, 15);
        [cell.imgView setImage:[UIImage imageNamed:@"物流圈1.png"]];
        cell.lineLab.frame=CGRectMake(27, 15+3, 1, autoSize.height+20+10-15);
    }
    else if (indexPath.row==_listModelArr.count-1)
    {
        cell.titleLab.textColor=[UIColor blackColor];
        cell.detaLab.textColor=[UIColor grayColor];
        cell.imgView.frame=CGRectMake(22.5, 3, 10, 10);
        [cell.imgView setImage:[UIImage imageNamed:@"物流圈2.png"]];
        cell.lineLab.hidden=YES;
    }
    else
    {
        cell.titleLab.textColor=[UIColor blackColor];
        cell.detaLab.textColor=[UIColor grayColor];
        cell.imgView.frame=CGRectMake(22.5, 3, 10, 10);
        [cell.imgView setImage:[UIImage imageNamed:@"物流圈2.png"]];
        cell.lineLab.frame=CGRectMake(27, 10+3, 1, autoSize.height+20+10-10);
    
    }
    
    cell.bounds=CGRectMake(0, 0, SCREEN_WIDTH, autoSize.height+20+10);
    
    return cell;
}
#pragma mark- 发请求
-(void)sendPost
{
    if ([SOAPRequest checkNet])
    {
        
        NSDictionary * zaojiaoDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByGetURL:[NSString stringWithFormat:@"http://www.kuaidi100.com/query?type=%@&postid=%@",self.kuaidiName,self.kuaidiId]]];
        
        if ([[NSString stringWithFormat:@"%@",[zaojiaoDic objectForKey:@"status"]]isEqualToString:@"200"])
        {
            
            NSArray * bigArr=[[NSArray alloc] initWithArray:[zaojiaoDic objectForKey:@"data"]];
            if (bigArr.count==0)
            {
                NSString * str=@"暂无物流信息，请耐心等待...";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
            else
            {
                for (int i=0; i<bigArr.count; i++)
                {
                    JTSortModel * model=[[JTSortModel alloc] init];
                    model.title=[[bigArr objectAtIndex:i] objectForKey:@"context"];
                    model.registTime=[[bigArr objectAtIndex:i] objectForKey:@"time"];
                    [_listModelArr addObject:model];
                    
                }

            }
            
            
        }
        else
        {
            if([[zaojiaoDic objectForKey:@"message"] isEqualToString:@""]||[zaojiaoDic objectForKey:@"message"]==nil)
            {
                NSString * str=@"物流信息获取失败，请稍后重试...";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
            else
            {
                NSString * str=[zaojiaoDic objectForKey:@"message"];
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
  
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
