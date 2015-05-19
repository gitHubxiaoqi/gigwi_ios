//
//  JTDefine.h
//  GiGWi
//
//  Created by 小七 on 15-4-21.
//  Copyright (c) 2015年 ___清一丽___. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

//MJRefreash
#define HeaderRefreshingText "GiGWi  正在帮您刷新数据"
#define FooterRefreshingText "GiGWi  正在帮您加载数据"
//获取屏幕宽高
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//导航高度
#define NAV_HEIGHT 44
#define TAB_HEIGHT 49
// 背景颜色(RGB)
#define BG_COLOR     [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1]
// 导航颜色(RGB)
#define NAV_COLOR       [UIColor colorWithRed:237.0/255.0 green:70.0/255.0 blue:47.0/255.0 alpha:1]




//#define QYL_URL "http://mobile.qin16.com/"
#define QYL_URL "http://172.20.10.86:8080/com.gigwi/Mobile/"
//#define QYL_URL "http://172.20.50.107:8080/com.gigwi/Mobile/"
//#define QYL_URL "http://120.25.215.89:8080/com.gigwi/Mobile/"

//朱雷接口
//1.1普通用户登录
#define NEW_QYL_People_LoginURL  "Login/LoginValidate"
//2.1账号注册
#define NEW_QYL_People_Regist_SaveRegisterUserURL  "UserOperation/SaveRegisterUser"
//2.2发送验证码到手机
#define NEW_QYL_People_Regist_SendPhoneCodeMsgURL  "PhoneCode/ValidatePhoneSendPhoneCodeMsg"
//2.3手机注册
#define NEW_QYL_People_Regist_SaveRegisterUserPhoneURL  "UserOperation/SaveRegisterUserPhone"

//3.1获取收货人地址信息列表
#define NEW_QYL_People_GetConsigneeAddressList  "ConsigneeAddress/GetConsigneeAddressList"
//3.2增加收货人地址信息
#define NEW_QYL_People_AddConsigneeAddress  "ConsigneeAddress/AddConsigneeAddress"
//3.3修改收货人地址信息
#define NEW_QYL_People_UpdateConsigneeAddress  "ConsigneeAddress/UpdateConsigneeAddress"
//3.4删除收货人地址信息
#define NEW_QYL_People_DeleteConsigneeAddress  "ConsigneeAddress/DeleteConsigneeAddress"

//4.1获取所有省市区信息
#define NEW_QYL_Area_getAllArea "Area/GetAllArea"
//4.1获取街道信息
#define NEW_QYL_Area_getStreets "Area/GetStreets"

//5.1找回密码-验证手机号是否经过认证
#define NEW_QYL_People_ValidatephoneBindingForgotPassword  "UserOperation/ValidatephoneBindingForgotPassword"
//5.2找回密码-发送手机验证码到手机
#define NEW_QYL_People_SendPhoneCodeMsg  "PhoneCode/SendPhoneCodeMsg"
//5.3找回密码-验证手机验证码
#define NEW_QYL_People_ValidatePhoneCodeForgotPassword  "UserOperation/ValidatePhoneCodeForgotPassword"
//5.4找回密码-重置密码
#define NEW_QYL_People_ChangePasswordForgotPassword  "UserOperation/ChangePasswordForgotPassword"

//6.1获取及时性User-------
#define NEW_QYL_People_GetUserInfoById  "UserOperation/GetUserInfoById"
//6.2修改用户个人信息-------
#define NEW_QYL_People_SaveEditUser  "UserOperation/SaveEditUser"
//6.3修改用户密码
#define NEW_QYL_People_SaveEditPassword  "UserOperation/SaveEditPassword"

//7.2发送短信验证码到新手机----------同5.2
//7.3验证旧手机短信验证码
#define NEW_QYL_People_ValidateCurrentBoundPhoneCodeForBindingPhone  "UserOperation/ValidateCurrentBoundPhoneCodeForBindingPhone"
//7.4发送短信验证码到新手机----------同5.2
//7.5验证新手机短信验证码并解绑旧手机，绑定新手机
#define NEW_QYL_People_ValidatePhoneCodeAndSaveForBindingPhone  "UserOperation/ValidatePhoneCodeAndSaveForBindingPhone"
//8.2版本更新
#define NEW_QYL_VersionUpdate_GetLastVersionForIOS  "VersionUpdate/GetLastVersionForIOS"

//王超接口
//商品列表
#define NEW_QYL_ShopGoods_page  "ShopGoods/page"
//商品详情
#define NEW_QYL_ShopGoods_getGoodInfo  "ShopGoods/getGoodInfo"


//陈功接口
//1.1加入购物车
#define NEW_QYL_Cart_Add  "Cart/Add"
//1.4查看购物车
#define NEW_QYL_Cart_Page  "Cart/Page"
//1.2删除购物车中某个商品
#define NEW_QYL_Cart_Delete  "Cart/Delete"
//1.3修改购物车中某个商品的个数
#define NEW_QYL_Cart_ChangeCount  "Cart/ChangeCount"
//2.1生成订单
#define NEW_QYL_Order_New  "Order/New"
//2.2取消订单
#define NEW_QYL_Order_Cancel  "Order/Cancel"
//2.3确认订单（确认收货）
#define NEW_QYL_Order_Confirm  "Order/Confirm"
//2.4查看订单列表
#define NEW_QYL_Order_Page  "Order/Page"
//2.7付款成功回调接口
#define NEW_QYL_Order_Paid  "Order/Paid"
//3.1退货
#define NEW_QYL_Order_Return  "Order/Return"
//3.6我的推荐
#define NEW_QYL_Order_InvitationOrder  "Order/InvitationOrder"
//4.1邀请码验证
#define NEW_QYL_Invitation_CheckCode  "Invitation/CheckCode"


@interface JTDefine : NSObject

@end
