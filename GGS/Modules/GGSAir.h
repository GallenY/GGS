//
//  GGSAir.h
//  GGS
//
//  Created by 高阳 on 15/12/22.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGSAir : NSObject

/*
 "Ranking": "319",
 "CityName": "北京",
 "ProvinceName": "空气质量pm2.5",
 "AQI": "440",
 "Quality": "严重污染",
 "PM25": "416μg/m&sup3",
 "UpdateTime": "2015-12-22 09:00"
 */
@property (nonatomic, copy) NSString *CityName;
@property (nonatomic, copy) NSString *AQI;
@property (nonatomic, copy) NSString *Quality;
@property (nonatomic, copy) NSString *PM25;
@property (nonatomic, copy) NSString *UpdateTime;

@end
