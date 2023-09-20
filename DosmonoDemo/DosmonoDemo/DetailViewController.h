//
//  DetailViewController.h
//  DosmonoDemo
//
//  Created by 孙鹏 on 2020/11/23.
//

#import <UIKit/UIKit.h>
#import "InstructionsList.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController <InstructionsListDelegate>

@property (nonatomic, strong) CBPeripheral *peripheral;
//+ (NSString *)giveMeFileName:(void(^)(NSString *))callback;

@end

NS_ASSUME_NONNULL_END
