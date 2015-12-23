//
//  GGSBaseViewController.h
//  GGS
//
//  Created by 高阳 on 15/12/18.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFHTTPSessionManager.h>

typedef enum {
    GGSTableViewRefreshTypeHeader = 1,
    GGSTableViewRefreshTypeFooter,
    GGSTableViewRefreshTypeNone //不调用刷新
} GGSTableViewRefreshType;

@interface GGSBaseViewController : UIViewController

@property (nonatomic, weak) AFHTTPSessionManager *manager;

@property (nonatomic, copy) void (^hudWasHidden)(void);
/**
 *  隐藏当前显示的提示框
 */
- (void)hideHud;

- (void)showHUDWithText:(NSString *)text;

- (void)showHUDWaitingWhileExecuting:(SEL)method;

- (void)showHUDWithText:(NSString *)text delay:(NSTimeInterval)delay;

/**
    显示提示信息label
 */
//- (void)showLabelWithStr:(NSString *)str;
/**
    NavigationController不显示返回Button的文字
 */
- (void)dontShowBackButtonTitle;

- (void)getData;

@end
