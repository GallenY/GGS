//
//  GGSSubMenuViewController.m
//  GGS
//
//  Created by 高阳 on 15/12/21.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import "GGSSubMenuViewController.h"
#import "GGSMenu.h"
#import "GGSSubMenuView.h"

@implementation GGSSubMenuViewController{
    GGSSubMenuView *menuView;
}

- (instancetype)initWithMenu:(GGSMenu *)menu{
    
    if (self = [super init]) {
        menuView = [GGSSubMenuView initWithMenu:menu];
        [self.view addSubview:menuView];
        
        self.navigationItem.title = menu.title;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

+ (instancetype)initWithMenu:(GGSMenu *)menu
{
    return [[self alloc] initWithMenu:menu];
}

- (void)viewDidLoad
{
    [self dontShowBackButtonTitle];
    //保存菜谱的barButton
    UIButton *barButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 55, 25)];
    [barButton setTitle:@"保存菜谱" forState:UIControlStateNormal];
    barButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    barButton.layer.borderWidth = 1;
    barButton.layer.borderColor = [UIColor grayColor].CGColor;
    [barButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    barButton.layer.cornerRadius = 5;
    barButton.layer.masksToBounds = YES;
    [barButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
}

- (void)saveButtonClick{
    NSLog(@"GGSSubMenuViewController saveButtonClick");
    [self showHUDWithText:@"别点了，该功能还没写" delay:1.0];
}

- (void)dealloc
{
    [menuView removeFromSuperview];
}
@end
