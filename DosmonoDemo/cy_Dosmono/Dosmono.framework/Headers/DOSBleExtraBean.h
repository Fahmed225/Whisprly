//
//  DOSBleExtraBean.h
//  SUNTest1
//
//  Created by Sharp on 2020/8/5.
//  Copyright © 2020 Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DOSBleExtraBean : NSObject <NSCoding, NSCopying>

/*!
 * 服务器地址
*/
@property (nonatomic, strong) NSString *serverUrl;

/*!
 * 设备号
*/
@property (nonatomic, strong) NSString *srDeviceNo;

/*!
 * 识别结果
*/
@property (nonatomic, strong) NSString *srResult;

/*!
 * 识别准确率
*/
@property (nonatomic, strong) NSString *srAccuracy;

/*!
 * 开始时间
*/
@property (nonatomic, assign) NSInteger srBeginDate;

/*!
 * 结束时间
*/
@property (nonatomic, assign) NSInteger srEndDate;

/*!
 * 时长
*/
@property (nonatomic, assign) NSInteger srDuration;

/*!
 * 令牌
*/
@property (nonatomic, strong) NSString *externalToken;

/*!
 * 文件名
*/
@property (nonatomic, strong) NSString *fileName;



@end

NS_ASSUME_NONNULL_END
