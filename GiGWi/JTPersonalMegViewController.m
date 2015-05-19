//
//  JTPersonalMegViewController.m
//  Qyli
//
//  Created by 小七 on 14-8-4.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import "JTPersonalMegViewController.h"
#import "JTSetNameViewController.h"
#import "JTGOChangePhoneViewController.h"
#import "JTAdressListViewController.h"

@interface JTPersonalMegViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    UITableView * _tabView;
    NSArray * _titleArr;
    
    UIImagePickerController * imagePicker;
    UIImageView * photo;
    

}

@property(nonatomic,strong)NSString * headImgData;



@end

@implementation JTPersonalMegViewController

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

    self.myUser=appDelegate.appUser;
    UITableViewCell * cell1=[_tabView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    cell1.detailTextLabel.text=appDelegate.appUser.userName;
    
    
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

    
     _titleArr=@[@"头像",@"昵称",@"手机号码认证",@"我的收货地址"];
    self.headImgData=@"";
    
    
    JTAppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    self.myUser=[[JTUser alloc] init];
    self.myUser=appDelegate.appUser;
    
    
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
    navTitailLab.text=@"个人信息";
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

    
    _tabView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 240) style:UITableViewStylePlain];
    _tabView.dataSource=self;
    _tabView.delegate=self;
    _tabView.scrollEnabled=NO;
    [self.view addSubview:_tabView];
    _tabView.separatorStyle=UITableViewCellSeparatorStyleNone;
 }


#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        JTAppDelegate * appdelegate= [UIApplication sharedApplication].delegate;
        appdelegate.tabBarView.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.view.frame.size.width, 49);
        [self presentViewController:imagePickerController animated:YES completion:^{}];

    }
    
}
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    JTAppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
    appdelegate.tabBarView.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49, self.view.frame.size.width, 49);
	[picker dismissViewControllerAnimated:YES completion:^{}];

    UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self saveImage:image withName:@"currentImage.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
   // UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    UIImage * savedImage=[NSString  fixOrientation:[[UIImage alloc] initWithContentsOfFile:fullPath]];
    //NSLog(@"^^^^^^^^^^^^^^^^^^^^^^^^^^^^%d",savedImage.imageOrientation);
    [photo setImage:savedImage];
    
   // NSData * data=UIImagePNGRepresentation(savedImage);
    NSData *data=UIImageJPEGRepresentation(savedImage, 0.0001);
    self.headImgData=[data base64EncodedString];
    
    self.headImgData = [self.headImgData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    self.headImgData = [self.headImgData stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    self.headImgData = [self.headImgData stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    [self xiugai];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissViewControllerAnimated:YES completion:^{}];
}
#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
        
    {
        return 90;
    }
    else
    {
        return 50;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return _titleArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        UIImageView *imgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"右箭头.png"]];
        if (indexPath.row==0)
        {
            imgView.frame=CGRectMake(self.view.frame.size.width-5-5, 40, 5, 10);
        }
        else
        {
            imgView.frame=CGRectMake(self.view.frame.size.width-5-5,20, 5, 10);
        }
        [cell addSubview:imgView];
        
        UILabel * lab=[[UILabel alloc] init];
        if (indexPath.row==0)
        {
            lab.frame=CGRectMake(0, 80, SCREEN_WIDTH, 10);
        }
        else
        {
        lab.frame=CGRectMake(0, 40, SCREEN_WIDTH, 10);
        }
        lab.backgroundColor=BG_COLOR;
        [cell addSubview:lab];
        
        cell.textLabel.text=[_titleArr objectAtIndex:indexPath.row];
        switch (indexPath.row)
        {
            case 0:
            {
                photo=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-60-20, 10, 60, 60)];
                [photo setImageWithURL:[NSURL URLWithString:self.myUser.headPortraitImgUrlStr] placeholderImage:[UIImage imageNamed:@"头像.png"]];
                photo.layer.masksToBounds=YES;
                photo.layer.cornerRadius=30;
                [cell addSubview:photo];
            }
                break;
            case 1:
            {
                cell.detailTextLabel.text=self.myUser.userName;
            }
                break;
            case 2:
            {
                if (self.myUser.phone)
                {
                    cell.detailTextLabel.text=self.myUser.phone;
                    
                }
                else
                {
                    cell.detailTextLabel.text=@"未认证";
                }
            }
                break;
            case 4:
            {
                
            }
                break;
            default:
                break;
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            UIActionSheet *sheet;
            
            // 判断是否支持相机
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
            }
            else {
                
                sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
            }
            
            sheet.tag = 255;
            
            [sheet showInView:self.view];
            
        }
            break;
        case 1:
        {
            JTSetNameViewController * sVC=[[JTSetNameViewController alloc] init];
            sVC.pVC=self;
            [self.navigationController pushViewController:sVC animated:YES];
        }
            break;
        case 2:
        {
            JTGOChangePhoneViewController * cPhVC=[[JTGOChangePhoneViewController alloc] init];
            cPhVC.lastVC=self;
            [self.navigationController pushViewController:cPhVC animated:YES];

        }
            break;
        case 3:
        {
            JTAdressListViewController * adressVC=[[JTAdressListViewController alloc] init];
            [self.navigationController pushViewController:adressVC animated:YES];
        }
            break;
        default:
            break;
    }

}
-(void)leftBtnCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)xiugai
{
    if ([SOAPRequest checkNet])
    {

        NSDictionary * jsondic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self.myUser.userID],@"userId",self.myUser.userName,@"nickName",_headImgData,@"headPortrait", nil];
        
        NSDictionary * editUserDic=[[NSDictionary alloc] initWithDictionary:[SOAPRequest getResponseByPostURL:[NSString stringWithFormat:@"%s%s",QYL_URL,NEW_QYL_People_SaveEditUser] jsonDic:jsondic]];
        
        if ([[editUserDic objectForKey:@"resultCode"] intValue]!=1000)
        {
            if ([editUserDic objectForKey:@"errorMessage"]!=nil)
            {
                NSString * str=[editUserDic objectForKey:@"errorMessage"];
                [JTAlertViewAnimation startAnimation:str view:self.view];
                
            }
            else
            {
                NSString * str=@"服务器异常，请稍后重试...";
                [JTAlertViewAnimation startAnimation:str view:self.view];
            }
            
        }
        else if ([[editUserDic objectForKey:@"resultCode"] intValue]==1000)
        {
            
            NSDictionary * userDic=[editUserDic objectForKey:@"user"];
            _myUser.userID=[[userDic objectForKey:@"id"] intValue];
            _myUser.loginName=[userDic objectForKey:@"loginName"];
            _myUser.password=[userDic objectForKey:@"password"];
            _myUser.userName=[userDic objectForKey:@"nickName"];
            _myUser.headPortraitImgUrlStr=[userDic objectForKey:@"imageValue"];
            _myUser.email=[userDic objectForKey:@"email"];
            _myUser.phone=[userDic objectForKey:@"phone"];
            
            JTAppDelegate * appdelegate=[UIApplication sharedApplication].delegate;
            appdelegate.appUser=self.myUser;

        }
    }
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
