//
//  GGSPersonGroupItem.h
//  GGS
//
//  Created by 高阳 on 15/12/23.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GGSPersonItem.h"

@interface GGSPersonGroupItem : NSObject

@property (nonatomic, strong) NSArray<GGSPersonItem *> *items;
@end
