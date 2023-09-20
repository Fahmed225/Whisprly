//
//  DOSIBleRecordCallback.h
//  Dosmono
//
//  Created by Sharp on 2020/7/20.
//  Copyright © 2020 shuanghoukj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class DOSBleExtraBean;

/*!
 * 录音结果回调
*/
typedef void (^RecordOnResult)(NSString *result);

/*!
 * 翻译结果回调
*/
typedef void (^RecordOnTranslate)(NSString *result);

/*!
 * 开始录音结果回调
 * filename 本次录音的文件名
 * path 录音存储的位置
 * fileType 文件类型，1-音频 ，2-蓝牙，3-解码
*/
typedef void (^RecordOnFilePath)(NSString *fileName, NSString *path, NSInteger fileType);

/*!
 * 蓝牙录音临时识别结果回调
*/
typedef void (^RecordOnInterim)(NSString *interim);

/*!
 * 蓝牙录音实时传输音频
*/
typedef void (^RecordOnAudioData)(NSData *data);


/*!
 * 解码进度回调 0-1.0
*/
typedef void (^RecordOnDecodeProgress)(double size);

/*!
 * 解码-转码成指定格式后的本地路径
*/
typedef void (^RecordOnDecodeFilePath)(NSString *filePath, DOSAudioFormat format);

/*!
 * 蓝牙上传文件进度
*/
typedef void (^RecordOnUploadProgress)(double progress);

/*!
 * 上传数据回调
*/
typedef void (^RecordOnUploadData)(NSData *data);

/*!
 * 额外信息
*/
typedef void (^RecordOnExtraBean)(DOSBleExtraBean *extraBean);

/*!
 * 录音异常回调
*/
typedef void (^RecordOnError)(NSInteger errNo);

@interface DOSIBleRecordCallback : NSObject

@end

NS_ASSUME_NONNULL_END
