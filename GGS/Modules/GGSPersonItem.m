//
//  GGSPersonItem.m
//  GGS
//
//  Created by 高阳 on 15/12/23.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import "GGSPersonItem.h"

@implementation GGSPersonItem

- (instancetype)initWithTitle:(NSString *)title cellId:(NSString *)cellId
{
    if (self = [super init]) {
        self.title = title;
        self.cellId = cellId;
    }
    return self;
}

+ (instancetype)itemWithTitle:(NSString *)title cellId:(NSString *)cellId
{
    return [[self alloc] initWithTitle:title cellId:cellId];
}

@end
