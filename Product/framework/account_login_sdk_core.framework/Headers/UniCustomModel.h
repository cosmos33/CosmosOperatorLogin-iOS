//
//  UniCustomModel.h
//  account_login_sdk_core
//
//  Created by zhuof on 2018/11/20.
//  Copyright © 2018年 xiaowo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UniCustomModel : NSObject
/*----------------------------------------授权页面-----------------------------------*/

//MARK:导航栏*************

/**导航栏颜色*/
@property (nonatomic,strong) UIColor *navColor;
/**导航栏标题*/
@property (nonatomic,strong) NSAttributedString *navText;
/**导航返回图标*/
@property (nonatomic,strong) UIImage *navReturnImg;
/**导航栏右侧自定义控件*/
@property (nonatomic,strong) UIBarButtonItem *navControl;
/**状态栏着色样式*/
@property (nonatomic,assign) UIStatusBarStyle barStyle;


//MARK:图片设置************

/**LOGO图片*/
@property (nonatomic,strong) UIImage *logoImg;
/**LOGO图片宽度*/
@property (nonatomic,assign) CGFloat logoWidth;
/**LOGO图片高度*/
@property (nonatomic,assign) CGFloat logoHeight;
/**LOGO图片偏移量*/
@property (nonatomic,assign) CGFloat logoOffsetY;

//MARK:登录按钮************

/**登录按钮文本*/
@property (nonatomic,strong) NSString *logBtnText;
/**登录按钮Y偏移量*/
@property (nonatomic,assign) CGFloat logBtnOffsetY;
/**登录按钮文本颜色*/
@property (nonatomic,strong) UIColor *logBtnTextColor;
/**登录按钮背景颜色*/
@property (nonatomic,strong) UIColor *logBtnColor;

//MARK:号码框设置************

/**手机号码字体颜色*/
@property (nonatomic,strong) UIColor *numberColor;
/**手机号码字体大小*/
@property (nonatomic,assign) CGFloat numberSize;
/**号码栏Y偏移量*/
@property (nonatomic,assign) CGFloat numFieldOffsetY;

/**隐藏切换账号按钮*/
@property (nonatomic,assign) BOOL swithAccHidden;
/**切换账号字体颜色*/
@property (nonatomic,strong) UIColor *swithAccTextColor;
/**设置切换账号相y偏移量*/
@property (nonatomic,assign) CGFloat switchOffsetY;




//MARK:隐私条款************

/**复选框选中时图片*/
@property (nonatomic,strong) UIImage *checkedImg;
/**隐私条款名称颜色（含书名号）*/
@property (nonatomic,strong) UIColor *privacyTextColor;
/**隐私条款Y偏移量*/
@property (nonatomic,assign) CGFloat privacyOffsetY;
/**app隐私条款*/
@property (nonatomic,strong) NSString *appPrivacyText;
/**app隐私条款链接*/
@property (nonatomic,strong) NSString *appPrivacyUrl;

//MARK:slogan************
/**slogan偏移量Y*/
@property (nonatomic,assign) CGFloat sloganOffsetY;
/**slogan文字颜色*/
@property (nonatomic,strong) UIColor *sloganTextColor;

@end
