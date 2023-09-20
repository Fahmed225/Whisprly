//
//  DOSAudioEncoder.h
//  Dosmono
//
//  Created by Sharp on 2021/2/4.
//  Copyright © 2021 shuanghoukj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOSConstant.h"

NS_ASSUME_NONNULL_BEGIN

@interface DOSAudioEncoder : NSObject

/*!
 * 编码器对象单例
*/
+ (instancetype)sharedInstance;

/*!
 * 编码方法
*/
- (void)encodeFileWithInputPath:(NSString *)pcmPath encodeFormat:(DOSAudioFormat)format complete:(void (^) (BOOL success, NSString *path))result;

- (void)encodeFileWithInputPcm:(NSData *)data encodeFormat:(DOSAudioFormat)format complete:(void (^) (BOOL success, NSString *path))result;

/*!
 * 设置后台解码时的休眠时间，参考值0.001
 * 调整CPU占用率
*/
- (void)setSleepForTimeInterval:(NSTimeInterval)t ;

- (void)cancelEncode;

@end

NS_ASSUME_NONNULL_END
