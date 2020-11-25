//
//  MTOTAManager.h
//  MinewESLSingleKit
//
//  Created by minew on 2020/6/29.
//  Copyright © 2020 Minewtech. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MTUpdateType) {
    StencilUpdate = 1,
    OTAUpdate,
};

NS_ASSUME_NONNULL_BEGIN

// ota progress change block
typedef void(^OTAProgressBlock)(float);

@class MTConnectionHandler;

@interface MTOTAManager : NSObject


+ (void)startOTAUpdate:(MTConnectionHandler *)connectionHandler UpdateType:(MTUpdateType)updateType OTAData:(NSData *)otaData progressHandler:(OTAProgressBlock)progressHandler;


@end

NS_ASSUME_NONNULL_END
