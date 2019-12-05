//
//  VerificationVC.m
//  LoginSDK
//
//  Created by wangxuefei on 2019/11/25.
//  Copyright © 2019 MOMO. All rights reserved.
//

#import "VerificationVC.h"
#import "macros.h"
#import "LoginResultVC.h"
@interface VerificationVC ()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *cosmosLoginBtn;

@property (weak, nonatomic) IBOutlet UILabel *secondLab;

@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

@property (weak, nonatomic) IBOutlet UITextField *verificantionTextfield;

@property (nonatomic,strong) UIButton *barBackBtn;

@property (nonatomic, strong) void (^cosmosCallBack)(void);

@end

@implementation VerificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)backBtnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)cosmosCallBack:(void (^)(void))callBack{
    self.cosmosCallBack = callBack;
}


- (IBAction)loginBtnClick:(id)sender {
    
    UINavigationController *nav = self.navigationController;
    [self.navigationController popViewControllerAnimated:false];

    LoginResultVC *vc = [[LoginResultVC alloc]init];
    vc.mobile = @"13888888888";
    [nav pushViewController:vc animated:true];
}
- (IBAction)cosmosLoginBtnClick:(id)sender {
    if(self.cosmosCallBack){
        self.cosmosCallBack();
    }
}

- (void)configUI{
    
    self.secondLab.backgroundColor = SRGBAlpha(220, 220, 220, 1);
    self.secondLab.clipsToBounds = true;
    self.secondLab.layer.cornerRadius = self.secondLab.frame.size.height / 2.0;
    
    self.numberTextField.backgroundColor = [UIColor whiteColor];
    self.numberTextField.clipsToBounds = true;
    self.numberTextField.layer.cornerRadius = self.numberTextField.frame.size.height / 2.0;
    
    self.numberTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.numberTextField.frame.size.height / 2.0, self.numberTextField.frame.size.height)];
    self.numberTextField.leftViewMode = UITextFieldViewModeAlways;

    
    self.verificantionTextfield.backgroundColor = [UIColor whiteColor];
    self.verificantionTextfield.clipsToBounds = true;
    self.verificantionTextfield.layer.cornerRadius = self.verificantionTextfield.frame.size.height / 2.0;
    self.verificantionTextfield.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.verificantionTextfield.frame.size.height / 2.0, self.verificantionTextfield.frame.size.height)];
    self.verificantionTextfield.leftViewMode = UITextFieldViewModeAlways;


    
    NSAttributedString *str = [self.class attrWithFont:[UIFont systemFontOfSize:16.0] textColor:[UIColor whiteColor] text:@"登录"];
    [self.loginBtn setAttributedTitle:str forState:UIControlStateNormal];
    self.loginBtn.layer.cornerRadius = self.loginBtn.frame.size.height / 2.0;
    self.loginBtn.clipsToBounds = true;
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];

    NSAttributedString *cosStr = [self.class attrWithFont:[UIFont systemFontOfSize:14.0] textColor:SRGBAlpha(139, 143, 147, 1) text:@"一键登录"];
    [self.cosmosLoginBtn setAttributedTitle:cosStr forState:UIControlStateNormal];
    
    self.view.backgroundColor = SRGBAlpha(243, 243, 243, 1);
    
    
    [self.view addSubview:self.barBackBtn];
    
}

- (UIButton *)barBackBtn{
    if(!_barBackBtn){
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(15, [self getSafeAreaBottom] + 11, 65, 22)];
        NSAttributedString *str = [self.class attrWithFont:[UIFont systemFontOfSize:13.0] textColor:[UIColor blackColor] text:@"返回"];
        [button setAttributedTitle:str forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _barBackBtn = button;
    }
    return _barBackBtn;
    
}

- (CGFloat)getSafeAreaBottom{
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets inset = [UIApplication sharedApplication].keyWindow.safeAreaInsets;
        return inset.top ;
    } else {
        return 20;
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
