//
//  DOSBleClientImpl.h
//  Dosmono
//
//  Created by Sharp on 2020/7/20.
//  Copyright © 2020 shuanghoukj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DOSBleClientImpl : NSObject

/*!
 * 蓝牙服务对象单例
*/
+ (instancetype)sharedInstance;

/*!
 * 设置蓝牙前台运行服务图标
*/
- (void)setServiceLogo:(NSString *)logo;

/*!
 * 设置蓝牙前台运行服务提示语
*/
- (BOOL)setServiceTips:(NSString *)tips;

/*!
 * 释放资源
*/
- (void)releaseResources;

@end

NS_ASSUME_NONNULL_END
