//
//  JTWuliuTableViewCell.m
//  GiGWi
//
//  Created by 小七 on 15-4-30.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import "JTWuliuTableViewCell.h"

@implementation JTWuliuTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        CGRect rect=self.frame;
        rect.size.width=[UIScreen mainScreen].bounds.size.width;
        self.frame=rect;

        self.titleLab=[[UILabel alloc] initWithFrame:CGRectMake(40,0,SCREEN_WIDTH-60,20)];
        self.titleLab.numberOfLines=0;
        self.titleLab.font=[UIFont systemFontOfSize:14];
        [self addSubview:self.titleLab];
        
        
        self.detaLab=[[UILabel alloc] initWithFrame:CGRectMake(40,20,SCREEN_WIDTH-60,20)];
        self.detaLab.textColor=[UIColor grayColor];
        self.detaLab.font=[UIFont systemFontOfSize:12];
        [self addSubview:self.detaLab];
        
        self.imgView=[[UIImageView alloc] init];
        [self addSubview:self.imgView];
        
        self.lineLab=[[UILabel alloc] initWithFrame:CGRectMake(27,10,1,40)];
        self.lineLab.backgroundColor=[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        [self addSubview:self.lineLab];

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
