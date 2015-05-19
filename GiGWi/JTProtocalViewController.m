//
//  JTProtocalViewController.m
//  Qyli
//
//  Created by 小七 on 14-10-9.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import "JTProtocalViewController.h"

@interface JTProtocalViewController ()

@end

@implementation JTProtocalViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    navTitailLab.text=@"服务条款";
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
    
    //背景滚动视图
   UIScrollView * bigScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    [self.view addSubview:bigScrollView];
    
    //服务条款
    UILabel * lab=[[UILabel alloc] initWithFrame:CGRectMake(10,0, self.view.frame.size.width-20, self.view.frame.size.height-84)];
    lab.text=@"                       清一丽用户注册协议\n官方网站法律公告\n声明：使用本网站前请您务必仔细阅读以下条款。一旦使用本网站则表明您已明知并接受这些条款。\n1、网站使用\n    网站（以下简称\"本站\"）上的内容，仅供您个人而非商业用途的使用。对于内容中所含的版权和其他所有权声明，您应予以尊重并合法使用。如果网站内容无权利声明，并不代表网站对其不享有权利，也不意味着网站不主张权利，您应根据诚信原则尊重该等内容的合法权益并进行合法使用。您不得以任何方式修改、复制、公开展示、公布或分发这些材料或者以其他方式把它们用于任何公开或商业目的。禁止以任何目的把这些材料用于其他任何网站或其他平面媒体或网络计算机环境。本站上的内容及编辑等形式均受版权法等法律保护，任何未经授权而使用本网站材料的行为都可能构成对版权和其他法律权利的侵犯。\n    清一丽转载的或者任何第三方通过清一丽平台发布的信息或内容，并不代表清一丽之意见及观点，也不意味着本网赞同其观点或证实其内容的真实。\n2、信息发布\n    本站的信息按原样提供，不附加任何形式的保证，包括适销性、适合于特定目的、没有计算机病毒或不侵犯知识产权的保证。此外，清一丽也不保证本站信息的准确性、充分性、可靠性和完整性。\n3、关于用户提交材料\n    除个人识别信息，其他任何您发送或邮寄给本站的材料、信息或联系方式(以下统称信息)均将被视为非保密和非专有的。清一丽将对这些信息不承担任何义务。同时您的提交行为如果没有特别声明时，可视为同意（或授权）：清一丽及其授权人可以因商业或非商业的目的自由复制、透露、分发、合并和以其他方式利用这些信息和所有数据、图像、声音、文本及其他内容。您对本站的使用不得违背法律法规及公众道德，不得向或从本站邮寄或发送任何非法、威胁、诽谤、中伤、淫秽、色情、危及国家和/或公共安全或其他可能违法的材料。若相关人对此信息的内容及影响提出确有证据的警告或异议，本站可随时删除该等信息或无限时中止该信息的网上浏览，而不必事先取得提交者的同意，亦无义务事后通知提交者，情况严重的，本站可采取注销该用户的措施。您提交给清一丽的用于接收产品或服务的个人识别信息将按照清一丽的隐私保护条款进行使用或处理。\n4、用户交流内容\n    清一丽不负责监控或审查用户在本站上发送或邮寄的信息或相互之间单独交流的任何领域中的信息，包括但不限于留言、点评或其他用户论坛以及任何交流内容。清一丽对有关任何这类交流的内容不承担任何责任，无论它们是否会引起诽谤、隐私、淫秽或其它方面的问题。清一丽保留在发现时删除此类信息或包含其它不良内容的信息的权利。\n5、链接第三方网站\n    本站到第三方网站的链接仅作为一种方便服务提供给您。如果使用这些链接，您将离开本站。清一丽没有审查过任何第三方网站，对这些网站及其内容不进行控制，也不负任何责任。如果您决定访问任何与本站链接的第三方网站，其可能带来的结果和风险全部由您自己承担。\n6、责任限度\n    清一丽及其供应商或本站中提到的第三方对任何损害不承担责任（包括但不限于基于任何原因发生的利润的损失、数据丢失、间接损失、附带损失或业务中断而造成的损害），无论这些损害是否由于使用、或不能使用本站的结果、与本站链接的任何网站或者任何这类网站中包含的信息所引起，也不管它们是否有保证、合同、侵权行为或任何其它法律根据以及事前已得到这类损害可能发生的忠告。如果您由于使用本站的信息而导致需要对产品进行维护、修理或纠正，您须自行承担由此而造成的所有费用。\n7、一般原则\n    清一丽可能随时修改这些条款。您应经常访问本页面以了解当前的条款，因为这些条款与您密切相关。这些条款的某些条文也可能被本站中某些页面上明确指定的法律通告或条款所取代，您应该了解这些内容，一旦接受本条款，即意味着您已经同时详细阅读并接受了这些被引用或取代的条款。\n8、因本公告或使用本网站所发生的争议适用中华人民共和国法律。\n9、因本公告或使用本网站发生争议，应当协商解决，协商不成的，各方一致同意由法院诉讼解决。";
    lab.numberOfLines=0;
    lab.font=[UIFont systemFontOfSize:14];
    lab.textColor=[UIColor lightGrayColor];
    [bigScrollView addSubview:lab];
    
    
    CGSize autosize=[lab.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lab.font} context:nil].size;
    lab.frame=CGRectMake(10,0, self.view.frame.size.width-20, autosize.height+30);
    bigScrollView.contentSize=CGSizeMake(self.view.frame.size.width,autosize.height+30);
}
-(void)leftBtnCilck
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
