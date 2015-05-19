//
//  JTUser.h
//  Qyli
//
//  Created by 小七 on 14-8-4.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JTUser : NSObject

//基本信息
@property(assign,nonatomic)int userID;
@property(strong,nonatomic)NSString * userName;
@property(strong,nonatomic)NSString * loginName;
@property(strong,nonatomic)NSString * password;

@property(strong,nonatomic)NSString * headPortraitImgUrlStr;
@property(nonatomic,copy)NSString * email;
@property(strong,nonatomic)NSString * phone;
@property(strong,nonatomic)NSString * yaoqingma;

@property(strong,nonatomic)NSString * createTime;
@property(strong,nonatomic)NSString * userType;//用户类型（USER:普通，MERCHANT:商家，ADMIN:管理员）

//常用收货信息
@property(strong,nonatomic)NSString * provinceID;
@property(strong,nonatomic)NSString * cityID;
@property(strong,nonatomic)NSString * provinceValue;
@property(strong,nonatomic)NSString * cityValue;
@property(strong,nonatomic)NSString * regionId;
@property(strong,nonatomic)NSString * streetId;
@property(strong,nonatomic)NSString * regionName;
@property(strong,nonatomic)NSString * streetName;
@property(strong,nonatomic)NSString * address;
@property(strong,nonatomic)NSString * adressName;
@property(strong,nonatomic)NSString * adressTel;



@end
