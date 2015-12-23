//
//  GGSSubMenuView.m
//  GGS
//
//  Created by 高阳 on 15/12/21.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import "GGSSubMenuView.h"
#import "GGSMenu.h"
#import "GGSBaseFunction.h"
#import <UIImageView+WebCache.h>

#define textFont [UIFont systemFontOfSize:15]
#define textSize CGSizeMake(SCREEN_WIDTH*0.9, 300)
#define margin SCREEN_WIDTH*0.05

@interface GGSSubMenuView ()

@end

/*
 参数列表：
 title (菜谱名) 作为navigationController的title
 albums (图片)
 tags(标签)
 intro（介绍）
 ingredients (材料)
 burden (佐料)

 steps (img,step)
 */

@implementation GGSSubMenuView{
    float maxY;
}

- (instancetype)initWithMenu:(GGSMenu *)menu
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        //1.创建图片imageView
        UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, 5, SCREEN_WIDTH*0.8, SCREEN_WIDTH*0.8)];
        [self addSubview:titleImageView];
        [titleImageView sd_setImageWithURL:[NSURL URLWithString:menu.albums]];
        //设置图片自适应imageView,默认是填充满fill
        titleImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        //分隔线
        UILabel *separatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleImageView.frame), SCREEN_WIDTH, 1)];
        separatorLabel.backgroundColor = [UIColor blackColor];
        [self addSubview:separatorLabel];
        
        //2.创建材料Label.
        NSString *strIngredients = [NSString stringWithFormat:@"材料：%@",menu.ingredients];
        CGSize strIngredientsSize = [GGSBaseFunction sizeOfText:strIngredients maxSize:textSize font:textFont];
        UILabel *ingredientsLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(titleImageView.frame) + margin, strIngredientsSize.width, strIngredientsSize.height)];
        ingredientsLabel.font = textFont;
        ingredientsLabel.numberOfLines = 0;
        ingredientsLabel.text = strIngredients;
        [self addSubview:ingredientsLabel];
        
        //3.创建佐料label
        NSString *strBurden = [NSString stringWithFormat:@"佐料：%@",menu.burden];
        CGSize strBurdenSize = [GGSBaseFunction sizeOfText:strBurden maxSize:textSize font:textFont];
        UILabel *burdenLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(ingredientsLabel.frame), strBurdenSize.width, strBurdenSize.height)];
        burdenLabel.font = textFont;
        burdenLabel.numberOfLines = 0;
        burdenLabel.text = strBurden;
        [self addSubview:burdenLabel];
        
        //4.循环创建 steplael img
        maxY = CGRectGetMaxY(burdenLabel.frame);
        
        for (GGSMenuStep *ms in menu.steps) {
            //Label
            CGSize stepSize = [GGSBaseFunction sizeOfText:ms.step maxSize:textSize font:textFont];
            UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, maxY+5, stepSize.width, stepSize.height)];
            stepLabel.numberOfLines = 0;
            stepLabel.font = textFont;
            stepLabel.text = ms.step;
            [self addSubview:stepLabel];
            //UIImage
            UIImageView *stepImg= [[UIImageView alloc] initWithFrame:CGRectMake(margin, maxY+stepSize.height+10, SCREEN_WIDTH*0.8, SCREEN_WIDTH*0.4)];
            [stepImg sd_setImageWithURL:[NSURL URLWithString:ms.img]];
            stepImg.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:stepImg];
            maxY+= stepSize.height + SCREEN_WIDTH*0.4 + 10;
        }
        //5.根据最后一个控件最大Y值设置scrollView的contentSize
        self.contentSize = CGSizeMake(SCREEN_WIDTH, maxY);
    }
    return self;
}

+ (instancetype)initWithMenu:(GGSMenu *)menu
{
    return [[self alloc] initWithMenu:menu];
}

@end
