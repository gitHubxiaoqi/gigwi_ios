//
//  JTMainTableViewCell.m
//  GiGWi
//
//  Created by 小七 on 15-4-22.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTMainTableViewCell.h"

@implementation JTMainTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        CGRect rect=self.frame;
        rect.size.width=[UIScreen mainScreen].bounds.size.width;
        self.frame=rect;
    
        self.btn1=[UIButton buttonWithType:UIButtonTypeCustom];
        self.btn1.frame=CGRectMake(10, 5, (SCREEN_WIDTH-30)/2.0,  (SCREEN_WIDTH-30)/2.0);
        [self addSubview:self.btn1];
        
        
        self.imgView1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.btn1.frame), CGRectGetHeight(self.btn1.frame)*3/5.0)];
        self.btn1.backgroundColor=[UIColor whiteColor];
        [self.btn1 addSubview:self.imgView1];
        
        self.titleLab1=[[UILabel alloc] initWithFrame:CGRectMake(2, CGRectGetHeight(self.imgView1.frame)+2, CGRectGetWidth(self.btn1.frame)-4,  CGRectGetHeight(self.btn1.frame)/4.0-4)];
        self.titleLab1.backgroundColor=[UIColor whiteColor];
        self.titleLab1.numberOfLines=0;
        self.titleLab1.textColor=[UIColor grayColor];
        self.titleLab1.font=[UIFont systemFontOfSize:13];
        [self.btn1 addSubview:self.titleLab1];
        
        UILabel * lineLab1=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.imgView1.frame)+2+CGRectGetHeight(self.titleLab1.frame)+2+1, CGRectGetWidth(self.btn1.frame), 0.5)];
        lineLab1.backgroundColor=[UIColor lightGrayColor];
        [self.btn1 addSubview:lineLab1];
        
        self.priceLab1=[[UILabel alloc] initWithFrame:CGRectMake(2, CGRectGetHeight(self.imgView1.frame)+2+CGRectGetHeight(self.titleLab1.frame)+2+2,60,  CGRectGetHeight(self.btn1.frame)*3/20.0-4)];
        self.priceLab1.backgroundColor=[UIColor whiteColor];
        self.priceLab1.textColor=NAV_COLOR;
        self.priceLab1.font=[UIFont systemFontOfSize:13];
        [self.btn1 addSubview:self.priceLab1];

        self.countLab1=[[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetHeight(self.imgView1.frame)+2+CGRectGetHeight(self.titleLab1.frame)+2+2,  CGRectGetWidth(self.btn1.frame)-67,  CGRectGetHeight(self.btn1.frame)*3/20.0-4)];
        self.countLab1.backgroundColor=[UIColor whiteColor];
        self.countLab1.textColor=[UIColor lightGrayColor];
        self.countLab1.textAlignment=NSTextAlignmentRight;
        self.countLab1.font=[UIFont systemFontOfSize:13];
        [self.btn1 addSubview:self.countLab1];
      
        //右侧
        
        self.btn2=[UIButton buttonWithType:UIButtonTypeCustom];
        self.btn2.frame=CGRectMake(20+(SCREEN_WIDTH-30)/2.0, 5, (SCREEN_WIDTH-30)/2.0,  (SCREEN_WIDTH-30)/2.0);
        self.btn2.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.btn2];
        
        
        self.imgView2=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.btn2.frame), CGRectGetHeight(self.btn2.frame)*3/5.0)];
        [self.btn2 addSubview:self.imgView2];
        
        self.titleLab2=[[UILabel alloc] initWithFrame:CGRectMake(2, CGRectGetHeight(self.imgView2.frame)+2, CGRectGetWidth(self.btn2.frame)-4,  CGRectGetHeight(self.btn2.frame)/4.0-4)];
        self.titleLab2.backgroundColor=[UIColor whiteColor];
        self.titleLab2.numberOfLines=0;
        self.titleLab2.textColor=[UIColor grayColor];
        self.titleLab2.font=[UIFont systemFontOfSize:13];
        [self.btn2 addSubview:self.titleLab2];
        
        UILabel * lineLab2=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.imgView2.frame)+2+CGRectGetHeight(self.titleLab2.frame)+2+1, CGRectGetWidth(self.btn2.frame), 0.5)];
        lineLab2.backgroundColor=[UIColor lightGrayColor];
        [self.btn2 addSubview:lineLab2];
        
        self.priceLab2=[[UILabel alloc] initWithFrame:CGRectMake(2, CGRectGetHeight(self.imgView2.frame)+2+CGRectGetHeight(self.titleLab2.frame)+2+2, 60,  CGRectGetHeight(self.btn2.frame)*3/20.0-4)];
        self.priceLab2.backgroundColor=[UIColor whiteColor];
        self.priceLab2.textColor=NAV_COLOR;
        self.priceLab2.font=[UIFont systemFontOfSize:13];
        [self.btn2 addSubview:self.priceLab2];
        
        self.countLab2=[[UILabel alloc] initWithFrame:CGRectMake(65, CGRectGetHeight(self.imgView2.frame)+2+CGRectGetHeight(self.titleLab2.frame)+2+2,  CGRectGetWidth(self.btn2.frame)-67,  CGRectGetHeight(self.btn2.frame)*3/20.0-4)];
        self.countLab2.backgroundColor=[UIColor whiteColor];
        self.countLab2.textColor=[UIColor lightGrayColor];
        self.countLab2.textAlignment=NSTextAlignmentRight;
        self.countLab2.font=[UIFont systemFontOfSize:13];
        [self.btn2 addSubview:self.countLab2];
        
        
        self.bounds=CGRectMake(0, 0, self.bounds.size.width,10+(SCREEN_WIDTH-30)/2.0);
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
