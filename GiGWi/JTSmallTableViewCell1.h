//
//  JTSmallTableViewCell1.h
//  GiGWi
//
//  Created by 小七 on 15-4-30.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTSmallTableViewCell1 : UIView
@property(nonatomic,strong)UIImageView * imgView;
@property(nonatomic,strong)UILabel * titleLab;
@property(nonatomic,strong)UILabel * yanseLab;
@property(nonatomic,strong)UILabel * priceLab;
@property(nonatomic,strong)UILabel * countLab;

-(void)ready:(JTSortModel *)model;
@end
