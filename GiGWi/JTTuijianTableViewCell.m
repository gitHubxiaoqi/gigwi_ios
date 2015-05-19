//
//  JTTuijianTableViewCell.m
//  GiGWi
//
//  Created by 小七 on 15-4-24.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTTuijianTableViewCell.h"

@implementation JTTuijianTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        CGRect rect=self.frame;
        rect.size.width=[UIScreen mainScreen].bounds.size.width;
        self.frame=rect;
        
        UIView * bgView1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,30)];
        bgView1.userInteractionEnabled=YES;
        bgView1.backgroundColor=[UIColor whiteColor];
        [self addSubview:bgView1];
        
        self.userNameLab=[[UILabel alloc] initWithFrame:CGRectMake(10,5,(SCREEN_WIDTH-20)/2.0,20)];
        self.userNameLab.textColor=NAV_COLOR;
        self.userNameLab.font=[UIFont systemFontOfSize:15];
        self.userNameLab.textAlignment=NSTextAlignmentLeft;
        [bgView1 addSubview:self.userNameLab];
        
        self.youhuimaNumLab=[[UILabel alloc] initWithFrame:CGRectMake(10+(SCREEN_WIDTH-20)/2.0,5,(SCREEN_WIDTH-20)/2.0,20)];
        self.youhuimaNumLab.textColor=[UIColor grayColor];
        self.youhuimaNumLab.font=[UIFont systemFontOfSize:14];
        self.youhuimaNumLab.textAlignment=NSTextAlignmentRight;
        [bgView1 addSubview:self.youhuimaNumLab];
        
        
        _bgView3=[[UIView alloc] initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH,30)];
        _bgView3.userInteractionEnabled=YES;
        _bgView3.backgroundColor=[UIColor whiteColor];
        [self addSubview:_bgView3];
        
        self.totalLab=[[UILabel alloc] initWithFrame:CGRectMake(10,5,(SCREEN_WIDTH-20)/2.0,20)];
        self.totalLab.textColor=[UIColor blackColor];
        self.totalLab.textAlignment=NSTextAlignmentLeft;
        self.totalLab.font=[UIFont systemFontOfSize:14];
        [_bgView3 addSubview:self.totalLab];
        
        self.ewaiLab=[[UILabel alloc] initWithFrame:CGRectMake(10+(SCREEN_WIDTH-20)/2.0,5,(SCREEN_WIDTH-20)/2.0,20)];
        self.ewaiLab.textColor=NAV_COLOR;
        self.ewaiLab.font=[UIFont systemFontOfSize:16];
        self.ewaiLab.textAlignment=NSTextAlignmentRight;
        [_bgView3 addSubview:self.ewaiLab];
        
        self.bounds=CGRectMake(0, 0, self.bounds.size.width,150);
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
