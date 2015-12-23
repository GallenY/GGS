//
//  GGSPersonItem.h
//  GGS
//
//  Created by 高阳 on 15/12/23.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGSPersonItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cellId;

- (instancetype)initWithTitle:(NSString *)title cellId:(NSString *)cellId;
+ (instancetype)itemWithTitle:(NSString *)title cellId:(NSString *)cellId;

@end
