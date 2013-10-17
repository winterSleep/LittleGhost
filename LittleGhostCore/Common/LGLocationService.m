//
//  DTLocationService.m
//  MofCom
//
//  Created by gft  on 12-11-28.
//  Copyright (c) 2012年 MofCom. All rights reserved.
//

#import "LGLocationService.h"

@implementation LGLocationService

- (void)dealloc{
    TT_RELEASE_SAFELY(_lm);
    [super dealloc];
}

- (void)startLocation{
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        self.lm = [[[CLLocationManager alloc] init] autorelease];
        _lm.delegate = self;
        _lm.desiredAccuracy = kCLLocationAccuracyBest;
        _lm.distanceFilter = 500000;
        [_lm startUpdatingLocation];
    }else{
        //只提示一次
        BOOL hasHinted = [[NSUserDefaults standardUserDefaults] boolForKey:@"hasHinted"];
        if (!hasHinted) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位失败" message:@"请在\"设置->定位服务\"中确认\"定位\"和\"新农村商网\"是否为开启状态!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show  ];
            [alert release];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasHinted"];
        }
        
        [self locationManager:self.lm didFailWithError:nil];
    }
	
}

- (void)locationManager:(CLLocationManager*)manager
   didUpdateToLocation:(CLLocation*)newLocation
		  fromLocation:(CLLocation*)oldLocation
{
    _latitude = newLocation.coordinate.latitude;
    
	_longitude = newLocation.coordinate.longitude;
    
    [_lm stopUpdatingLocation];
    
    if ([_delegate respondsToSelector:@selector(didUpdateToLocation:)]) {
        [_delegate didUpdateToLocation:self];
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    
    //默认给一个北京的经纬度
    _latitude = 39.907072f;
    
	_longitude = 116.444482f;
    
    if ([_delegate respondsToSelector:@selector(didFailWithError:locationService:)]) {
        [_delegate didFailWithError:error locationService:self];
    }
}


@end
