//
//  MTBroadcastHandler.h
//  MinewSensorKit
//
//  Created by Minewtech on 2019/8/6.
//  Copyright © 2019 Minewtech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTBroadcastHandler : NSObject

// name of device, sometimes available
@property (nonatomic, copy, readonly) NSString *name;

// current rssi value
@property (nonatomic, assign, readonly) NSInteger rssi;

// mac string, sometimes available
@property (nonatomic, copy, readonly) NSString *mac;

// identifier string, sometimes available
@property (nonatomic, copy, readonly) NSString *identifier;

// firmVersion string, sometimes available
@property (nonatomic, copy, readonly) NSString *firmVersion;

// hardwareVersion string, sometimes available
@property (nonatomic, copy, readonly) NSString *hardwareVersion;

// screenInfo string, sometimes available
@property (nonatomic, copy, readonly) NSString *screenInfo;

// battery voltage : mV
@property (nonatomic, assign, readonly) int battery;

// chipTemp
@property (nonatomic, assign, readonly) double chipTemp;

// heartbeat
@property (nonatomic, copy, readonly) NSString *heartbeat;

// tagRSSI
@property (nonatomic, assign, readonly) NSInteger tagRssi;

// chipInfo string, sometimes available
@property (nonatomic, copy, readonly) NSString *chipInfo;

// imageID
@property (nonatomic, strong, readonly) NSData *imageIdData;

// error Code
@property (nonatomic, assign, readonly) NSInteger errorCode;

// trigger broadcast type
@property (nonatomic, copy, readonly) NSString *peripheralSupport;

@end
