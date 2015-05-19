//
//  JTGouwucheTableViewCell.m
//  GiGWi
//
//  Created by 小七 on 15-4-23.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTGouwucheTableViewCell.h"

@implementation JTGouwucheTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        CGRect rect=self.frame;
        rect.size.width=[UIScreen mainScreen].bounds.size.width;
        self.frame=rect;
        
        _bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
        _bgView.userInteractionEnabled=YES;
        _bgView.backgroundColor=[UIColor whiteColor];
        [self addSubview:_bgView];
        
        self.chooseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.chooseBtn.frame=CGRectMake(10,40,30,30);
        [_bgView addSubview:self.chooseBtn];
        
        
        self.imgView=[[UIImageView alloc] initWithFrame:CGRectMake(50,10, 70, 90)];
        [_bgView addSubview:self.imgView];
        
        self.titleLab=[[UILabel alloc] initWithFrame:CGRectMake(125,10,SCREEN_WIDTH-100-125,50)];
        self.titleLab.numberOfLines=0;
        self.titleLab.textColor=[UIColor grayColor];
        self.titleLab.font=[UIFont systemFontOfSize:12];
        [_bgView addSubview:self.titleLab];
        
        
        self.priceLab=[[UILabel alloc] initWithFrame:CGRectMake(125,60,SCREEN_WIDTH-100-125,20)];
        self.priceLab.textColor=NAV_COLOR;
        self.priceLab.font=[UIFont systemFontOfSize:14];
        [_bgView addSubview:self.priceLab];
        
        self.yanseLab=[[UILabel alloc] initWithFrame:CGRectMake(125,80,SCREEN_WIDTH-100-125,20)];
        self.yanseLab.textColor=[UIColor lightGrayColor];
        self.yanseLab.font=[UIFont systemFontOfSize:14];
        self.yanseLab.numberOfLines=0;
        [_bgView addSubview:self.yanseLab];
        
        self.clickBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.clickBtn.frame=CGRectMake(50,0,SCREEN_WIDTH-100-50,110);
        [_bgView addSubview:self.clickBtn];
        
        self.jianBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.jianBtn.frame=CGRectMake(SCREEN_WIDTH-95,40,30,30);
        [self.jianBtn setImage:[UIImage imageNamed:@"减-小"] forState:UIControlStateNormal];
        [_bgView addSubview:self.jianBtn];
        
        UIImageView * countImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"购买数量框-小.png"]];
        countImgView.frame=CGRectMake(SCREEN_WIDTH-95+30,40,30,30);
        [_bgView addSubview:countImgView];
        
        self.countLab=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-95+30+2,40+2,30-4,30-4)];
        self.countLab.textColor=[UIColor blackColor];
        self.countLab.textAlignment=NSTextAlignmentCenter;
        self.countLab.font=[UIFont systemFontOfSize:18];
        [_bgView addSubview:self.countLab];
        
        self.jiaBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.jiaBtn.frame=CGRectMake(SCREEN_WIDTH-95+30+30,40,30,30);
        [self.jiaBtn setBackgroundImage:[UIImage imageNamed:@"加-大.png"] forState:UIControlStateNormal];
        [_bgView addSubview:self.jiaBtn];
        
        self.totalLab=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100,80,100,20)];
        self.totalLab.textColor=[UIColor brownColor];
        self.totalLab.textAlignment=NSTextAlignmentCenter;
        self.totalLab.font=[UIFont systemFontOfSize:13];
        [_bgView addSubview:self.totalLab];
        
        
        self.bounds=CGRectMake(0, 0, self.bounds.size.width,120);
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
