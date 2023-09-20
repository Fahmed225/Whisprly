//
//  DOSBleSearchImpl.h
//  Dosmono
//
//  Created by Sharp on 2020/7/20.
//  Copyright © 2020 shuanghoukj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CBManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface DOSBleSearchImpl : NSObject

/*!
 * 搜索开始回调
*/
@property (nonatomic, copy) OnSearchStart onSearchStart;

/*!
 * 搜索到的设备列表
*/
@property (nonatomic, copy) OnFoundDevices onFoundDevices;

/*!
 * 搜索到的设备
 * CBPeripheral *peripheral,
 * NSDictionary *advertisementData,
 * NSNumber *RSSI
*/
@property (nonatomic, copy) OnFoundDevice onFoundDevice;

/*!
 * 搜索停止回调
*/
@property (nonatomic, copy) OnSearchStop onSearchStop;

/*!
 * 搜索取消回调
*/
@property (nonatomic, copy) OnSearchCancel onSearchCancel;

/*!
 * 蓝牙搜索对象单例
*/
+ (instancetype)sharedInstance;

/*!
 * 设置蓝牙单次搜索时长，默认20s
*/
- (void)setDuration:(int)second;

/*!
 * 设置蓝牙搜索次数，默认一次
*/
- (void)setTimes:(NSInteger)num;

/*!
 * 开始蓝牙搜索
 * 此功能在DOSBleConnectImpl实例化1s后可正常使用
 * 启动后1s内会处理系统已连接但app未持有的设备，启动1s内进行搜索会被打断
 * 
*/
- (void)startSearch;

/*!
 * 停止蓝牙搜索
*/
- (void)stopSearch;

/*!
 *
 * 根据前缀过滤外设，只返回包含此前缀的外设
*/
- (void)setFilterOnDiscoverPeripherals:(NSString *)prefix;


@end

NS_ASSUME_NONNULL_END
