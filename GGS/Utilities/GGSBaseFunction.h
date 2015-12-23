//
//  GGSBaseFunction.h
//  GGS
//
//  Created by 高阳 on 15/12/22.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GGSBaseFunction : NSObject

/**
 *  取一个随机整数 0~x-1
 *
 *  @param x
 *
 *  @return
 */
+ (int)random:(int)x;

+ (CGSize)sizeOfText:(NSString *)str maxSize:(CGSize) maxSize font:(UIFont *)font;
@end
