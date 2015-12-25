//
//  GGSAirViewController.m
//  GGS
//
//  Created by 高阳 on 15/12/20.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import "GGSAirViewController.h"
#import "GGSAir.h"
#import <MJExtension/MJExtension.h>
#import <CoreLocation/CoreLocation.h>

@interface GGSAirViewController () <CLLocationManagerDelegate>
/** UILabel */
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *aqiLabel;
@property (weak, nonatomic) IBOutlet UILabel *qualityLabel;
@property (weak, nonatomic) IBOutlet UILabel *pmLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

/** 定位管理 */
@property (nonatomic, strong) CLLocationManager *locationManager;

/** 数据 */
@property (nonatomic, strong) GGSAir *air;

@property (nonatomic, strong) NSDictionary *cityDict;
@end

@implementation GGSAirViewController

#pragma mark - 懒加载
- (NSDictionary *)cityDict
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"GGSCity.plist" ofType:nil];
        _cityDict = [NSDictionary dictionaryWithContentsOfFile:path];
    });
    return _cityDict;
}

#pragma mark - Constants
static NSString *const GGS_AIR_URL = @"http://apis.haoservice.com/air/cityair";
static NSString *const GGS_AIR_KEY = @"f1a921fee5e54db9811082579a863c7d";

#pragma mark - VC lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self locate];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.locationManager.delegate = nil;
    self.locationManager = nil;
}

#pragma mark - private
- (void)locate{
    /*
     1.CoreLoaction
     2.判断定位是否可用
     3.初始化manager
        *设置精度，
        *设置刷新频率，单位米（在多少米内移动不刷新）
        *设置代理
     4.权限，需要在.plist设置允许权限
     5.开启定位
     */
    if ([CLLocationManager locationServicesEnabled]) {
        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
        locationManager.distanceFilter = 10000;
        locationManager.delegate = self;
        if (SYSTEM_VERSION > 8.0) {
            [locationManager requestWhenInUseAuthorization];
        }
        [locationManager startUpdatingLocation];
        self.locationManager = locationManager;
        [self showHUDWithText:@""];
    }else {
        [self showHUDWithText:@"定位服务未开启" delay:2.0];
    }
}

/**
    根据城市信息，获取空气质量报告
 */
- (void)getDataWithCity:(NSString *)cityEN{
    [super getData];
    
    //地名拼音转中文(有就转，没就是空)
    NSString *city = self.cityDict[cityEN];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"city"] = city;
    param[@"key"] = GGS_AIR_KEY;
    [self.manager POST:GGS_AIR_URL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSNumber *error_code = responseObject[@"error_code"];
        if ([error_code intValue] == 0) {
            self.air = [GGSAir mj_objectWithKeyValues:responseObject[@"result"]];
            [self updateLabel];
            [self hideHud];
        }else{
            [self showHUDWithText:responseObject[@"reason"] delay:2.0];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showHUDWithText:error.domain delay:2.0];
    }];
}

/**
    更新Label
 */
- (void)updateLabel{
    self.cityLabel.text = [NSString stringWithFormat:@"当前城市: %@",self.air.CityName];
    self.aqiLabel.text = [NSString stringWithFormat:@"AQI: %@",self.air.AQI];
    self.qualityLabel.text = [NSString stringWithFormat:@"空气质量: %@",self.air.Quality];
    self.pmLabel.text = [NSString stringWithFormat:@"PM2.5: %@",self.air.PM25];
    self.timeLabel.text = [NSString stringWithFormat:@"更新时间: %@",self.air.UpdateTime];
}

#pragma mark - BtnClick
- (IBAction)reLocate:(id)sender {
    NSLog(@"重新定位");
    [self locate];
}


#pragma mark -CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"开始定位");
    //判断位置
    CLLocation *location = [locations lastObject];//获取最后位置信息。
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        NSLog(@"count = %lu",placemarks.count);
        if (placemarks.count > 0) {
            CLPlacemark *mark = [placemarks firstObject];
            NSString *city = mark.locality;
            NSLog(@" city = %@,定位结束",city);
            
            [self getDataWithCity:city];
//            //不用接口直接测试(调整Label)
//            [self hideHud];
//            self.air = [[GGSAir alloc] init];
//            self.air.CityName = @"北京";
//            self.air.AQI = @"345";
//            self.air.Quality = @"严重污染";
//            self.air.PM25 = @"298μg/m&sup3";
//            self.air.UpdateTime = @"2015-12-23 11:00";
//            [self updateLabel];
        }
    }];
    [manager stopUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //定位失败
    if (error.code == kCLErrorDenied) {
        // Access to location or ranging has been denied by the user
        [self showHUDWithText:@"地址访问被拒绝" delay:2.0];
    }else if (error.code == kCLErrorLocationUnknown) {
        [self showHUDWithText:@"无法获取位置信息" delay:2.0];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
