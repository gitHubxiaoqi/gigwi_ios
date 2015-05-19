//
//  JTSmallTableViewCell1.m
//  GiGWi
//
//  Created by 小七 on 15-4-30.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTSmallTableViewCell1.h"

@implementation JTSmallTableViewCell1


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
-(void)ready:(JTSortModel *)smallModel
{
    UIView * bgView1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,80)];
    bgView1.userInteractionEnabled=YES;
    bgView1.backgroundColor=BG_COLOR;
    [self addSubview:bgView1];
    
    
    UIView * bgView2=[[UIView alloc] initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH,78)];
    bgView2.userInteractionEnabled=YES;
    bgView2.backgroundColor=[UIColor whiteColor];
    [bgView1 addSubview:bgView2];
    
    self.imgView=[[UIImageView alloc] initWithFrame:CGRectMake(20,9, 55, 60)];
    [bgView2 addSubview:self.imgView];
    
    self.titleLab=[[UILabel alloc] initWithFrame:CGRectMake(95,10,SCREEN_WIDTH-80-95,38)];
    self.titleLab.numberOfLines=0;
    self.titleLab.textColor=[UIColor grayColor];
    self.titleLab.font=[UIFont systemFontOfSize:13];
    [bgView2 addSubview:self.titleLab];
    
    self.yanseLab=[[UILabel alloc] initWithFrame:CGRectMake(80,48,SCREEN_WIDTH-80-95,20)];
    self.yanseLab.textColor=[UIColor lightGrayColor];
    self.yanseLab.font=[UIFont systemFontOfSize:12];
    self.yanseLab.numberOfLines=0;
    self.yanseLab.text=smallModel.propertyStr;
    [bgView2 addSubview:self.yanseLab];
    
    self.priceLab=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-75,15,70,20)];
    self.priceLab.textColor=NAV_COLOR;
    self.priceLab.font=[UIFont systemFontOfSize:13];
    self.priceLab.textAlignment=NSTextAlignmentCenter;
    [bgView2 addSubview:self.priceLab];
    
    self.countLab=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-75,40,70,20)];
    self.countLab.textColor=[UIColor grayColor];
    self.countLab.textAlignment=NSTextAlignmentCenter;
    self.countLab.font=[UIFont systemFontOfSize:12];
    [bgView2 addSubview:self.countLab];
    
    
    self.bounds=CGRectMake(0, 0, self.bounds.size.width,80);
    
    self.titleLab.text=smallModel.title;
    [self.imgView setImageWithURL:[NSURL URLWithString:smallModel.imgUrlStr] placeholderImage:[UIImage imageNamed:@"adapter_default_icon.png"]];
    self.priceLab.text=[NSString stringWithFormat:@"￥%.2f",[smallModel.cost floatValue]];
    self.countLab.text=[NSString stringWithFormat:@"x  %@",smallModel.goumaiNum];
}

@end
