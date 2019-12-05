//
//  LoginResultVC.m
//  LoginSDK
//
//  Created by wangxuefei on 2019/11/23.
//  Copyright © 2019 MOMO. All rights reserved.
//

#import "LoginResultVC.h"

#import "macros.h"

@interface LoginResultVC ()

@property (nonatomic, strong) UIImageView *resultImg;

@property (nonatomic, strong) UILabel *resultLab;

@property (nonatomic, strong) UILabel *mobileLab;

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic,strong) UIButton *barBackBtn;


@end

@implementation LoginResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.barBackBtn];
    [self.view addSubview:self.resultImg];
    [self.view addSubview:self.resultLab];
    [self.view addSubview:self.mobileLab];
    [self.view addSubview:self.backBtn];
    // Do any additional setup after loading the view.
}



- (void)backBtnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:true];
}

- (UIImageView *)resultImg{
    if(!_resultImg){
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 - 41, [self getSafeAreaBottom] + 175, 82, 82)];
        if(!self.mobile || [self.mobile isEqualToString:@""]){
            img.image = [UIImage imageNamed:@"login_fail"];
        }else{
            img.image = [UIImage imageNamed:@"login_succeed"];
        }
        _resultImg = img;
    }
    return _resultImg;
}


- (UILabel *)resultLab{
    if(!_resultLab){
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 - 45, CGRectGetMaxY(self.resultImg.frame) + 12, 90, 30)];
        lab.textColor = [UIColor blackColor];
        lab.font = [UIFont systemFontOfSize:21];
        lab.textAlignment = NSTextAlignmentCenter;
        if(!self.mobile || [self.mobile isEqualToString:@""]){
            lab.text = @"登录失败";
        }else{
            lab.text = @"登录成功";
        }
        _resultLab = lab;
        
    }
    return _resultLab;
}

- (UILabel *)mobileLab{
    if(!_mobileLab){
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.resultLab.frame) + 5, SCREEN_WIDTH, 30)];
        lab.textColor = SRGBAlpha(139, 143, 147, 1);
        lab.font = [UIFont systemFontOfSize:13];
        lab.textAlignment = NSTextAlignmentCenter;
        NSString *mobile = @"手机号码为：";
        if(self.mobile){
            mobile = [mobile stringByAppendingString:self.mobile];
        }
        lab.text = mobile;
        _mobileLab = lab;
    }
    return _mobileLab;
}

- (UIButton *)backBtn{
    if(!_backBtn){
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 - 100, CGRectGetMaxY(self.mobileLab.frame) + 16, 200, 46)];
        NSAttributedString *str = [self.class attrWithFont:[UIFont systemFontOfSize:16.0] textColor:[UIColor whiteColor] text:@"返回首页"];
        [button setAttributedTitle:str forState:UIControlStateNormal];
        
        [button setBackgroundColor:SRGBAlpha(8, 85, 255, 1)];
        button.layer.cornerRadius = 23;
        [button addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _backBtn = button;
    }
    return _backBtn;
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
