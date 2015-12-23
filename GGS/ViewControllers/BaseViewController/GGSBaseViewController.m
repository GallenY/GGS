//
//  GGSBaseViewController.m
//  GGS
//
//  Created by 高阳 on 15/12/18.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import "GGSBaseViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface GGSBaseViewController () <MBProgressHUDDelegate>

@property (nonatomic, weak) UILabel *msgLabel;

@end

@implementation GGSBaseViewController{
    MBProgressHUD *HUD;
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - VC lifecycle
- (void)viewDidLoad
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)dontShowBackButtonTitle{
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
}

- (void)getData
{
    //退出当前正在执行的任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //设置接受数据样式
    [self.manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
}

/*
- (void)showLabelWithStr:(NSString *)str
{
    NSLog(@"提示信息 = %@",str);
    //判断当前是否有Label,如果有就不创建，没就创建(待完善)
    
    //创建一个居中的Label
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.5*(SCREEN_WIDTH - 100), 0.5*(SCREEN_HEIGHT - 50), 100, 50)];
    msgLabel.text = str;
    msgLabel.backgroundColor = [UIColor blackColor];
    msgLabel.textColor = [UIColor whiteColor];
    msgLabel.textAlignment = NSTextAlignmentCenter;
    msgLabel.font = [UIFont systemFontOfSize:14];
    msgLabel.alpha = 0.0;
    msgLabel.layer.cornerRadius = 5;
    msgLabel.layer.masksToBounds = YES;
    [[[UIApplication sharedApplication] keyWindow] addSubview:msgLabel];
    
    //动画显示msgLabel,并且消失
    
    [UIView animateWithDuration:0.5 animations:^{
        
        msgLabel.alpha = 0.8;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:3.0 animations:^{
            
            msgLabel.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            [msgLabel removeFromSuperview];
            
        }];
    }];
}
 */


#pragma mark - MBProgressHUD

- (void)showHUDWaitingWhileExecuting:(SEL)method {
    // The hud will dispable all input on the view (use the higest view possible in the view hierarchy)
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.color = [UIColor colorWithRed:100 / 255.0 green:100 / 255.0 blue:100 / 255.0 alpha:0.9];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:method onTarget:self withObject:nil animated:YES];
}

- (void)showHUDWithText:(NSString *)text {
    [self hideHud];
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    // Configure for text only and offset down
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = text;
    HUD.margin = 10.f;
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.removeFromSuperViewOnHide = YES;
}

- (void)showHUDWithText:(NSString *)text delay:(NSTimeInterval)delay {
    if (!HUD.isHidden) {
        [HUD hide:NO];
    }
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    // Configure for text only and offset down
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = text;
    HUD.margin = 10.f;
    HUD.removeFromSuperViewOnHide = YES;
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    [HUD hide:YES afterDelay:delay];
}


- (void)hideHud {
    if (!HUD.isHidden) {
        [HUD hide:NO];
    }
}

#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
    if (self.hudWasHidden) {
        self.hudWasHidden();
    }
}

@end
