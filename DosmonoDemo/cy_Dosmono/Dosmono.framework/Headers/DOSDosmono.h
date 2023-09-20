//
//  DOSDosmono.h
//  Dosmono
//
//  Created by Sharp on 2020/7/20.
//  Copyright © 2020 shuanghoukj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOSConfig.h"

NS_ASSUME_NONNULL_BEGIN

@class DOSConfig;

@interface DOSDosmono : NSObject

/*!
 * 鉴权状态，NO = 未鉴权，YES = 已鉴权
*/
@property (nonatomic, assign, readonly) BOOL authenticationState;

/*!
 * 单例
*/
+ (instancetype)sharedInstance;

/*!
 * 初始化鉴权，该方法只需要在使用前初始化一次
 * accesskey，密钥应用名，由双猴提供，必填
 * secretKey，密钥，由双猴提供，必填
 *
*/
- (void)initWithConfig:(DOSConfig *)config callback:(void(^)(BOOL isSuccess))result;


@end

NS_ASSUME_NONNULL_END
