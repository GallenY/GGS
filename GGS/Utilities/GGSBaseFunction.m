//
//  GGSBaseFunction.m
//  GGS
//
//  Created by 高阳 on 15/12/22.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import "GGSBaseFunction.h"

@implementation GGSBaseFunction

+ (int)random:(int)x {
    return arc4random() % x;
}

+ (CGSize)sizeOfText:(NSString *)str maxSize:(CGSize)maxSize font:(UIFont *)font
{
    NSDictionary *dict = @{NSFontAttributeName:font};
    return [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}
@end
