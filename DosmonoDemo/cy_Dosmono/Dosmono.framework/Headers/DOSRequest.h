//
//  DOSRequest.h
//  Dosmono
//
//  Created by Sharp on 2020/7/20.
//  Copyright © 2020 shuanghoukj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOSConstant.h"

NS_ASSUME_NONNULL_BEGIN



@interface DOSRequest : NSObject

/*!
 * 要识别的语言ID，参考Language类常量定义
*/
@property (nonatomic, assign) NSInteger langId;

/*!
 * 本次识别的会话ID
*/
@property (nonatomic, assign) NSInteger sessionId;

/*!
 * 语音识别模式，支持两种模式，分别为:
 * 0-短模式：最大识别时间1分钟，主要应用在对话翻译
 * 1-长模式：不限识别时间，主要应用在录音
*/
@property (nonatomic, assign) NSInteger mode;

/*!
 * 是否需要保存音频文件，为ture时，需要设置filePath参数
*/
@property (nonatomic, assign) BOOL saveFile;

/*!
 * 当需要保存音频时，传入音频保存的路径
*/
@property (nonatomic, strong) NSString *filePath;

/*!
 * 指定保存音频文件的编码方式，支持wav、mp3，参考Constant类常量定义
*/
@property (nonatomic, assign) DOSEncodeWay encodeWay;

/*!
 * 指定是否使用外部音频语音识别，为true时，使用外部输入音频，为false内部通过录音机录音
*/
@property (nonatomic, assign) BOOL useExternalAudio;


@end


NS_ASSUME_NONNULL_END
