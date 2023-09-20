//
//  DOSResult.h
//  Dosmono
//
//  Created by Sharp on 2020/7/21.
//  Copyright © 2020 shuanghoukj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DOSResult : NSObject

/*!
 * 本次识别的会话ID
*/
@property (nonatomic, assign) NSInteger sessionId;

/*!
 * 要识别的语言ID，参考Language类常量定义
*/
@property (nonatomic, assign) NSInteger langId;

/*!
 * 返回结果是否是流模式
*/
@property (nonatomic, assign) BOOL stream;

/*!
 * 本次识别的内容文本
*/
@property (nonatomic, strong) NSString *text;

/*!
 * 返回识别时的音频文件，可能为空
*/
@property (nonatomic, strong) NSString *audioPath;

@end

NS_ASSUME_NONNULL_END
