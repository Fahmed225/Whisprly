//
//  DeviceListCell.m
//  DosmonoDemo
//
//  Created by 孙鹏 on 2020/11/23.
//

#import "DeviceListCell.h"

@implementation DeviceListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _index = 0;
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.layer.cornerRadius = 5;
        _rightBtn.layer.borderWidth = 1;
        _rightBtn.layer.borderColor = UIColor.blueColor.CGColor;
        [_rightBtn setTitle:@"断开连接" forState:0];
        [_rightBtn setTitleColor:UIColor.blueColor forState:0];
        
        [self.contentView addSubview:_rightBtn];
        
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(40);
            make.centerY.equalTo(self.contentView);
            make.right.mas_equalTo(-20);
        }];
        
        [_rightBtn addTarget:self action:@selector(selectConnect) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    return self;
}

- (void)reloadDataWithModel:(CBPeripheral *)peripheral {
    self.peripheral = peripheral;
    self.textLabel.text = peripheral.name;
    switch (peripheral.state) {
        case CBPeripheralStateDisconnected:
            {
                [self.rightBtn setTitle:@"未连接" forState:0];
            }
            break;
        case CBPeripheralStateConnecting:
            {
                [self.rightBtn setTitle:@"正在连接" forState:0];
            }
            break;
        case CBPeripheralStateConnected:
            {
                [self.rightBtn setTitle:@"已连接" forState:0];
            }
            break;
        case CBPeripheralStateDisconnecting:
            {
                [self.rightBtn setTitle:@"正在断开" forState:0];
            }
            break;
            
        default:
            break;
    }
    
//    CBPeripheralStateDisconnected = 0,
//    CBPeripheralStateConnecting,
//    CBPeripheralStateConnected,
//    CBPeripheralStateDisconnecting NS_AVAILABLE(10_13, 9_0),
}

- (void)selectConnect {
    if (self.onConnect) {
        self.onConnect(self.peripheral);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
