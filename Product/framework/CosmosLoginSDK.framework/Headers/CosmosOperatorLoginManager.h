//
//  CosmosOperatorAdapter.h
//  LoginSDK
//
//  Created by wangxuefei on 2019/10/28.
//  Copyright © 2019 MOMO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,CosmosOperatorsType) {//sim卡信息
    CosmosOperatorsOther = 0,//其它
    CosmosOperatorsMobile,//移动
    CosmosOperatorsUnicom,//联通
    CosmosOperatorsTelecom//电信
};



NS_ASSUME_NONNULL_BEGIN


/**
 用于预取号：
 @param resultDic 三大运营商回调信息
 @param error 为空表示预取号失败（失败后调起原生登录）。
 */
typedef void(^PreLoginCallback)( NSDictionary * _Nullable   resultDic,  NSError * _Nullable  error);


/**
 拉起登录页点击一键登录获取到手机号的回调
 */

typedef PreLoginCallback LoginCallback;


/**
 登录页按钮点击事件
 */
typedef void (^LoginClickAction)(NSDictionary * _Nullable   resultDic, CosmosOperatorsType type);



@interface CosmosOperatorLoginManager : NSObject


+ (void)initSDK:(NSString *)appid;


/** 获取当前手机卡的运营商类型 */
+ (CosmosOperatorsType)getOperatorsType;

/**
 支持三网，如果仅配置了 移动/联通/电信 其中1个或2个。如：仅配置了电信
 那么移动和联通使用电信的SDK预取号，如果成功。弹起授权页时，将弹起电信的授权页。
 默认不支持
 ps:SDK会尝试向配置了id的运营商预取号。如果失败，预取号就会回调，直到成功/尝试完毕都失败。
 */

+ (void)supportAllOperator:(BOOL)isSupport;

/**
 配置各运营商id
 @param appId  运营商的appid
 @param appKey 运营商的appKey
 @param registerType 运营商类型
 @param encrypType 加密类型：预留参数，暂时传nil
 各运营商对应关系:移动: appId:APPID appKey:APP Secret
               联通: appId:应用标识 appKey:应用密钥
               电信: appId:AppID  appKey:AppSecret
 */
+ (void)registerAppId:(NSString *)appId
               appKey:(NSString *)appKey
                 type:(CosmosOperatorsType)registerType
           encrypType:(NSString * _Nullable)encrypType;

/**
 预取号: 业务方根据是否有error来判断是否跳转 一键登录。
 @param timeoutInterval 单位秒
 */
+ (void)requestPreLogin:(NSTimeInterval)timeoutInterval
             completion:(PreLoginCallback)preLoginCallback;


/** 配置授权页ui样式  (完全自定义，依赖三方原config)方式一
 配置各运营商原生的config
 @param config  移动:UACustomModel 联通:UniCustomModel
    电信:EAcoountOpenPageConfig
 @param registerType 对应类型。
 */
+ (void)configLoginVC:(id)config
                 type:(CosmosOperatorsType)registerType;

/**
 打开授权页面，如果预取号失败，调用此接口无效
  @param presentingVC 发起模态的视图
  @param customViews 联通定制customView的回调。参考
            if (customAreaView) {
                 UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
                 [button1 setFrame:CGRectMake(0, 0, self.view.frame.size.width, 46)];
                 [button1 setBackgroundColor:[UIColor blueColor]];
 
                 [customAreaView addSubview:button1];
             }
 
 @param clickAction
 电信页面添加控件方式为修改nib：此处会回调控件tag
 电信：resultDic @{
    @"actionType" : tag(自定义控件的tag值)
  }
 
 
 移动联通此处不会回调自定义的action.只会回调默认页面的按钮的点击事件：
 联通：resultDic @{
    @"actionType" : 3000 (其他登录方式点击事件)
 }

 移动：resultDic @{
    @"actionType" : 3000 (其他登录方式点击事件)
 }
 
 @param callBack
 如果error为空，返回cosmos服务端获取手机号所需的字段
 */
+ (void)openLoginVCFromVC:(UIViewController *)presentingVC
         unicomCustomView:(nullable void(^)(UIView *customAreaView))customViews
           actionCallBack:(LoginClickAction)clickAction
                 callBack:(LoginCallback)callBack;

/**
 关闭授权页
 @param animation 是否有动画。（切换登录方式时，可以设置为false,然后弹出业务方的登录页）
 ps:电信不支持animation
 */
+ (void)closeLoginVCWithAnimation:(BOOL)animation;


/** 关闭授权页，添加回调*/
+ (void)closeLoginVCWithAnimation:(BOOL)animation completion:(void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
