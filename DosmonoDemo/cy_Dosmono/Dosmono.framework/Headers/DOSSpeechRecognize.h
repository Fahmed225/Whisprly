//
//  DOSSpeechRecognize.h
//  Dosmono
//
//  Created by Sharp on 2020/7/20.
//  Copyright © 2020 shuanghoukj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DOSSpeechRecognize : NSObject

/*!
 * 在识别到最终结果后，回调该方法
*/
@property (nonatomic, copy) DOSCallbackOnResult onResult;

/*!
 * 在识别失败时，回调该方法
*/
@property (nonatomic, copy) DOSCallbackOnError onError;

/*!
 * 在音量变化时，回调该方法
*/
@property (nonatomic, copy) DOSCallbackOnVolume onVolume;

/*!
 * 语音识别对象单例
*/
+ (instancetype)sharedInstance;


/*!
 * 开始识别
*/
- (void)startRecognizer:(DOSRequest *)request;

/*!
 * 停止识别
*/
- (void)stopRecognizer;

/*!
 * 写入外部音频
*/
- (void)pushAudio:(NSData *)audio;

/*!
 *  不再使用时，调用该方法销毁对象，释放资源
 */
- (void)destroy;

@end

NS_ASSUME_NONNULL_END
