//
//  JTNewAdressViewController.h
//  GiGWi
//
//  Created by 小七 on 15-4-24.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTAdressListViewController.h"
@interface JTNewAdressViewController : UIViewController
@property(nonatomic,strong)JTSortModel * adressModel;
@property(nonatomic,strong)JTAdressListViewController * adressListVC;
@end
