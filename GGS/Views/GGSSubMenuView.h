//
//  GGSSubMenuView.h
//  GGS
//
//  Created by 高阳 on 15/12/21.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GGSMenu;
@interface GGSSubMenuView : UIScrollView

@property (nonatomic, strong) GGSMenu *menu;

- (instancetype)initWithMenu:(GGSMenu *)menu;

+ (instancetype)initWithMenu:(GGSMenu *)menu;

@end
