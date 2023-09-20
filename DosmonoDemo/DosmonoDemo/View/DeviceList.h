//
//  DeviceList.h
//  DosmonoDemo
//
//  Created by 孙鹏 on 2020/11/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DeviceListOnConnectTap)(CBPeripheral *peripheral);

@interface DeviceList : UITableView

@property (nonatomic, strong) NSMutableArray<CBPeripheral *> *dataArray;

@property (nonatomic, copy) DeviceListOnConnectTap onConnectTap;

- (void)appendDevice:(CBPeripheral *)peripheral;

@end

NS_ASSUME_NONNULL_END
