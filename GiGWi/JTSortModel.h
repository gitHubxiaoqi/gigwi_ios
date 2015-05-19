//
//  JTSortModel.h
//  Qyli
//
//  Created by 小七 on 14-8-26.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JTSortModel : NSObject

//基本信息
@property(nonatomic,strong)NSString * idStr;
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSString * imgUrlStr;
@property(nonatomic,strong)NSString * description1;
//@property(nonatomic,strong)NSArray * imgUrlArr;


@property(nonatomic,strong)NSString * goumaiNum;//购买数量
@property(nonatomic,strong)NSString * propertyStr;//所选类型

@property(nonatomic,strong)NSString * cost;//直销价格
@property(nonatomic,strong)NSString * youhuiCost;//优惠价格
@property(nonatomic,strong)NSString * kucunNum;//库存量
@property(nonatomic,strong)NSString * xiaoliangNum;//销量
@property(nonatomic,strong)NSString * shifukuanNum;//实付款金额


@property(nonatomic,strong)NSArray * orderGoodsArr;
@property(nonatomic,strong)NSString * goodsId;

@property(nonatomic,strong)NSString * typeID;
@property(nonatomic,strong)NSString * offer;//收益
//物流信息
@property(nonatomic,strong)NSString * wuliuGongsi;
@property(nonatomic,strong)NSString * wuliuDanhaoId;
@property(nonatomic,strong)NSString * wuliuGongsiPinyin;
@property(nonatomic,strong)NSString * registTime;

//收货人信息
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * tel;
@property(nonatomic,strong)NSString * isChangyong;
@property(nonatomic,strong)NSString * provinceIDStr;
@property(nonatomic,strong)NSString * provinceStr;
@property(nonatomic,strong)NSString * cityIDStr;
@property(nonatomic,strong)NSString * cityStr;
@property(nonatomic,strong)NSString * quIDStr;
@property(nonatomic,strong)NSString * quStr;
@property(nonatomic,strong)NSString * streetIDStr;
@property(nonatomic,strong)NSString * street;
@property(nonatomic,strong)NSString * infoAddress;





@end
