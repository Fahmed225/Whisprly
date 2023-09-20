//
//  DeviceListCell.h
//  DosmonoDemo
//
//  Created by 孙鹏 on 2020/11/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DeviceListCellConnect)(CBPeripheral *peripheral);

@interface DeviceListCell : UITableViewCell

@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) CBPeripheral *peripheral;


@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) DeviceListCellConnect onConnect;

- (void)reloadDataWithModel:(CBPeripheral *)peripheral;

@end
NS_ASSUME_NONNULL_END
