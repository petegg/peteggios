//
//  LoginViewController.m
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "LoginViewController.h"

#import "AFHttpClient+Account.h"
#import "RegiestViewController.h"
#import "ReDataViewController.h"
#import "LoginModel.h"
#import "CompletionViewController.h"
@interface LoginViewController()<UITextFieldDelegate>
@property (nonatomic,strong)UIButton * loginButton;
@property (nonatomic,strong)UITextField * accountTextField;
@property (nonatomic,strong)UITextField * passwordTextField;

@end

@implementation LoginViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //self.navigationController.navigationBarHidden = YES;
    [self initUserFace];

}
-(void)initUserFace{
    UIImageView * backImage = [[UIImageView alloc]initWithFrame:self.view.frame];
    backImage.image = [UIImage imageNamed:@"egg_login.jpg"];
    [self.view addSubview:backImage];
    
    UIImageView * shuruKuangImage = [[UIImageView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 120 * W_Hight_Zoom, 375 * W_Wide_Zoom, 120 * W_Hight_Zoom)];
    shuruKuangImage.image = [UIImage imageNamed:@"egg_bigKuang.png"];
    [self.view addSubview:shuruKuangImage];

    UIImageView * topIcon = [[UIImageView alloc]initWithFrame:CGRectMake(40 * W_Wide_Zoom, 20 * W_Hight_Zoom, 20 * W_Wide_Zoom, 23 * W_Hight_Zoom)];
    topIcon.image = [UIImage imageNamed:@"egg_usertubiao.png"];
    [shuruKuangImage addSubview:topIcon];
    
    UIImageView * downIcon = [[UIImageView alloc]initWithFrame:CGRectMake(40 * W_Wide_Zoom, 80 * W_Hight_Zoom, 20 * W_Wide_Zoom, 20 * W_Hight_Zoom)];
    downIcon.image = [UIImage imageNamed:@"egg_passtubiao.png"];
    [shuruKuangImage addSubview:downIcon];
    
    _loginButton = [[UIButton alloc]initWithFrame:CGRectMake(37.5 * W_Wide_Zoom, 320 * W_Hight_Zoom, 300 * W_Wide_Zoom, 35 * W_Hight_Zoom)];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginButton.backgroundColor = GREEN_COLOR;
    _loginButton.layer.cornerRadius = 5;
    [self.view addSubview:_loginButton];
    [_loginButton addTarget:self action:@selector(loginTouch) forControlEvents:UIControlEventTouchUpInside];
    

    _accountTextField = [[UITextField alloc]initWithFrame:CGRectMake(70 * W_Wide_Zoom, 133 * W_Hight_Zoom, 200 * W_Wide_Zoom, 40 * W_Hight_Zoom)];
    _accountTextField.placeholder = @"请输入手机号码";
    _accountTextField.tintColor = [UIColor whiteColor];
    _accountTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_accountTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [_accountTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _accountTextField.textColor = [UIColor whiteColor];
    _accountTextField.delegate = self;
    [self.view addSubview:_accountTextField];
    
    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(70 * W_Wide_Zoom, 193 * W_Hight_Zoom, 200 * W_Wide_Zoom, 40 * W_Hight_Zoom)];
    _passwordTextField.placeholder = @"请输入密码";
    _passwordTextField.tintColor = [UIColor whiteColor];
    _passwordTextField.keyboardType = UIKeyboardTypeDefault;
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.textColor = [UIColor whiteColor];
    [_passwordTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [_passwordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _passwordTextField.delegate = self;
    [self.view addSubview:_passwordTextField];
    
    //查看密码的键
    UIButton * secureBtn = [[UIButton alloc]initWithFrame:CGRectMake(300 * W_Wide_Zoom, 203 * W_Hight_Zoom, 18 * W_Wide_Zoom, 18 * W_Hight_Zoom)];
    [secureBtn setImage:[UIImage imageNamed:@"showPs.png"] forState:UIControlStateNormal];
    [secureBtn setImage:[UIImage imageNamed:@"noshowpass.png"] forState:UIControlStateSelected];
    secureBtn.selected = YES;
    [secureBtn addTarget:self action:@selector(secureButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secureBtn];
    
    UIButton * regiestButton = [[UIButton alloc]initWithFrame:CGRectMake(77.5 * W_Wide_Zoom, 380 * W_Hight_Zoom, 100 * W_Wide_Zoom, 35 * W_Hight_Zoom)];
    [regiestButton setTitle:@"新用户注册" forState:UIControlStateNormal];
    [regiestButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    regiestButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:regiestButton];
    [regiestButton addTarget:self action:@selector(regiestButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * shulineLabel = [[UILabel alloc]initWithFrame:CGRectMake(187.5 * W_Wide_Zoom, 390 * W_Hight_Zoom, 1 * W_Wide_Zoom, 12 * W_Hight_Zoom)];
    shulineLabel.backgroundColor = GRAY_COLOR;
    [self.view addSubview:shulineLabel];
    
    UIButton * reDataButton = [[UIButton alloc]initWithFrame:CGRectMake(197.5 * W_Wide_Zoom, 380 * W_Hight_Zoom, 100 * W_Wide_Zoom, 35 * W_Hight_Zoom)];
    [reDataButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [reDataButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    reDataButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:reDataButton];
    [reDataButton addTarget:self action:@selector(reDataButtonTouch:) forControlEvents:UIControlEventTouchUpInside];

    _accountTextField.text = @"";
    _passwordTextField.text = @"";
}

-(void)regiestButtonTouch:(UIButton *)sender{
    RegiestViewController * reVc = [[RegiestViewController alloc]init];
    [self.navigationController pushViewController:reVc animated:YES];
}

-(void)reDataButtonTouch:(UIButton *)sender{
    ReDataViewController * reDataVc = [[ReDataViewController alloc]init];
    [self.navigationController pushViewController:reDataVc animated:YES];

}
-(void)secureButtonTouch:(UIButton *)sender{

    _passwordTextField.secureTextEntry = !_passwordTextField.secureTextEntry;
    sender.selected = !sender.selected;
    
    
}




-(void)loginTouch{
    NSLog(@"登录");
    if ([AppUtil isBlankString:self.accountTextField.text]) {
        [[AppUtil appTopViewController] showHint:@"请输入帐号"];
        return;
    }
    if ([AppUtil isBlankString:self.passwordTextField.text]) {
        [[AppUtil appTopViewController] showHint:@"请输入密码"];
        return;
        
    }
    [self showHudInView:self.view hint:@"正在登录..."];
    [[AFHttpClient sharedAFHttpClient]loginWithUserName:self.accountTextField.text password:self.passwordTextField.text complete:^(BaseModel *model) {
        if ([model.retCode isEqualToString:@"0000"]) {
           // [[AppUtil appTopViewController] showHint:model.retDesc];
            NSMutableArray * listAry = [[NSMutableArray alloc]init];
            [listAry addObjectsFromArray:model.list];
            
            LoginModel * model1 = listAry[0];
            if ([AppUtil isBlankString:model1.headportrait]
                || [AppUtil isBlankString:model1.nickname]) {
                    [[AppUtil appTopViewController] showHint:@"请补全个人信息哦"];
                    CompletionViewController * compleVC =[[CompletionViewController alloc]initWithNibName:@"CompletionViewController" bundle:nil];
                    compleVC.mid = model1.mid;
                    [self.navigationController pushViewController:compleVC animated:YES];
        }
            else{
            [[AccountManager sharedAccountManager] login:model.list[0]];
                
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@YES];
            }
           [self hideHud];
        }else{
            [self hideHud];
        
        }
        
        
      
    }];
    
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;

}



-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.keyboardAppearance = UIKeyboardAppearanceAlert;
   // textField.keyboardType = UIKeyboardTypeDefault;
}


@end