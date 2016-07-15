//
//  AppDelegate+Launcher.m
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "AppDelegate+Launcher.h"
#import "OtherEggViewController.h"
#import "EggViewController.h"
#import "PopStartView.h"

@interface AppDelegate()<GetScrollVDelegate>

@end

@implementation AppDelegate (Launcher)

/**
 *  启动逻辑入口
 *
 *  @param application
 *  @param launchOptions
 */
- (void)launcherApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor grayColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       GREEN_COLOR,NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChange:) name:NotificationLoginStateChange object:nil];
    
    
    [self checkLogin];
   
}




/**
 *  帆哥接口
 */


- (void)mapMidMehoth
{
    NSString * str =@"clientAction.do?common=modLocation&classes=appinterface&method=json";
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    if ([AppUtil isBlankString:[AccountManager sharedAccountManager].loginModel.mid]) {
         [dic setValue:@"" forKey:@"mid"];
    }else{
    [dic setValue:[AccountManager sharedAccountManager].loginModel.mid forKey:@"mid"];
    }
    [AFNetWorking postWithApi:str parameters:dic success:^(id json) {
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}

- (void)checkLogin{
    
    [self mapMidMehoth];
    if ([AccountManager sharedAccountManager].isLogin) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@YES];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@NO];
    }
}

-(void)loginStateChange:(NSNotification *)notification{
    
    BOOL loginSuccess = [notification.object boolValue];
    
    if (loginSuccess) {
        [self enterMainTabVC];
    }else{
        
         NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
         if (![[userdefaults objectForKey:@"STARTFLAG"] isEqualToString:@"1"]) {//第一次启动软件
         [self.window makeKeyAndVisible];
         [userdefaults setObject:@"1" forKey:@"STARTFLAG"];
         [userdefaults synchronize];
         PopStartView *popStartV = [[PopStartView alloc]initWithFrame:self.window.bounds];
         popStartV.delegate = self;
         popStartV.ParentView = self.window;
        [self.window addSubview:popStartV];
         
         }else {//不是第一次启动软件
          [self enterLoginVC];
             
         }
       
        
        
    }
}


//代理函数
- (void)getScrollV:(NSString *)popScroll
{
    
    [self enterLoginVC];

    
}


/**
 *  进入主界面
 */
- (void)enterMainTabVC{
    
    if (self.loginVC) {
        self.loginVC = nil;
    }
    
    self.mainTabVC = [[MainTabViewController alloc]init];

    self.window.rootViewController = self.mainTabVC;

    [self.window makeKeyAndVisible];
}

/**
 *  进入登陆界面
 */
- (void)enterLoginVC{
    
    if (self.mainTabVC) {
        self.mainTabVC = nil;
    }
    
    self.loginVC = [[LoginViewController alloc]init];
    
    UINavigationController * loginNaVc = [[UINavigationController alloc]initWithRootViewController:self.loginVC];
    self.window.rootViewController = loginNaVc;
    
    [self.window makeKeyAndVisible];
}





/**
 *  粘贴快捷
 *  直接跳到别人的视频开启界面逗宠
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    // 判断登录
    
    
    // 判断是否是自己
    
    
    
    if ([pboard.string length]>4  &&  [[pboard.string substringWithRange:NSMakeRange(0, 4)]  isEqualToString:@"赛果分享"]) {
        NSString * strPLAYcode = [pboard.string substringWithRange:NSMakeRange(5,14 )];
        [self checkPlayCode:strPLAYcode];
        pboard.string  =@"";
    }else
    {
        // 正常情况
        
        
    }
}



- (void)checkPlayCode:(NSString *)playStr
{
    
    NSString * str =@"clientAction.do?method=json&common=queryPlayCodeRule&classes=appinterface";
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    [dic setValue:[AccountManager sharedAccountManager].loginModel.mid forKey:@"mid"];
    [dic setValue:playStr forKey:@"playcode"];
    
     NSLog(@"==========%@",playStr);
    [AFNetWorking postWithApi:str parameters:dic success:^(id json) {
        NSMutableArray * arr =[NSMutableArray array];
            arr = json[@"jsondata"][@"list"];
        
        if ([arr[0][@"mid"] isEqualToString:[AccountManager sharedAccountManager].loginModel.mid]) {
            // 如果是自己
            EggViewController * eggVC = [[EggViewController alloc]init];
            [self.mainTabVC pushViewController:eggVC];
        
        }else
        {
        
        if ([arr[0][@"status"] isEqualToString:@"0"]) {
            [self.window.rootViewController showSuccessHudWithHint:@"此逗码已经失效"];
        }else
        {
            
            OtherEggViewController * otherVC =[[OtherEggViewController alloc]init];
            otherVC.otherArr = arr;
            otherVC.IScode = YES;
            [self.window.rootViewController presentViewController:otherVC animated:YES completion:nil];
        }
       
        }
        
    } failure:^(NSError *error) {
        
    }];
   
    
}

@end
