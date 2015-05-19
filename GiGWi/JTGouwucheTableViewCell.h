//
//  JTGouwucheTableViewCell.h
//  GiGWi
//
//  Created by 小七 on 15-4-23.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTGouwucheTableViewCell : UITableViewCell
@property(nonatomic,strong)UIView * bgView;
@property(nonatomic,strong)UIButton * chooseBtn;

@property(nonatomic,strong)UIImageView * imgView;
@property(nonatomic,strong)UILabel * titleLab;
@property(nonatomic,strong)UILabel * priceLab;
@property(nonatomic,strong)UILabel * yanseLab;

@property(nonatomic,strong)UIButton * clickBtn;


@property(nonatomic,strong)UIButton * jianBtn;
@property(nonatomic,strong)UIButton * jiaBtn;
@property(nonatomic,strong)UILabel * countLab;
@property(nonatomic,strong)UILabel * totalLab;

@end
