//
//  DOSCallback.h
//  Dosmono
//
//  Created by Sharp on 2020/7/20.
//  Copyright © 2020 shuanghoukj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DOSError, DOSResult;

NS_ASSUME_NONNULL_BEGIN

/*!
 * 在识别到最终结果后，回调该方法
*/
typedef void (^DOSCallbackOnResult)(DOSResult *result);

/*!
 * 在识别失败时，回调该方法
*/
typedef void (^DOSCallbackOnError)(DOSError *error);

/*!
 * 在音量变化时，回调该方法
*/
typedef void (^DOSCallbackOnVolume)(NSInteger volume);

@interface DOSCallback : NSObject

@end

NS_ASSUME_NONNULL_END
