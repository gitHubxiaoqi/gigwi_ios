//
//  JTAdressListTableViewCell.m
//  GiGWi
//
//  Created by 小七 on 15-4-23.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTAdressListTableViewCell.h"

@implementation JTAdressListTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        CGRect rect=self.frame;
        rect.size.width=[UIScreen mainScreen].bounds.size.width;
        self.frame=rect;
        
        UIView * bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        bgView.userInteractionEnabled=YES;
        bgView.backgroundColor=[UIColor whiteColor];
        [self addSubview:bgView];
        
        self.xiugaiBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.xiugaiBtn.frame=CGRectMake(SCREEN_WIDTH-80,0,80,120);
        [bgView addSubview:self.xiugaiBtn];
        
        UILabel * lineLab=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, 45, 0.5, 30)];
        lineLab.backgroundColor=[UIColor lightGrayColor];
        [bgView addSubview:lineLab];
        
        UIImageView * bianjiImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"修改地址图标.png"]];
        bianjiImgView.frame=CGRectMake(SCREEN_WIDTH-40, 47, 22, 25);
        [bgView addSubview:bianjiImgView];
        
        
        self.bianshiImgView=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60-60,45, 50, 30)];
        self.bianshiImgView.image=[UIImage imageNamed:@"常用地址.png"];
        [bgView addSubview:self.bianshiImgView];
        
        self.nameLab=[[UILabel alloc] initWithFrame:CGRectMake(10,10,SCREEN_WIDTH-60-60-10,20)];
        self.nameLab.textColor=[UIColor blackColor];
        self.nameLab.font=[UIFont systemFontOfSize:15];
        [bgView addSubview:self.nameLab];
        
        
        self.shenshiquLab=[[UILabel alloc] initWithFrame:CGRectMake(10,30,SCREEN_WIDTH-60-60-10,20)];
        self.shenshiquLab.textColor=[UIColor grayColor];
        self.shenshiquLab.font=[UIFont systemFontOfSize:14];
        [bgView addSubview:self.shenshiquLab];
        
        self.jiedaoLab=[[UILabel alloc] initWithFrame:CGRectMake(10,50,SCREEN_WIDTH-60-60-10,40)];
        self.jiedaoLab.textColor=[UIColor grayColor];
        self.jiedaoLab.numberOfLines=0;
        self.jiedaoLab.font=[UIFont systemFontOfSize:14];
        [bgView addSubview:self.jiedaoLab];
        
        self.telLab=[[UILabel alloc] initWithFrame:CGRectMake(10,90,SCREEN_WIDTH-60-60-10,20)];
        self.telLab.textColor=[UIColor grayColor];
        self.telLab.font=[UIFont systemFontOfSize:13];
        [bgView addSubview:self.telLab];
        
        
        self.bounds=CGRectMake(0, 0, self.bounds.size.width,130);
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
