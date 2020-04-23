//
//  ViewController.m
//  LoginSDK
//
//  Created by wangxuefei on 2019/10/21.
//  Copyright © 2019 MOMO. All rights reserved.
//

#import "ViewController.h"
#import "VerificationVC.h"

#import <TYRZSDK/UACustomModel.h>
#import <account_login_sdk_core/UniAuthViewModel.h>

#import "EAccountHYSDK/EAccountOpenPageSDK.h"

#import "CosmosRequestMobile.h"

//#import <CosmosLoginSDK/NSDictionary+CosmosLoginSafe.h>
#import "LoginResultVC.h"

#import <CosmosLoginSDK/CosmosOperatorLoginManager.h>

#import "UIImage+CosmosExtension.h"


#import "macros.h"
#define k_cosmos_query_phone_num @"https://cosmos.wemomo.com/admin/oneclick/test/fakeServer"


@interface ViewController ()
{
//    UniAuthHelper *helper;
}
@property (nonatomic, strong)NSString *numberStr;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *mobileImgView;

@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) UIView *bottomBackView;

@property (nonatomic, strong) UILabel *beginLoginLab;

@property (nonatomic, assign) BOOL isPreSucceed;

@property (nonatomic, strong) UIView *thirdLoginBackView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = true;
    
    [self configureUI];

    [CosmosOperatorLoginManager initSDK:@""];
    
    [CosmosOperatorLoginManager registerAppId:@"" appKey:@"" type:CosmosOperatorsMobile encrypType:nil];
    
    [CosmosOperatorLoginManager registerAppId:@"" appKey:@"" type:CosmosOperatorsUnicom encrypType:nil];
    
    [CosmosOperatorLoginManager registerAppId:@"" appKey:@"" type:CosmosOperatorsTelecom encrypType:nil];
    
    [CosmosOperatorLoginManager supportAllOperator:true];
    
    [self preLogin];

    [self configLoginVC];
//    [CosmosOperatorLoginManager configLoginVCWithAppPrivacyText:@"test" appPrivacyUrl:@"demo" presentVC:self];
    
    
    // Do any additional setup after loading the view.
}




- (void)configureUI{
    [self addGradientBackground];
    [self.view addSubview:self.bottomBackView];
    [self.bottomBackView addSubview:self.loginBtn];
    [self.bottomBackView addSubview:self.beginLoginLab];
}

- (void)preLogin{
    __weak typeof(self)weakself = self;
    [CosmosOperatorLoginManager requestPreLogin:3.0 completion:^(NSDictionary * _Nullable resultDic, NSError * _Nullable error) {
        if(!error){
            NSLog(@"预登陆成功");
            weakself.isPreSucceed = true;
        }
    }];
}

- (void)configLoginVC{
    
    [self configMobileLoginVC];
    
    [self  configUnicomLoginVC];
    
    [self configTelecomLoginVC];
}

- (void)configMobileLoginVC{
    UACustomModel *model = [[UACustomModel alloc]init];
    model.currentVC = self;
   
    NSAttributedString *attr = [self.class attrWithFont:[UIFont systemFontOfSize:14.0] textColor:SRGBAlpha(139, 143, 147, 1) text:@"手机号登录"];
    model.privacyState = true;

    __weak typeof(self)weakself = self;
    [model setAuthViewBlock:^(UIView *customView, CGRect numberFrame, CGRect loginBtnFrame, CGRect checkBoxFrame, CGRect privacyFrame) {
        weakself.thirdLoginBackView.frame = CGRectMake(CGRectGetWidth(customView.frame) / 2.0 - (CGRectGetWidth(weakself.thirdLoginBackView.frame)) / 2.0, CGRectGetMaxY(loginBtnFrame) + 77 / (SCREEN_HEIGHT / 667), CGRectGetWidth(weakself.thirdLoginBackView.frame), CGRectGetHeight(weakself.thirdLoginBackView.frame));
               [customView addSubview:weakself.thirdLoginBackView];
    }];
    
    [CosmosOperatorLoginManager configLoginVC:model type:CosmosOperatorsMobile];
}


- (void)configUnicomLoginVC{
    UniAuthViewModel *model = [[UniAuthViewModel alloc]init];
      model.naviBgColor = [UIColor whiteColor];
      model.naviBackImage = [[UIImage imageNamed:@"unified_001"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
      model.webNaviBgColor = [UIColor whiteColor];

      //验证手机号
      model.appLogo = [UIImage imageNamed:@"login_038"];
      struct UniRect logoRect;
      logoRect.size = CGSizeMake(113.5, 21.5);
      logoRect.portraitLeftXOffset = SCREEN_WIDTH/2.0 - 113.5/2.0;
      logoRect.portraitTopYOffset = 111;
      model.logoRect = logoRect;
      
      //运营商slogan
      
      struct UniRect sloganRect;
      sloganRect.size = CGSizeMake(180, 18.5);
      sloganRect.portraitLeftXOffset = SCREEN_WIDTH/2.0 - 180/2.0;
      sloganRect.portraitTopYOffset = model.logoRect.portraitTopYOffset + model.logoRect.size.height + 12;
      model.sloganRect = sloganRect;
      
      //手机号
      
      struct UniRect phoneRect;
      phoneRect.size = CGSizeMake(SCREEN_WIDTH - 30, 46);
      phoneRect.portraitLeftXOffset = 0;
      phoneRect.portraitTopYOffset = model.sloganRect.portraitTopYOffset + model.sloganRect.size.height + 31.5;
      model.phoneNumRect = phoneRect;
      
      //登录按钮
      model.authButtonTitle = [[NSAttributedString alloc] initWithString:@"确认登录" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15], NSForegroundColorAttributeName: UIColor.whiteColor}];
      model.authButtonCornerRadius = 4.0;
      
      
      
      struct UniRect authBtnRect;
      authBtnRect.size = CGSizeMake(SCREEN_WIDTH - 75, 50);
      authBtnRect.portraitLeftXOffset = 37.5;
      model.authButtonRect = authBtnRect;
      
      //隐藏原有切换登录按钮
      model.switchButtonHidden = YES;
      
    
      
     
      
      NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
      paragraphStyle.lineSpacing = 0;
      paragraphStyle.alignment = NSTextAlignmentCenter;
      paragraphStyle.paragraphSpacing = 0.0;
      paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
      paragraphStyle.firstLineHeadIndent = 0.0;
      model.auxiliaryPrivacyWords = @[@"继续表示同意", @"和", @"和", @"并授权获取本机号码"];
      
      struct UniRect privacyRect;
      privacyRect.size = CGSizeMake(SCREEN_WIDTH - 75, 40);
      privacyRect.portraitLeftXOffset = 37.5;
      privacyRect.portraitTopYOffset = SCREEN_HEIGHT
      - 40 - 37.5;
      model.termsRect = privacyRect;
      
      [CosmosOperatorLoginManager configLoginVC:model type:CosmosOperatorsUnicom];

}

- (void)configTelecomLoginVC{
    
    EAccountOpenPageConfig *model = [[EAccountOpenPageConfig alloc]init];
    model.nibNameOfLoginVC = @"EAccountAuthVC";
    model.EAccountBundleName = @"EAccountOpenPage";

    model.logBtnHeight = 44;
    model.logBtnCornerRadius = 22;

    model.EAStartIndex = 5;
    model.EAEndIndex = 17;
    
    model.pStartIndex = 19;
    model.pEndIndex = 26;
    model.PAUrl = @"https://cosmos.immomo.com";
    model.PALabelText = @"登录即同意《天翼账号服务与隐私协议》与《cosmos》并授权[cosmos]获本机号码";
    model.PANameColor = SRGBAlpha(33, 173, 248, 1);

    model.customBtnTag1 = 10000;
    model.customBtnTag2 = 10001;
    model.customBtnTag3 = 10002;
    [CosmosOperatorLoginManager configLoginVC:model type:CosmosOperatorsTelecom];

}


- (void)addGradientBackground{
    
    UIColor *formColor = [UIColor colorWithRed: 50 / 255.0 green: 91 / 255.0 blue: 255 / 255.0 alpha:1];
    UIColor *toColor = [UIColor colorWithRed: 91 / 255.0 green: 208 / 255.0 blue: 252 / 255.0 alpha:1];
    CAGradientLayer *gradientLayer = [self.class setGradualChangingColor:self.view fromColor:formColor toColor:toColor];
    [self.backgroundView.layer addSublayer:gradientLayer];
    
    
}


//绘制渐变色颜色的方法
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(UIColor *)fromColorStr toColor:(UIColor *)toColorStr{

//    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;

    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)fromColorStr.CGColor,(__bridge id)toColorStr.CGColor];

    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);

    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];

    return gradientLayer;
}



- (IBAction)logininBtnclick:(id)sender {
    
    __weak typeof(self)weakself = self;
    [CosmosOperatorLoginManager openLoginVCFromVC:self unicomCustomView:^(UIView * _Nonnull customAreaView) {
        
        weakself.thirdLoginBackView.frame = CGRectMake(SCREEN_WIDTH / 2.0 - 82.5, 40, 163, 78);
        [customAreaView addSubview:weakself.phoneBtn];
        [customAreaView addSubview:weakself.thirdLoginBackView];
    }  actionCallBack:^(NSDictionary *action,CosmosOperatorsType type) {
        NSString *actitonType = [action objectForKey:@"actionType"];
        if([actitonType isEqualToString:@"10000"]){
            NSLog(@"qq");
        }else if([actitonType isEqualToString:@"10001"]){
            NSLog(@"weixin");
        }else if([actitonType isEqualToString:@"10002"]){
            NSLog(@"weibo");
        }else if([actitonType isEqualToString:@"3000"]){
            NSLog(@"手机号登录");
            [weakself pushVerficationVC];
        }else if([actitonType isEqualToString:@"3001"]){
            NSLog(@"关闭");
        }
    } callBack:^(NSDictionary * _Nullable resultDic, NSError * _Nullable error) {
        if(!error){
            [weakself requestMobileWithDic:resultDic];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself pushLoginResultVC:@""];
            });
        }
    }];
}

#pragma mark - 网络请求

- (void)requestMobileWithDic:(NSDictionary *)dic
{
    if(!dic){
        [self pushLoginResultVC:@""];
        return;
    }
    __weak typeof(self)weakself = self;
   
    [CosmosRequestMobile requestWithUrlStr:k_cosmos_query_phone_num param:dic succeedCallBack:^(NSDictionary * _Nonnull dic) {
//        NSDictionary *dataDic =[dic cos_login_dictionaryForKey:@"data" defaultValue:@{}];
//                      
//               NSString *mobile = [dataDic cos_login_stringForKey:@"mobile" defaultValue:@"-1"];
//
//               if(![mobile isEqualToString:@"-1"]){
//                  dispatch_async(dispatch_get_main_queue(), ^{
//                      [weakself pushLoginResultVC:mobile];
//                  });
//               }else{
//                  dispatch_async(dispatch_get_main_queue(), ^{
//                      [weakself pushLoginResultVC:@""];
//                  });
//               }
    } failCallBack:^(NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself pushLoginResultVC:@""];
        });
    }];
    
    
    
    
    
//    [CosmosRequest requestWithUrlStr:k_cosmos_query_phone_num param:dic succeedCallBack:^(NSDictionary * _Nonnull dic) {
//        NSDictionary *dataDic =[dic cos_login_dictionaryForKey:@"data" defaultValue:@{}];
//               
//        NSString *mobile = [dataDic cos_login_stringForKey:@"mobile" defaultValue:@"-1"];
//
//        if(![mobile isEqualToString:@"-1"]){
//           dispatch_async(dispatch_get_main_queue(), ^{
//               [weakself pushLoginResultVC:mobile];
//           });
//        }else{
//           dispatch_async(dispatch_get_main_queue(), ^{
//               [weakself pushLoginResultVC:@""];
//           });
//        }
//    } failCallBack:^(NSError * _Nonnull error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [weakself pushLoginResultVC:@""];
//        });
//    }];
}

- (void)pushLoginResultVC:(NSString *)mobile{
    [CosmosOperatorLoginManager closeLoginVCWithAnimation:false];
    LoginResultVC *result = [[LoginResultVC alloc]init];
    result.mobile = mobile;
    [self.navigationController pushViewController:result animated:YES];
}

- (void)pushVerficationVC{
    [CosmosOperatorLoginManager closeLoginVCWithAnimation:false];
        VerificationVC *vc = [[VerificationVC alloc]initWithNibName:@"VerificationVC" bundle:nil];
        [vc cosmosCallBack:^{
            [self.navigationController popViewControllerAnimated:false];
            [self logininBtnclick:nil];
    }];
    [self.navigationController pushViewController:vc animated:true];
    
}

- (void)thirdLoginBtnClick:(UIButton *)btn{
    switch (btn.tag - 300) {
        case 0:
            NSLog(@"qq denglu ");
            break;
        case 1:
            NSLog(@"wechat denglu ");
            break;
        case 2:
            NSLog(@"weibo denglu ");
            break;
        default:
            break;
    }
}

- (void)phoneBtnclick:(UIButton *)btn{
    [self pushVerficationVC];

}


- (UIView *)bottomBackView{
    if(!_bottomBackView){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 183, SCREEN_WIDTH, 200)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 17;
        _bottomBackView = view;
    }
    return _bottomBackView;
}

- (UIButton *)loginBtn{
    if(!_loginBtn){
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(70, 29, SCREEN_WIDTH - 140, 50)];
        
        NSAttributedString *str = [self.class attrWithFont:[UIFont systemFontOfSize:16.0] textColor:[UIColor whiteColor] text:@"一键登录"];
        [button setAttributedTitle:str forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
        button.layer.cornerRadius = 25;
        [button addTarget:self action:@selector(logininBtnclick:) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn = button;
    }
    return _loginBtn;
}


- (UIButton *)phoneBtn{
    if(!_phoneBtn){
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 - 100, 0,  200, 25)];
        NSAttributedString *str = [self.class attrWithFont:[UIFont systemFontOfSize:14.0] textColor:SRGBAlpha(139, 143, 147, 1) text:@"手机号登录"];
        [button setAttributedTitle:str forState:UIControlStateNormal];

        button.layer.cornerRadius = 12.5;
        [button addTarget:self action:@selector(phoneBtnclick:) forControlEvents:UIControlEventTouchUpInside];
        _phoneBtn = button;
    }
    return _phoneBtn;
}

- (UILabel *)beginLoginLab{
    if(!_beginLoginLab){
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.loginBtn.frame.origin.y + self.loginBtn.frame.size.height + 10, SCREEN_WIDTH, 19)];
        label.text = @"开始登录新体验 ！";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = SRGBAlpha(111, 111, 111, 1);
        label.font = [UIFont systemFontOfSize:13];
        _beginLoginLab = label;
    }
    return _beginLoginLab;
}

- (UIView *)thirdLoginBackView{
    if(!_thirdLoginBackView){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 - 82.5, 15, 163, 78)];
        NSArray *iconArr = @[@"qq_icon", @"wechat_icon", @"weibo_icon"];
        for (NSInteger i = 0;  i < iconArr.count; i ++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i * 62, 0, 39, 39)];
            btn.tag = 300 + i;
            [btn setImage:[UIImage imageNamed:iconArr[i]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(thirdLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
        }
        _thirdLoginBackView = view;
        
    }
    return _thirdLoginBackView;
}


+ (NSAttributedString *)attrWithFont:(UIFont *)font textColor:(UIColor *)textColor text:(NSString *)text{
    if(!text){
        return nil;
    }
    NSRange range = NSMakeRange(0, text.length);
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attrStr addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    [attrStr addAttribute:NSFontAttributeName value:font range:range];
    return attrStr;
}

@end
