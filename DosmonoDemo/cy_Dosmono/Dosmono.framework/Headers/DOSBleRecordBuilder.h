//
//  DOSBleRecordBuilder.h
//  Dosmono
//
//  Created by Sharp on 2020/7/22.
//  Copyright © 2020 shuanghoukj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DOSBleRecordBuilder : NSObject <NSCoding, NSCopying>

/*!
 * 识别语言id (默认为普通话)
*/
@property (nonatomic, assign) DOSLanguage srcLangId;

/*!
 * 翻译语言id (默认为英文)
*/
@property (nonatomic, assign) DOSLanguage destLangId;

/*!
 * 配置保存录音的编码格式-mp3、wav
 * 默认为.amr
*/
@property (nonatomic, strong) NSString *encodeFormat;

/*!
 * 是否开识别
 * 默认开启
*/
@property (nonatomic, assign) BOOL isStartRecognize;

/*!
 * 是否开启翻译
 * 默认不开启
*/
@property (nonatomic, assign) BOOL isStartTranslate;

/*!
 * 是否需要发送指令
 * isSend 默认需要发送，如果是录音笔硬件方式启动，就填false，需要根据当前录音状态来进行判断
*/
@property (nonatomic, assign) BOOL isSendCmd;

/*!
 * 服务器地址
*/
@property (nonatomic, strong) NSString *serverUrl;

/*!
 * 令牌
*/
@property (nonatomic, strong) NSString *externalToken;

/*!
 * 设备序列号
*/
@property (nonatomic, strong) NSString *deviceSerialNumber;



@end

NS_ASSUME_NONNULL_END
