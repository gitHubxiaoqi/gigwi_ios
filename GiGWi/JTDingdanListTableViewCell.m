//
//  JTDingdanListTableViewCell.m
//  GiGWi
//
//  Created by 小七 on 15-4-24.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTDingdanListTableViewCell.h"

@implementation JTDingdanListTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        CGRect rect=self.frame;
        rect.size.width=[UIScreen mainScreen].bounds.size.width;
        self.frame=rect;
        
        UIView * bgView1=[[UIView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH,30)];
        bgView1.userInteractionEnabled=YES;
        bgView1.backgroundColor=[UIColor whiteColor];
        [self addSubview:bgView1];
        
        self.typeLab=[[UILabel alloc] initWithFrame:CGRectMake(10,5,(SCREEN_WIDTH-20)/2.0,20)];
        self.typeLab.textColor=NAV_COLOR;
        self.typeLab.font=[UIFont systemFontOfSize:15];
        self.typeLab.textAlignment=NSTextAlignmentLeft;
        [bgView1 addSubview:self.typeLab];
        
        self.deletaBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.deletaBtn.frame=CGRectMake(SCREEN_WIDTH-100, 0, 100, 30);
        [bgView1 addSubview:self.deletaBtn];
        
        UIImageView * deletaImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"删除订单.png"]];
        deletaImgView.frame=CGRectMake(60, 2, 20, 26);
        [self.deletaBtn addSubview:deletaImgView];

        
        _bgView3=[[UIView alloc] initWithFrame:CGRectMake(0, 115, SCREEN_WIDTH,40)];
        _bgView3.userInteractionEnabled=YES;
        _bgView3.backgroundColor=[UIColor whiteColor];
        [self addSubview:_bgView3];
        
        self.totalLab=[[UILabel alloc] initWithFrame:CGRectMake(10,10,(SCREEN_WIDTH-20)/2.0,20)];
        self.totalLab.textColor=[UIColor blackColor];
        self.totalLab.textAlignment=NSTextAlignmentLeft;
        self.totalLab.font=[UIFont systemFontOfSize:14];
        [_bgView3 addSubview:self.totalLab];
        
        self.ewaiBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
        self.ewaiBtn1.frame=CGRectMake(SCREEN_WIDTH-160, 5, 70,30);
        [self.ewaiBtn1 setBackgroundImage:[UIImage imageNamed:@"选择框未选.png"] forState:UIControlStateNormal];
        [self.ewaiBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.ewaiBtn1.titleLabel.font=[UIFont systemFontOfSize:14];
        [_bgView3 addSubview:self.ewaiBtn1];
        
        self.ewaiBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
        self.ewaiBtn2.frame=CGRectMake(SCREEN_WIDTH-80, 5, 70,30);
        [self.ewaiBtn2 setBackgroundImage:[UIImage imageNamed:@"选择框已选.png"] forState:UIControlStateNormal];
        [self.ewaiBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.ewaiBtn2.titleLabel.font=[UIFont systemFontOfSize:14];
        [_bgView3 addSubview:self.ewaiBtn2];
        
        
        self.bounds=CGRectMake(0, 0, self.bounds.size.width,160);
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
