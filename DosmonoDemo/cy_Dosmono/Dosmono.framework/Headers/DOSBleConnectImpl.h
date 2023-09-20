//
//  DOSBleConnectImpl.h
//  Dosmono
//
//  Created by Sharp on 2020/7/20.
//  Copyright © 2020 shuanghoukj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CBPeripheral.h>

NS_ASSUME_NONNULL_BEGIN

@class DOSBleFlags;

API_AVAILABLE(ios(10.0))
@interface DOSBleConnectImpl : NSObject

/*!
 * 监听蓝牙连接状态回调
*/
@property (nonatomic, copy) OnConnectStatus onConnectStatus;

/*!
 * 监听主设备状态回调
*/
@property (nonatomic, copy) OnCentralStatus onCentralStatus;


/*!
 * 蓝牙连接失败回调
*/
@property (nonatomic, copy) OnConnectFail onConnectFail;

/*!
 * 蓝牙连接成功回调
*/
@property (nonatomic, copy) OnConnectSuccess onConnectSuccess;

/*!
 * 蓝牙连接超时回调
*/
@property (nonatomic, copy) OnConnectTimeout onConnectTimeout;

/*!
 * 蓝牙交互结果回调
*/
@property (nonatomic, copy) OnCmdReceive onCmdReceive;

/*!
 * 蓝牙交互结果回调
*/
@property (nonatomic, copy) OnFileList onFileList;

/*!
 * 蓝牙连接对象单例
*/
+ (instancetype)sharedInstance;

/*!
 * 蓝牙连接
*/
- (void)connectDevice:(CBPeripheral *)peripheral;

/*!
 * 取消蓝牙连接
*/
- (void)disconnectDevice:(CBPeripheral *)peripheral;

/*!
 * 添加断开自动重连的外设
 */
- (void)AutoReconnect:(CBPeripheral *)peripheral;

/*!
 * 删除断开自动重连的外设
 */
- (void)AutoReconnectCancel:(CBPeripheral *)peripheral;

/*!
 * 获取当前连接的peripherals
 * app启动后需要延迟1s才能够获取到已配对过的peripherals
*/
- (NSArray<CBPeripheral *> *)findConnectedPeripherals;

/*!
 * 蓝牙交互
*/
- (void)sendCmdWithValue:(NSString *)value flags:(DOSBleFlag)flags;

/*!
 * 切换当前操作的外设，适用于同时连接多台设备的场景，不可同时进行录音操作
*/
- (void)switchCurrentPeripheral:(CBPeripheral *)peripheral;



@end

NS_ASSUME_NONNULL_END
