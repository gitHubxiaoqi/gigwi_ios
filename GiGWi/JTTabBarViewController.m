//
//  JTTabBarViewController.m
//  GiGWi
//
//  Created by 小七 on 15-4-21.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTTabBarViewController.h"
#import "JTMainViewController.h"
#import "JTPeopleViewController.h"

@interface JTTabBarViewController ()
{
    UIView * _contentView;
    NSArray * _normalBtnImgArr;
    NSArray * _selectedBtnImgArr;
    UIButton * _selectedBtn;
    int p;
}
@property (nonatomic,strong)NSMutableArray * viewControllers;
@end

@implementation JTTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        [self readyUI];
}
-(void)readyUI
{
    p=3;
    self.view.backgroundColor=[UIColor whiteColor];
    
    _normalBtnImgArr=[[NSArray alloc] initWithObjects:[UIImage imageNamed:@"首页-1.png"],[UIImage imageNamed:@"个人中心-1.png"] ,nil];
    _selectedBtnImgArr=[[NSArray alloc] initWithObjects:[UIImage imageNamed:@"首页-2.png"],[UIImage imageNamed:@"个人中心-2.png"], nil];
    
    
    
    _contentView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _contentView.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:_contentView];
    
    JTAppDelegate * appDelegate=[UIApplication sharedApplication].delegate;
    appDelegate.tabBarView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49)];
    //appDelegate.tabBarView.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:appDelegate.tabBarView];

    
    
    _viewControllers=[[NSMutableArray alloc] initWithCapacity:2];
    
    [self putViewController:[JTMainViewController class] inArray:_viewControllers];
    [self putViewController:[JTPeopleViewController class] inArray:_viewControllers];
    
    UIButton * defaultSelectedBtn=nil;
    NSInteger count=[_viewControllers count];
    NSInteger width=self.view.frame.size.width/count;
    for (int i=0; i<count; i++)
    {
        UIButton * barBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        barBtn.tag=i+10;
        barBtn.frame=CGRectMake(width*i,0.3, width, 49);
        [barBtn setImage:[_normalBtnImgArr objectAtIndex:i] forState:UIControlStateNormal];
        [barBtn setImage:[_selectedBtnImgArr objectAtIndex:i] forState:UIControlStateSelected];
        [barBtn addTarget:self action:@selector(barBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [appDelegate.tabBarView addSubview:barBtn];
        if (i==0)
        {
            defaultSelectedBtn=barBtn;
        }
    }
    [self barBtnClick:defaultSelectedBtn];
}

-(void)barBtnClick:(UIButton *)sender
{
    if (_selectedBtn==sender)
    {
        
    }else
    {
        
        if (p==6)
        {
            UIViewController * lastContentViewController=[_viewControllers objectAtIndex:_selectedBtn.tag-10];
            [lastContentViewController.view removeFromSuperview];
        }
        if (p==3)
        {
            p=6;
            
        }
        _selectedBtn.selected=NO;
        _selectedBtn=sender;
        _selectedBtn.selected=YES;
        
        UIViewController * contentViewController=[_viewControllers objectAtIndex:sender.tag-10];
        [_contentView addSubview:contentViewController.view];
        
    }
}
- (void)putViewController:(Class)class inArray:(NSMutableArray* )array {

    UIViewController* viewController = [[class alloc] init];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [array addObject:nav];
    
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
