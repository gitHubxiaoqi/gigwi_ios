//
//  JTGouwucheViewController.m
//  GiGWi
//
//  Created by 小七 on 15-4-23.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTGouwucheViewController.h"
#import "JTGouwucheTableViewCell.h"
#import "JTDetailViewController.h"
#import "JTQuerenDingdanViewController.h"

@interface JTGouwucheViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView * _tableView;
    UIView * _bottomView;
    
    int q;
    int pageNum;
    NSMutableArray * _listModelArr;
    
    UIButton * _quanxuanBtn;
    UIButton * _jiesuanBtn;
    UILabel * _totalLab;
    
    float _totalPrice;
    
    NSMutableArray * _boolArr;
}

@end

@implementation JTGouwucheViewController
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
        _totalPrice=0.00;
        _totalLab.text=[NSString stringWithFormat:@"￥%.2f",_totalPrice];
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
    _totalPrice=0.00;
    _boolArr=[[NSMutableArray alloc] initWithCapacity:0];
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
    navTitailLab.text=@"购物车";
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
    
    
//    UIButton * rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame=CGRectMake(self.view.frame.size.width-70-6, 0, 70, 44);
//    [rightBtn setTitle:@"| 清空" forState:UIControlStateNormal];
//    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    rightBtn.titleLabel.font=[UIFont systemFontOfSize:18];
//    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [navLab addSubview:rightBtn];
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,20+NAV_HEIGHT, self.view.frame.size.width, self.view.frame.size.height-20-NAV_HEIGHT-60) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [_tableView addHeaderWithTarget:self action:@selector(CompanyListHeaderRefreshing)];
    [_tableView addFooterWithTarget:self  action:@selector(footerRefresh)];
    _tableView.headerRefreshingText =@HeaderRefreshingText;
    _tableView.footerRefreshingText=@FooterRefreshingText;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    _bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width, 60)];
    _bottomView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_bottomView];
    
    _quanxuanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_quanxuanBtn setImage:[UIImage imageNamed:@"选择框.png"] forState:UIControlStateNormal];
    [_quanxuanBtn setImage:[UIImage imageNamed:@"选中背景框.png"] forState:UIControlStateSelected];
    _quanxuanBtn.frame=CGRectMake(20, 10, 40, 40);
    [_quanxuanBtn addTarget:self action:@selector(quanxuan:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_quanxuanBtn];
    
    UILabel * quanxuanLab=[[UILabel alloc] initWithFrame:CGRectMake(70, 20, 30, 20)];
    quanxuanLab.font=[UIFont systemFontOfSize:13];
    quanxuanLab.text=@"全选";
    quanxuanLab.textColor=[UIColor grayColor];
    [_bottomView addSubview:quanxuanLab];
    
    UILabel * totalLab1=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-190, 10, 30, 20)];
    totalLab1.font=[UIFont systemFontOfSize:13];
    totalLab1.textColor=[UIColor grayColor];
    totalLab1.textAlignment=NSTextAlignmentRight;
    totalLab1.tag=50;
    totalLab1.text=@"合计:";
    [_bottomView addSubview:totalLab1];
    
    _totalLab=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-160, 10, 60, 20)];
    _totalLab.font=[UIFont systemFontOfSize:18];
    _totalLab.textColor=NAV_COLOR;
    _totalLab.textAlignment=NSTextAlignmentRight;
    _totalLab.text=[NSString stringWithFormat:@"￥%.2f",_totalPrice];
    [_bottomView addSubview:_totalLab];
   
    UILabel * totalLab2=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-180, 30, 80, 20)];
    totalLab2.font=[UIFont systemFontOfSize:13];
    totalLab2.textColor=[UIColor grayColor];
    totalLab2.textAlignment=NSTextAlignmentRight;
    totalLab2.text=@"不含运费";
    [_bottomView addSubview:totalLab2];
    
    _jiesuanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _jiesuanBtn.frame=CGRectMake(SCREEN_WIDTH-90, 10, 80, 40);
    _jiesuanBtn.backgroundColor=NAV_COLOR;
    [_jiesuanBtn setTitle:@"结算" forState:UIControlStateNormal];
    [_jiesuanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _jiesuanBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [_jiesuanBtn addTarget:self action:@selector(jiesuan) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_jiesuanBtn];
    
}
-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
//-(void)rightBtnClick
//{
//    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定要清空购物车吗?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//    [alertView show];
//}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex==0)
//    {
//        [_listModelArr removeAllObjects];
//        [_tableView reloadData];
//        _bottomView.hidden=YES;
//        NSString * str=@"购物车已清空，快去看看要买些什么吧。。。";
//        [JTAlertViewAnimation startAnimation:str view:self.view];
//    }
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    JTSortModel * model=[[JTSortModel alloc] init];
    model=[_listModelArr objectAtIndex:indexPath.row];
    NSArray * arr=[model.propertyStr componentsSeparatedByString:@";"];
    if (arr.count==0)
    {
        return 120;
    }
    else
    {

        if ([[arr objectAtIndex:arr.count-1] isEqualToString:@""]||[arr objectAtIndex:arr.count-1]==nil)
        {
            return 100+17*(arr.count-1);
        }
        else
        {
            return 100+17*arr.count;
        }

    }

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _listModelArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JTGouwucheTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[JTGouwucheTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor=[UIColor clearColor];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    JTSortModel * model=[[JTSortModel alloc] init];
    model=[_listModelArr objectAtIndex:indexPath.row];
    
    [cell.chooseBtn setImage:[UIImage imageNamed:@"选择框.png"] forState:UIControlStateNormal];
    [cell.chooseBtn setImage:[UIImage imageNamed:@"选中背景框.png"] forState:UIControlStateSelected];
    [cell.chooseBtn addTarget: self action:@selector(chooseShangpin:) forControlEvents:UIControlEventTouchUpInside];
    cell.chooseBtn.tag=10000+indexPath.row;
    if ([[_boolArr objectAtIndex:indexPath.row] isEqualToString:@"1"])
    {
        cell.chooseBtn.selected=YES;
    }
    else if ([[_boolArr objectAtIndex:indexPath.row] isEqualToString:@"0"])
    {
        cell.chooseBtn.selected=NO;
    }
    
    [cell.imgView setImageWithURL:[NSURL URLWithString:model.imgUrlStr] placeholderImage:[UIImage imageNamed:@"adapter_default_icon"]];
    
    cell.titleLab.text=model.title;
    cell.priceLab.text=[NSString stringWithFormat:@"￥%.2f",[model.cost floatValue]];
    NSArray * arr=[model.propertyStr componentsSeparatedByString:@";"];
    if (arr.count==0)
    {
         cell.yanseLab.text=@"";
    }
    else
    {
        NSMutableString * str=[[NSMutableString alloc] init];
        [str setString:@""];
        for (int i=0; i<arr.count; i++)
        {
            if ([[arr objectAtIndex:arr.count-1] isEqualToString:@""]||[arr objectAtIndex:arr.count-1]==nil)
            {
                 if(i<arr.count-1)
                 {
                     [str appendString:[NSString stringWithFormat:@"%@\n",[arr objectAtIndex:i]]];
                 }
                cell.yanseLab.frame=CGRectMake(125, 80, SCREEN_WIDTH-100-125, 17*(arr.count-1));
                cell.clickBtn.frame=CGRectMake(50, 0, SCREEN_WIDTH-100-50, 90+17*(arr.count-1));
                cell.bgView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 100+17*(arr.count-1)-10);
                cell.bounds=CGRectMake(0, 0, SCREEN_WIDTH, 100+17*(arr.count-1));
            }
            else
            {
                [str appendString:[NSString stringWithFormat:@"%@\n",[arr objectAtIndex:i]]];
                cell.yanseLab.frame=CGRectMake(125, 80, SCREEN_WIDTH-100-125, 17*arr.count);
                cell.clickBtn.frame=CGRectMake(50, 0, SCREEN_WIDTH-100-50, 90+17*arr.count);
                cell.bgView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 100+17*arr.count-10);
                cell.bounds=CGRectMake(0, 0, SCREEN_WIDTH, 100+17*arr.count);
            }
        }
        [str deleteCharactersInRange:NSMakeRange(str.length-1, 1)];
        cell.yanseLab.text=str;
    }

    [cell.clickBtn addTarget:self action:@selector(detail:) forControlEvents:UIControlEventTouchUpInside];
    cell.clickBtn.tag=40000+indexPath.row;
    
    cell.countLab.text=[NSString stringWithFormat:@"%@",model.goumaiNum];

    [cell.jianBtn addTarget:self action:@selector(jian:) forControlEvents:UIControlEventTouchUpInside];
    cell.jianBtn.tag=20000+indexPath.row;
    [cell.jiaBtn addTarget:self action:@selector(jia:) forControlEvents:UIControlEventTouchUpInside];
    cell.jiaBtn.tag=30000+indexPath.row;
    
    NSString * totalPrice=[NSString stringWithFormat:@"%.2f",[model.cost doubleValue]*[model.goumaiNum intValue]];
    cell.totalLab.text=[NSString stringWithFormat:@"小计:￥%@",totalPrice];
    
    return cell;
}
-(void)detail:(UIButton *)sender
{
    JTDetailViewController * detailVC=[[JTDetailViewController alloc] init];
    JTSortModel * model=[[JTSortModel alloc] init];
    model=[_listModelArr objectAtIndex:sender.tag-40000];
    detailVC.idStr=model.goodsId;
    detailVC.gouWuCheVC=self;
    [self.navigationController pushViewController:detailVC animated:YES];

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
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:model.idStr,@"id", nil];
        
        NSDictionary * editUserDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Cart_Delete] jsonDic:jsondic]];
        
        if ([[editUserDic objectForKey:@"resultCode"] intValue]==1000)
        {
            UIButton * chooseBtn=(UIButton *)[_tableView viewWithTag:10000+indexPath.row];
            if (chooseBtn.selected==YES)
            {
                JTSortModel * model=[[JTSortModel alloc] init];
                model=[_listModelArr objectAtIndex:indexPath.row];
                //JTGouwucheTableViewCell * cell=(JTGouwucheTableViewCell *)[_tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:indexPath.row inSection:0]];
                
                NSString * totalPrice=[NSString stringWithFormat:@"%.2f",[model.cost doubleValue]*[model.goumaiNum intValue]];
                _totalPrice-=[totalPrice floatValue];
                
                _totalLab.text=[NSString stringWithFormat:@"￥%.2f",_totalPrice];
                UILabel * totalLab1=(UILabel *)[_bottomView viewWithTag:50];
                CGSize autoSize=[_totalLab.text boundingRectWithSize:CGSizeMake(120, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_totalLab.font} context:nil].size;
                if (autoSize.width<60)
                {
                    autoSize.width=60;
                }
                _totalLab.frame=CGRectMake(SCREEN_WIDTH-100-autoSize.width, 10, autoSize.width, 20);
                totalLab1.frame=CGRectMake(SCREEN_WIDTH-100-autoSize.width-30, 10, 30, 20);
            }
            [_boolArr removeObjectAtIndex:indexPath.row];
            
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

-(void)chooseShangpin:(UIButton *)sender
{
    int count=(int)sender.tag-10000;
    JTSortModel * model=[[JTSortModel alloc] init];
    model=[_listModelArr objectAtIndex:count];
    JTGouwucheTableViewCell * cell=(JTGouwucheTableViewCell *)[_tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:count inSection:0]];
    
    NSString * totalPrice=[NSString stringWithFormat:@"%.2f",[model.cost doubleValue]*[model.goumaiNum intValue]];
    if (cell.chooseBtn.selected==YES)
    {
        [_boolArr replaceObjectAtIndex:count withObject:@"0"];
        cell.chooseBtn.selected=NO;
        _totalPrice-=[totalPrice floatValue];
    
    }
    else
    {
        [_boolArr replaceObjectAtIndex:count withObject:@"1"];
        cell.chooseBtn.selected=YES;
        _totalPrice+=[totalPrice floatValue];
    }
    
    _totalLab.text=[NSString stringWithFormat:@"￥%.2f",_totalPrice];
    UILabel * totalLab1=(UILabel *)[_bottomView viewWithTag:50];
    CGSize autoSize=[_totalLab.text boundingRectWithSize:CGSizeMake(120, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_totalLab.font} context:nil].size;
    if (autoSize.width<60)
    {
        autoSize.width=60;
    }
    _totalLab.frame=CGRectMake(SCREEN_WIDTH-100-autoSize.width, 10, autoSize.width, 20);
    totalLab1.frame=CGRectMake(SCREEN_WIDTH-100-autoSize.width-30, 10, 30, 20);
  //判断是否全选
    NSString * quanxuanStr=@"1";
    
    for (int i=0; i<_listModelArr.count; i++)
    {
        UIButton * chooseBtn=(UIButton *)[_tableView viewWithTag:10000+i];
        if (chooseBtn.selected==YES)
        {
        }
        else
        {
            quanxuanStr=@"0";
            break;
        }
    }
    if ([quanxuanStr isEqualToString:@"0"])
    {
        _quanxuanBtn.selected=NO;
    }
    else if ([quanxuanStr isEqualToString:@"1"])
    {
        _quanxuanBtn.selected=YES;
    }

}
-(void)jian:(UIButton *)sender
{
    
     int count=(int)sender.tag-20000;
    
    JTSortModel * model=[[JTSortModel alloc] init];
    model=[_listModelArr objectAtIndex:count];
    
   
    JTGouwucheTableViewCell * cell=(JTGouwucheTableViewCell *)[_tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:count inSection:0]];
    if ([cell.countLab.text intValue]>1)
    {
        if ([SOAPRequest checkNet])
        {
            NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:model.idStr,@"id",[NSString stringWithFormat:@"%d",[cell.countLab.text intValue]-1],@"count", nil];
            
            NSDictionary * editUserDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Cart_ChangeCount] jsonDic:jsondic]];
            
            if ([[editUserDic objectForKey:@"resultCode"] intValue]==1000)
            {
                cell.countLab.text=[NSString stringWithFormat:@"%d",[cell.countLab.text intValue]-1];
                model.goumaiNum=cell.countLab.text;
                NSString * totalPrice=[NSString stringWithFormat:@"%.2f",[model.cost doubleValue]*[cell.countLab.text intValue]];
                cell.totalLab.text=[NSString stringWithFormat:@"小计:￥%@",totalPrice];
                
                
                UIButton * chooseBtn=(UIButton *)[_tableView viewWithTag:10000+count];
                if (chooseBtn.selected==YES)
                {
                    _totalPrice-=[model.cost floatValue];
                    _totalLab.text=[NSString stringWithFormat:@"￥%.2f",_totalPrice];
                    UILabel * totalLab1=(UILabel *)[_bottomView viewWithTag:50];
                    CGSize autoSize=[_totalLab.text boundingRectWithSize:CGSizeMake(120, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_totalLab.font} context:nil].size;
                    if (autoSize.width<60)
                    {
                        autoSize.width=60;
                    }
                    _totalLab.frame=CGRectMake(SCREEN_WIDTH-100-autoSize.width, 10, autoSize.width, 20);
                    totalLab1.frame=CGRectMake(SCREEN_WIDTH-100-autoSize.width-30, 10, 30, 20);
                }
                
            }
            else
            {
                NSString * str=@"服务器异常，请稍后重试...";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
        }
    }
}
-(void)jia:(UIButton *)sender
{
    int count=(int)sender.tag-30000;
    
    JTSortModel * model=[[JTSortModel alloc] init];
    model=[_listModelArr objectAtIndex:count];

    JTGouwucheTableViewCell * cell=(JTGouwucheTableViewCell *)[_tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:count inSection:0]];
    if ([SOAPRequest checkNet])
    {
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:model.idStr,@"id",[NSString stringWithFormat:@"%d",[cell.countLab.text intValue]+1],@"count", nil];
        
        NSDictionary * editUserDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Cart_ChangeCount] jsonDic:jsondic]];
        
        if ([[editUserDic objectForKey:@"resultCode"] intValue]==1000)
        {
            cell.countLab.text=[NSString stringWithFormat:@"%d",[cell.countLab.text intValue]+1];
            model.goumaiNum=cell.countLab.text;
            
            NSString * totalPrice=[NSString stringWithFormat:@"%.2f",[model.cost doubleValue]*[cell.countLab.text intValue]];
            cell.totalLab.text=[NSString stringWithFormat:@"小计:￥%@",totalPrice];
            
            UIButton * chooseBtn=(UIButton *)[_tableView viewWithTag:10000+count];
            if (chooseBtn.selected==YES)
            {
                _totalPrice+=[model.cost floatValue];
                _totalLab.text=[NSString stringWithFormat:@"￥%.2f",_totalPrice];
                UILabel * totalLab1=(UILabel *)[_bottomView viewWithTag:50];
                CGSize autoSize=[_totalLab.text boundingRectWithSize:CGSizeMake(120, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_totalLab.font} context:nil].size;
                if (autoSize.width<60)
                {
                    autoSize.width=60;
                }
                _totalLab.frame=CGRectMake(SCREEN_WIDTH-100-autoSize.width, 10, autoSize.width, 20);
                totalLab1.frame=CGRectMake(SCREEN_WIDTH-100-autoSize.width-30, 10, 30, 20);
            }

            
        }
        else
        {
            NSString * str=@"服务器异常，请稍后重试...";
            [JTAlertViewAnimation startAnimation:str view:self.view];
        }
    }
}
-(void)quanxuan:(UIButton *)sender
{
    _totalPrice=0.00;
 
    if (sender.selected==YES)
    {
        sender.selected=NO;
        for (int i=0; i<_listModelArr.count; i++)
        {
            UIButton * chooseBtn=(UIButton *)[_tableView viewWithTag:10000+i];
            chooseBtn.selected=NO;
            [_boolArr replaceObjectAtIndex:i withObject:@"0"];
        }
    }
    else
    {
        sender.selected=YES;
        
        for (int i=0; i<_listModelArr.count; i++)
        {
            JTSortModel * model=[[JTSortModel alloc] init];
            model=[_listModelArr objectAtIndex:i];
           // JTGouwucheTableViewCell * cell=(JTGouwucheTableViewCell *)[_tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:i inSection:0]];
            NSString * totalPrice=[NSString stringWithFormat:@"%.2f",[model.cost doubleValue]*[model.goumaiNum intValue]];
            UIButton * chooseBtn=(UIButton *)[_tableView viewWithTag:10000+i];
            chooseBtn.selected=YES;
            _totalPrice+=[totalPrice floatValue];
            [_boolArr replaceObjectAtIndex:i withObject:@"1"];
        }
    }
    
    _totalLab.text=[NSString stringWithFormat:@"￥%.2f",_totalPrice];
    UILabel * totalLab1=(UILabel *)[_bottomView viewWithTag:50];
    CGSize autoSize=[_totalLab.text boundingRectWithSize:CGSizeMake(120, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_totalLab.font} context:nil].size;
    if (autoSize.width<60)
    {
        autoSize.width=60;
    }
    _totalLab.frame=CGRectMake(SCREEN_WIDTH-100-autoSize.width, 10, autoSize.width, 20);
    totalLab1.frame=CGRectMake(SCREEN_WIDTH-100-autoSize.width-30, 10, 30, 20);
}
-(void)jiesuan
{
    
    NSLog(@"去结算");
    
    NSMutableArray * seletModelArr=[[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray * countArr=[[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i=0; i<_listModelArr.count; i++)
    {
        // JTGouwucheTableViewCell * cell=(JTGouwucheTableViewCell *)[_tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:i inSection:0]];
        JTSortModel * model=[[JTSortModel alloc] init];
        model=[_listModelArr objectAtIndex:i];
        
        UIButton * chooseBtn=(UIButton *)[_tableView viewWithTag:10000+i];
        if (chooseBtn.selected==YES)
        {
            [countArr addObject:model.goumaiNum];
            [seletModelArr addObject:model];
        }
    }
    
    if (countArr.count==0)
    {
        UIAlertView * aletView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您尚未选择任何商品哦！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aletView show];
        return;
    }
    
    JTQuerenDingdanViewController * querenVC=[[JTQuerenDingdanViewController alloc] init];
    querenVC.totalPrice=_totalPrice;
    querenVC.listModelArr=[[NSArray alloc] initWithArray:seletModelArr];
    querenVC.countArr=[[NSArray alloc] initWithArray:countArr];
    querenVC.gouWuCheVC=self;
    [self.navigationController pushViewController:querenVC animated:YES];
}
-(void)sendPost
{
    pageNum=1;
    [_listModelArr removeAllObjects];
    [_boolArr removeAllObjects];
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
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"pageNum",@"20",@"pageSize",[NSString stringWithFormat:@"%d",appdelegate.appUser.userID],@"userId", nil];
        
        NSDictionary * zaojiaoListDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Cart_Page] jsonDic:jsondic]];
        
        if ([[NSString stringWithFormat:@"%@",[zaojiaoListDic objectForKey:@"resultCode"]] isEqualToString:@"1000"])
        {
            if (q==3)
            {
                if ([[zaojiaoListDic objectForKey:@"total"] intValue]==0)
                {
                    NSString * str=@"您尚未添加任何商品到购物车！";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                    return;
                }
                NSArray * zaojiaoListArr=[zaojiaoListDic objectForKey:@"page"];
                for (int i=0; i<zaojiaoListArr.count; i++)
                {
                    
                    JTSortModel * sortModel=[[JTSortModel alloc] init];
                    sortModel.idStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                    sortModel.imgUrlStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"imgUrl"];
                    sortModel.goumaiNum=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"count"];
                    sortModel.title=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"goodsName"];
                    sortModel.cost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"unitPrice"];
                    sortModel.youhuiCost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"straightPrice"];
                    sortModel.goodsId=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"goodsId"];
                    sortModel.propertyStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"property"];
                    
                    [_listModelArr addObject:sortModel];
                    [_boolArr addObject:@"0"];
                    
                }
                q=6;
            }
            else
            {
                pageNum=1;
                [_listModelArr removeAllObjects];

                if ([[zaojiaoListDic objectForKey:@"total"] intValue]==0)
                {
                    NSString * str=@"您尚未添加任何商品到购物车！";
                    [JTAlertViewAnimation startAnimation:str view:self.view];
                    return;
                }
                NSArray * zaojiaoListArr=[zaojiaoListDic objectForKey:@"page"];
                for (int i=0; i<zaojiaoListArr.count; i++)
                {
                    JTSortModel * sortModel=[[JTSortModel alloc] init];
                    sortModel.idStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                    sortModel.imgUrlStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"imgUrl"];
                    sortModel.goumaiNum=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"count"];
                    sortModel.title=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"goodsName"];
                    sortModel.cost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"unitPrice"];
                    sortModel.youhuiCost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"straightPrice"];
                    sortModel.goodsId=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"goodsId"];
                    sortModel.propertyStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"property"];
                    
                    [_listModelArr addObject:sortModel];
                    [_boolArr addObject:@"0"];
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
        
        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",pageNum],@"pageNum",@"20",@"pageSize",[NSString stringWithFormat:@"%d",appdelegate.appUser.userID],@"userId", nil];
        
        NSDictionary * zaojiaoListDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_Cart_Page] jsonDic:jsondic]];
        
        if ([[zaojiaoListDic objectForKey:@"resultCode"] intValue]==1000)
        {
            if ([[zaojiaoListDic objectForKey:@"page"]count]==0)
            {
                NSString * str=@"已全部加载完毕！";
                [JTAlertViewAnimation startAnimation:str view:self.view];
                pageNum--;
                return;
            }
            NSArray * zaojiaoListArr=[zaojiaoListDic objectForKey:@"page"];
            for (int i=0; i<zaojiaoListArr.count; i++)
            {
                JTSortModel * sortModel=[[JTSortModel alloc] init];
                sortModel.idStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"id"];
                sortModel.imgUrlStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"imgUrl"];
                sortModel.goumaiNum=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"count"];
                sortModel.title=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"goodsName"];
                sortModel.cost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"unitPrice"];
                sortModel.youhuiCost=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"straightPrice"];
                sortModel.goodsId=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"goodsId"];
                sortModel.propertyStr=[[zaojiaoListArr objectAtIndex:i] objectForKey:@"property"];
                
                [_listModelArr addObject:sortModel];
                [_boolArr addObject:@"0"];
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
