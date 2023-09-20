//
//  DOSError.h
//  Dosmono
//
//  Created by Sharp on 2020/7/21.
//  Copyright © 2020 shuanghoukj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DOSError : NSObject

/*!
 *  错误码
 *  1001 -  未鉴权
 */
@property (nonatomic, assign) NSInteger errorCode;

/*!
 *  错误码类型
 */
@property (nonatomic, assign) NSInteger errorType;

/*!
 *  错误描述
 */
@property (nonatomic, retain) NSString *errorDesc;

/*!
 *  初始化
 *
 *  @param errorCode -[in] 错误码
 *
 *  @return DOSError对象
 */
- (instancetype)initWithError:(NSInteger) errorCode;



@end

NS_ASSUME_NONNULL_END
