//
//  JTQuerenDingdanViewController.h
//  GiGWi
//
//  Created by 小七 on 15-4-23.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTGouwucheViewController.h"
@interface JTQuerenDingdanViewController : UIViewController
@property(nonatomic,assign)float totalPrice;
@property(nonatomic,strong)NSArray * listModelArr;
@property(nonatomic,strong)NSArray * countArr;

@property(nonatomic,strong)JTSortModel * adressModel;

@property(nonatomic,strong)JTGouwucheViewController * gouWuCheVC;
@end
