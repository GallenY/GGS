//
//  GGSSubMenuViewController.h
//  GGS
//
//  Created by 高阳 on 15/12/21.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import "GGSBaseViewController.h"

@class GGSMenu;
@interface GGSSubMenuViewController : GGSBaseViewController

@property (nonatomic, strong) GGSMenu *menu;

+ (instancetype)initWithMenu:(GGSMenu *)menu;
@end
