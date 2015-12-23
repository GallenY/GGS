//
//  GGSMovie.h
//  GGS
//
//  Created by 高阳 on 15/12/22.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGSMovie : NSObject

/*
 "reason": "成功",
 "result": [{
 "name": "寻龙诀3D",
 "totals": "19121",
 "statistics": "6463",
 "averaging": "22",
 "attendance": "13%",
 "people": "139236",
 "fare": "46",
 "boxoffice": "6389569"
 */

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) float boxoffice;
@property (nonatomic, copy) NSString *attendance;
@property (nonatomic, assign) NSInteger rank;
@end
