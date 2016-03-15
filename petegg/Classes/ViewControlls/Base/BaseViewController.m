//
//  BaseViewController.m
//  petegg
//
//  Created by ldp on 16/3/14.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

- (void)viewDidLoad{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
}

- (void)showBarButton:(EzNavigationBar)position title:(NSString *)name fontColor:(UIColor *)color{
    UIButton *button ;
    CGSize titleSize = [name boundingRectWithSize:CGSizeMake(999999.0f, NAV_BAR_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} context:nil].size;
    CGRect buttonFrame = CGRectZero;
    
    buttonFrame = CGRectMake(0, 0, titleSize.width, 44);
    
    button = [[UIButton alloc] initWithFrame:buttonFrame];
    button.contentMode = UIViewContentModeScaleAspectFit;
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitle:name forState:UIControlStateNormal];
    
    [self showBarButton:position button:button];
}

- (void)showBarButton:(EzNavigationBar)position imageName:(NSString *)imageName{
    UIButton *button ;
    UIImage* image = [UIImage imageNamed:imageName];
    CGRect buttonFrame = CGRectZero;
    
    buttonFrame = CGRectMake(0, 0, image.size.width, NAV_BAR_HEIGHT);
    if ( buttonFrame.size.width < NAV_BUTTON_MIN_WIDTH ){
        buttonFrame.size.width = NAV_BUTTON_MIN_WIDTH;
    }
    
    if ( buttonFrame.size.height < NAV_BUTTON_MIN_HEIGHT ){
        buttonFrame.size.height = NAV_BUTTON_MIN_HEIGHT;
    }
    button = [[UIButton alloc] initWithFrame:buttonFrame];
    button.contentMode = UIViewContentModeScaleAspectFit;
    button.backgroundColor = [UIColor clearColor];
    [button setImage:image forState:UIControlStateNormal];
    
    [self showBarButton:position button:button];
}

- (void)showBarButton:(EzNavigationBar)position button:(UIButton *)button{
    if (NAV_LEFT == position) {
        [button addTarget:self action:@selector(leftButtonTouch) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }else if (NAV_RIGHT == position){
        [button addTarget:self action:@selector(rightButtonTouch) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
}

- (void)setTitleView:(UIView *)titleView{
    self.navigationItem.titleView = titleView;
}

- (void)leftButtonTouch{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonTouch{
}

@end