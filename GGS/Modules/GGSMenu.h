//
//  GGSMenu.h
//  GGS
//
//  Created by 高阳 on 15/12/21.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GGSMenuStep.h"

@interface GGSMenu : NSObject

/*
    title (菜谱名)
    tags
    intro
    ingredients (材料)
    burden (佐料)
    albums (图片)
    steps (img,step)
 */

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *ingredients;
@property (nonatomic, copy) NSString *burden;
@property (nonatomic, copy) NSString *albums;
@property (nonatomic, strong) NSArray<GGSMenuStep *> *steps;

/**
    JSON数组，转模型数组
 */
+ (NSMutableArray<GGSMenu *> *)modelArrFromJSONArr:(NSArray *) jsonArr;
@end
