//
//  JTAdressListViewController.m
//  GiGWi
//
//  Created by 小七 on 15-4-23.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTAdressListViewController.h"
#import "JTAdressListTableViewCell.h"
#import "JTNewAdressViewController.h"

@interface JTAdressListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    int q;
    int pageNum;
    NSMutableArray * _listModelArr;

}

@end

@implementation JTAdressListViewController
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
    if (_p==1)
    {
        [self sendPost];
    }
    _p=2;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    JTAppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    appDelegate.tabBarView.hidden=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _p=1;
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
    UIView * navLab=[[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 44)];
    navLab.userInteractionEnabled=YES;
    navLab.backgroundColor=NAV_COLOR;
    [self.view addSubview:navLab];
    
    UILabel * navTitailLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    navTitailLab.text=@"选择收货地址";
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
    
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,20+NAV_HEIGHT, self.view.frame.size.width, self.view.frame.size.height-20-NAV_HEIGHT-60) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    UIView * bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width, 60)];
    bottomView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:bottomView];
    
    UILabel * lineLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, 1)];
    lineLab.backgroundColor=NAV_COLOR;
    [bottomView addSubview:lineLab];
    
    
    
   UIButton * xinjianBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    xinjianBtn.frame=CGRectMake((SCREEN_WIDTH-150)/2.0, 10, 150, 40);
    xinjianBtn.backgroundColor=NAV_COLOR;
    [xinjianBtn setTitle:@"+  新建地址" forState:UIControlStateNormal];
    [xinjianBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    xinjianBtn.titleLabel.font=[UIFont systemFontOfSize:20];
    [xinjianBtn addTarget:self action:@selector(xinjian) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:xinjianBtn];
    
}
-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)xinjian
{
    NSLog(@"新建地址");
    JTNewAdressViewController * newVC=[[JTNewAdressViewController alloc] init];
    newVC.adressListVC=self;
    [self.navigationController pushViewController:newVC animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _listModelArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JTAdressListTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[JTAdressListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor=[UIColor clearColor];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    JTSortModel * model=[[JTSortModel alloc] init];
    model=[_listModelArr objectAtIndex:indexPath.row];
    
    cell.nameLab.text=model.name;
    
    [cell.xiugaiBtn addTarget: self action:@selector(xiugaiBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.xiugaiBtn.tag=100+indexPath.row;
    
    if ([model.isChangyong intValue]==0)
    {
        cell.bianshiImgView.hidden=YES;
    }
    else
    {
        cell.bianshiImgView.hidden=NO;
    }
    if (model.provinceStr==nil)
    {
        model.provinceStr=@"";
    }
    if (model.cityStr==nil)
    {
        model.cityStr=@"";
    }
    if (model.quStr==nil)
    {
        model.quStr=@"";
    }
    if (model.street==nil)
    {
        model.street=@"";
    }
    if ([model.infoAddress isEqualToString:@""]||model.infoAddress==nil)
    {
        model.infoAddress=@"";
    }
    cell.shenshiquLab.text=[NSString stringWithFormat:@"%@  %@  %@",model.provinceStr,model.cityStr,model.quStr];
    cell.jiedaoLab.text=[NSString stringWithFormat:@"%@%@",model.street,model.infoAddress];
    cell.telLab.text=model.tel;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.querenVC!=nil)
    {
        JTSortModel * model=[[JTSortModel alloc] init];
        model=[_listModelArr objectAtIndex:indexPath.row];
        self.querenVC.adressModel=[[JTSortModel alloc] init];
        self.querenVC.adressModel=model;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(UITableViewCellEditingStyle )tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([SOAPRequest checkNet])
    {

        JTSortModel * model=[[JTSortModel alloc] init];
        model=[_listModelArr objectAtIndex:indexPath.row];
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:model.idStr,@"id",nil];
        NSDictionary * zaojiaoListDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_DeleteConsigneeAddress] jsonDic:jsondic]];
        
        if ([[NSString stringWithFormat:@"%@",[zaojiaoListDic objectForKey:@"resultCode"]] isEqualToString:@"1000"])
        {
            [_listModelArr removeObjectAtIndex:indexPath.row];
            [_tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [_tableView reloadData];
        }
        else
        {
            NSString * str=@"服务器异常，请稍后重试...";
            [JTAlertViewAnimation startAnimation:str view:self.view];
        }
    }
 
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(void)xiugaiBtn:(UIButton *)sender
{
    int count=(int)sender.tag-100;
    NSLog(@"修改第%d个",count);
    JTSortModel * model=[[JTSortModel alloc] init];
    model=[_listModelArr objectAtIndex:count];
    JTNewAdressViewController * newVC=[[JTNewAdressViewController alloc] init];
    newVC.adressModel=[[JTSortModel alloc] init];
    newVC.adressModel=model;
    newVC.adressListVC=self;
    [self.navigationController pushViewController:newVC animated:YES];
    
}
-(void)sendPost
{
    [_listModelArr removeAllObjects];
    
    
    if ([SOAPRequest checkNet])
    {
        
        JTAppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",appdelegate.appUser.userID],@"userId",nil];
        NSDictionary * zaojiaoListDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_GetConsigneeAddressList] jsonDic:jsondic]];
        
        if ([[NSString stringWithFormat:@"%@",[zaojiaoListDic objectForKey:@"resultCode"]] isEqualToString:@"1000"])
        {
            if ([[zaojiaoListDic objectForKey:@"list"] count]==0)
            {
                NSString * str=@"您尚未添加收货地址！";
                [JTAlertViewAnimation startAnimation:str view:self.view];
                return;
            }
            NSArray * zaojiaoListArr=[zaojiaoListDic objectForKey:@"list"];
            for (int i=0; i<zaojiaoListArr.count; i++)
            {
                JTSortModel * model=[[JTSortModel alloc] init];
                model.idStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                model.name=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"name"];
                model.provinceStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"provinceValue"];
                model.cityStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"cityValue"];
                model.quStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"regionValue"];
                model.street=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"streetValue"];
                model.provinceIDStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"provinceId"];
                model.cityIDStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"cityId"];
                model.quIDStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"regionId"];
                model.streetIDStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"streetId"];
                model.infoAddress=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"recipientAddress"];
                model.tel=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"phone"];
                model.isChangyong=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"status"];

                [_listModelArr addObject:model];
                
            }
        }
        else
        {
            NSString * str=@"服务器异常，请稍后重试...";
            [JTAlertViewAnimation startAnimation:str view:self.view];
        }
    }
    
        [_tableView reloadData];
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
