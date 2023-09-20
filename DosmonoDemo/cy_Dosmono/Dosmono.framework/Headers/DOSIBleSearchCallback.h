//
//  DOSIBleSearchCallback.h
//  Dosmono
//
//  Created by Sharp on 2020/7/20.
//  Copyright © 2020 shuanghoukj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CBPeripheral.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 * 搜索开始回调
*/
typedef void (^OnSearchStart)(void);

/*!
 * 搜索到的设备列表
*/
typedef void (^OnFoundDevices)(NSArray<CBPeripheral *> *devices);

/*!
 * 搜索到的设备
*/
typedef void (^OnFoundDevice)(CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI);

/*!
 * 搜索停止回调
*/
typedef void (^OnSearchStop)(void);

/*!
 * 搜索取消回调
*/
typedef void (^OnSearchCancel)(void);

@interface DOSIBleSearchCallback : NSObject


@end

NS_ASSUME_NONNULL_END
