//
//  DOSBleRecordImpl.h
//  Dosmono
//
//  Created by Sharp on 2020/7/20.
//  Copyright © 2020 shuanghoukj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DOSBleRecordImpl : NSObject

/*!
 * 录音结果回调
*/
@property (nonatomic, copy) RecordOnResult onResult;


/*!
 * 翻译结果回调
*/
@property (nonatomic, copy) RecordOnTranslate onTranslate;

/*!
 * 开始录音结果回调
 * filename 本次录音的文件名
 * path 录音存储的位置
 * fileType 文件类型，1-音频 ，2-蓝牙，3-解码
*/
@property (nonatomic, copy) RecordOnFilePath onFilePath;

/*!
 * 蓝牙录音临时识别结果回调
*/
@property (nonatomic, copy) RecordOnInterim onInterim;

/*!
 * 蓝牙录音实时传输音频
*/
@property (nonatomic, copy) RecordOnAudioData onAudioData;


/*!
 * 解码进度回调
*/
@property (nonatomic, copy) RecordOnDecodeProgress onDecodeProgress;

/*!
 * 解码-转码成指定格式后的本地路径
*/
@property (nonatomic, copy) RecordOnDecodeFilePath onDecodeFilePath;

/*!
 * 蓝牙上传文件进度回调
*/
@property (nonatomic, copy) RecordOnUploadProgress onUploadProgress;

/*!
 * 上传完成回调
*/
@property (nonatomic, copy) RecordOnUploadData onUploadData;

/*!
 * 额外信息
*/
@property (nonatomic, copy) RecordOnExtraBean onExtraBean;

/*!
 * 录音异常回调
*/
@property (nonatomic, copy) RecordOnError onError;

/*!
 * 开始录音配置信息
*/
@property (nonatomic, strong) DOSBleRecordBuilder *recordBuilder;


/*!
 * 蓝牙录音对象单例
*/
+ (instancetype)sharedInstance;


/*!
 * 停止识别
*/
- (void)stopRecognize;

/*!
 * 停止翻译
*/
- (void)stopTranslate;

/*!
 * 开始录音
*/
- (void)startRecord:(DOSBleRecordBuilder *)builder;
/*!
 * 暂停录音
*/
- (void)pauseRecognize;
/*!
 * 继续录音
*/
- (void)recoverRecognize;
/*!
 * 开始解码，
 * path 需要解码的路径
*/
- (void)startDecode:(NSString *)path;

/*!
 * 开始解码，
 * path 需要解码的data
*/
- (void)startDecodeOpus:(NSData *)data;

/*!
 * 设置后台解码时的休眠时间，参考值0.001
 * 调整CPU占用率
*/
- (void)setSleepForTimeInterval:(NSTimeInterval)t;

/*!
 * 取消解码
*/
- (void)cancelDecode;


/*!
 * 上传蓝牙录音笔文件
 * filename 要上传的文件名
 * startPoint 开始上传的位置(支持断点续传)
 * isKeep 为NO时，startPoint参数无效,
*/
- (void)startTransferWithFileName:(NSString *)fileName startPoint:(NSUInteger)startPoint keepFile:(BOOL)isKeep;

/*!
 * 根据蓝牙录音笔文件名获取本地文件路径
 * 用于断点续传，需要获取NSData时
*/
- (NSString *)getLocalFilePath:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
