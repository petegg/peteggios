//
//  RegiestViewController.m
//  petegg
//
//  Created by czx on 16/4/5.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "RegiestViewController.h"
#import "CompletionViewController.h"
#import "AgreementViewController.h"
@interface RegiestViewController ()
{
    
    NSString * registCode;
    NSString * totalrecords;
    
}
@property (nonatomic,strong)UITextField * textFieldes;

@property (nonatomic,strong)UIButton * securityButton;

@end

@implementation RegiestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= [UIColor whiteColor];
     [self setNavTitle: NSLocalizedString(@"regist", nil)];
    
}


- (void)setupView{
    
    [super setupView];
    
    NSArray * namearray = @[@"手机号码:",@"验证码:",@"密码:",@"确认密码:",];
    NSArray * placeArray = @[@"请输入手机号码",@"请输入验证码",@"请输入密码",@"请确认密码"];
    for (int i = 0 ; i < 4; i++ ) {
        UILabel * writingLabeles = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 70 * W_Hight_Zoom + 50 * W_Hight_Zoom * i, 70 * W_Wide_Zoom, 35 * W_Hight_Zoom)];
        writingLabeles.text = namearray[i];
        writingLabeles.textAlignment = NSTextAlignmentRight;
        writingLabeles.font = [UIFont systemFontOfSize:15];
        writingLabeles.textColor = [UIColor blackColor];
        [self.view addSubview:writingLabeles];
        
        UILabel * lineLabeles = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 110 * W_Hight_Zoom + 50 * i * W_Hight_Zoom, 375 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
        lineLabeles.backgroundColor = GRAY_COLOR;
        [self.view addSubview:lineLabeles];
        
        _textFieldes = [[UITextField alloc]initWithFrame:CGRectMake(90 * W_Wide_Zoom,  70 * W_Hight_Zoom + i * 50 * W_Hight_Zoom, 200 * W_Wide_Zoom, 40 * W_Hight_Zoom)];
        _textFieldes.placeholder = placeArray[i];
        [_textFieldes setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
         // _textFieldes.secureTextEntry = YES;
        [_textFieldes setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        _textFieldes.tag = i + 33;
        if (_textFieldes.tag == 33 || _textFieldes.tag == 34) {
            _textFieldes.keyboardType = UIKeyboardTypeNumberPad;
        }
        
        if (_textFieldes.tag == 35 || _textFieldes.tag == 36) {
            _textFieldes.secureTextEntry = YES;
        }
        
        [self.view addSubview:_textFieldes];
        
    }
    
    
    for (NSInteger i = 0 ; i<2; i++) {
            UIButton * showBtn =[[UIButton alloc]initWithFrame:CGRectMake(320 * W_Wide_Zoom, 176 * W_Hight_Zoom +i*50 * W_Hight_Zoom, 18 * W_Wide_Zoom, 18 * W_Hight_Zoom)];
            [showBtn setImage:[UIImage imageNamed:@"showPs.png"] forState:UIControlStateNormal];
        [showBtn setImage:[UIImage imageNamed:@"noshowpass.png"] forState:UIControlStateSelected];
        showBtn.selected = YES;
            showBtn.tag = 1000 +i;
        [showBtn addTarget:self action:@selector(showPs:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:showBtn];
    

    }
    
    
    _securityButton = [[UIButton alloc]initWithFrame:CGRectMake(250 * W_Wide_Zoom, 120 * W_Hight_Zoom, 110 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _securityButton.backgroundColor = GREEN_COLOR;
    [_securityButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _securityButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _securityButton.layer.cornerRadius = 5;
    [_securityButton addTarget:self action:@selector(passwordCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_securityButton];
    
    
    
    //注册
    
    UIButton * registBtn =[[UIButton alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom, 250 * W_Wide_Zoom, 40 * W_Hight_Zoom)];
    registBtn.backgroundColor =GREEN_COLOR;
    registBtn.layer.cornerRadius =  6;
    registBtn.tag = 10000;
    registBtn.center = self.view.center;
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    registBtn.titleLabel.font =[UIFont systemFontOfSize:16];
    [registBtn addTarget:self action:@selector(registBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    
    
    UILabel * labelXieyi =[[UILabel alloc]initWithFrame:CGRectMake(68 * W_Wide_Zoom, 360 * W_Hight_Zoom, 250 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    labelXieyi.text =@"点击'注册'按钮,代表已阅读并同意";
    labelXieyi.font =[UIFont systemFontOfSize:12];
    [self.view addSubview:labelXieyi];
    
    UIButton * xieyiBtn =[[UIButton alloc]initWithFrame:CGRectMake(252 * W_Wide_Zoom, 360 * W_Hight_Zoom, 60 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    [xieyiBtn setTitle:@"注册协议" forState:UIControlStateNormal];
    xieyiBtn.titleLabel.font =[UIFont systemFontOfSize:12];
    [xieyiBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [xieyiBtn addTarget:self action:@selector(zhuceixiyi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xieyiBtn];
    
    
    
    
    
    
    
}


/**
 *  注册协议
 */

- (void)zhuceixiyi
{
    
    AgreementViewController * agreeVC =[[AgreementViewController alloc]init];
    [self.navigationController pushViewController:agreeVC animated:YES];
    
    
}

- (void)setupData
{
    [super setupData];
    
    
}



/**
 *   验证码
 */


- (void)passwordCode:(UIButton *)sender
{
    UITextField * text =  (UITextField *)[self.view viewWithTag:33];
    if ([AppUtil isBlankString:text.text]) {
        [[AppUtil appTopViewController] showHint:@"请输入手机号码"];
        return;
    }
    if (![AppUtil isValidateMobile:text.text]) {
        [[AppUtil appTopViewController] showHint:@"请输入正确格式的手机号码"];
        return;
    }
    
    [self proveCode];
    
    
    
}



/**
 *  注册
 */


- (void)registBtn:(UIButton *)sender
{
    

   
     UITextField * text =  (UITextField *)[self.view viewWithTag:33];
     UITextField * text1 =  (UITextField *)[self.view viewWithTag:34];
     UITextField * text2 =  (UITextField *)[self.view viewWithTag:35];
     UITextField * text3 =  (UITextField *)[self.view viewWithTag:36];
    
    if ([AppUtil isBlankString:text.text]) {
         [[AppUtil appTopViewController] showHint:@"请输入帐号"];
        return;
    }
    if (![AppUtil isValidateMobile:text.text]) {
        [[AppUtil appTopViewController] showHint:@"请输入正确格式的手机号码"];
        return;
    }
    if ([AppUtil isBlankString:text1.text]) {
         [[AppUtil appTopViewController] showHint:@"请输入验证码"];
        return;
    }
    if ([AppUtil isBlankString:text2.text]) {
         [[AppUtil appTopViewController] showHint:@"请输入密码"];
        return;
    }
    if (![text2.text isEqualToString:text3.text]) {
         [[AppUtil appTopViewController] showHint:@"两次输入密码不一致"];
        return;
    }
    if (![text1.text isEqualToString:registCode]) {
        [[AppUtil appTopViewController] showHint:@"请输入正确的验证码"];
        return;
    }
    
    if (![text.text isEqualToString:totalrecords]) {
        [[AppUtil appTopViewController] showHint:@"手机号码错误"];
        return;
    }

    
    NSString * str =@"clientAction.do?method=json&classes=appinterface&common=memberRegister";
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    [dic setValue:text.text forKey:@"phone"];
    [dic setValue:text2.text forKey:@"password"];
    
    [AFNetWorking postWithApi:str parameters:dic success:^(id json) {
    
        if ([json[@"jsondata"][@"retCode"] isEqualToString:@"0000"]) {
            [self showSuccessHudWithHint:@"注册成功"];
    
            CompletionViewController * compleVC =[[CompletionViewController alloc]initWithNibName:@"CompletionViewController" bundle:nil];
            compleVC.mid = json[@"jsondata"][@"content"];
            [self.navigationController pushViewController:compleVC animated:YES];

        }
        
        NSLog(@"====%@",json);
        
       
        
    } failure:^(NSError *error) {
    }];

    
}

/**
 *  密码显示
 */

- (void)showPs:(UIButton *)sender
{

    
    UIButton * btn1 = (UIButton *)[self.view viewWithTag:1000];
    UIButton * btn2 = (UIButton *)[self.view viewWithTag:1001];
    UITextField * textFL =(UITextField *)[self.view viewWithTag:35];
    UITextField * textFL2 =(UITextField *)[self.view viewWithTag:36];
    btn1.selected = !btn1.selected;
    btn2.selected = !btn2.selected;
    
    if (sender.selected == YES) {
        textFL.secureTextEntry = YES;
        textFL2.secureTextEntry = YES;
    }else{
        textFL.secureTextEntry = NO;
        textFL2.secureTextEntry = NO;
    }
   
    
    
    
}


/**
 *  验证码
 */

- (void)proveCode
{
    [self timeout];
    UITextField * text =  (UITextField *)[self.view viewWithTag:33];
    NSString * str =@"clientAction.do?method=json&classes=appinterface&common=check";
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    [dic setValue:text.text forKey:@"phone"];
    [dic setValue:@"register" forKey:@"type"];
    
    [AFNetWorking postWithApi:str parameters:dic success:^(id json) {
        
        if ([json[@"jsondata"][@"retCode"] isEqualToString:@"0000"]) {
            registCode =json[@"jsondata"][@"content"];
            totalrecords = json[@"jsondata"][@"totalrecords"];
            
        }else{
            NSString * str =[NSString stringWithFormat:@"%@",json[@"jsondata"][@"retDesc"]];
            UIButton * btn =  (UIButton *)[self.view viewWithTag:10000];
            btn.enabled = NO;
             [[AppUtil appTopViewController] showHint:str];
           // [self showSuccessHudWithHint:str];
            
        }
        
          } failure:^(NSError *error) {
              
              
              
    }];
    
}


/**
 *  显示
 */
- (void)timeout
{
    
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);     dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_securityButton setTitle:@"发送验证码" forState:UIControlStateNormal];
                _securityButton.userInteractionEnabled = YES;
                _securityButton.backgroundColor = GREEN_COLOR;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"————————%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_securityButton setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                _securityButton.userInteractionEnabled = NO;
                _securityButton.backgroundColor = [UIColor grayColor];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);

}

@end

