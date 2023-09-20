//
//  DOSIBleConnectCallback.h
//  Dosmono
//
//  Created by Sharp on 2020/7/20.
//  Copyright © 2020 shuanghoukj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CBManager.h>
#import <CoreBluetooth/CBCentralManager.h>


NS_ASSUME_NONNULL_BEGIN

/*!
 * 监听蓝牙连接状态回调
*/
typedef void (^OnConnectStatus)(CBPeripheralState state);

/*!
 * 监听主设备状态回调
*/
typedef void (^OnCentralStatus)(CBManagerState state);

/*!
 * 蓝牙连接失败回调
*/
typedef void (^OnConnectFail)(void);

/*!
 * 蓝牙连接成功回调
*/
typedef void (^OnConnectSuccess)(void);

/*!
 * 蓝牙连接超时回调
*/
typedef void (^OnConnectTimeout)(void);

/*!
 * 蓝牙交互结果回调
*/
typedef void (^OnCmdReceive)(NSString *value, DOSBleFlag flag);

/*!
 * 文件列表回调
*/
typedef void (^OnFileList)(NSArray<NSString *> *list);

@interface DOSIBleConnectCallback : NSObject

@end

NS_ASSUME_NONNULL_END
