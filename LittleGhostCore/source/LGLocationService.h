//
//  DTLocationService.h
//  MofCom
//
//  Created by gft  on 12-11-28.
//  Copyright (c) 2012年 MofCom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LGLocationServiceDelegate <NSObject>

@optional
- (void)didUpdateToLocation:(id)locationService;

- (void)didFailWithError:(NSError *)error locationService:(id)locationService;

@end

@interface LGLocationService : NSObject <CLLocationManagerDelegate>{
    id _delegate;
    double _latitude;
    double _longitude;
}

@property (retain, nonatomic) CLLocationManager *lm;

@property (readonly, assign, nonatomic) double latitude;

@property (readonly, assign, nonatomic) double longitude;

@property (assign, nonatomic) id <LGLocationServiceDelegate>delegate;

- (void)startLocation;

@end
