//
//  DeviceList.m
//  DosmonoDemo
//
//  Created by 孙鹏 on 2020/11/23.
//

#import "DeviceList.h"
#import "DeviceListCell.h"
#import "DetailViewController.h"
#import "AudioListViewController.h"

@interface DeviceList () <UITableViewDelegate, UITableViewDataSource>


@end

@implementation DeviceList

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        self.tableFooterView = [[UIView alloc] init];
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.estimatedSectionHeaderHeight=0;
        
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
      
    }
    
    
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timerCalled) userInfo:nil repeats:NO];

    
    return self;
}

-(void)timerCalled{
    AudioListViewController *vc = [[AudioListViewController alloc] init];
//    vc.peripheral = peripheral;
//    vc.title = peripheral.name;
    [[Helper viewController:self].navigationController pushViewController:vc animated:YES];
}


- (NSMutableArray<CBPeripheral *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF
    DeviceListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeviceListCell"];
    if (!cell) {
        cell = [[DeviceListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DeviceListCell"];
        
        
    }
    cell.index = indexPath.row;
    cell.onConnect = ^(CBPeripheral *peripheral) {
        weakSelf.onConnectTap(peripheral);
    };
    
    [cell reloadDataWithModel:_dataArray[indexPath.row]];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CBPeripheral *peripheral = _dataArray[indexPath.row];
    if (peripheral.state != CBPeripheralStateConnected) {
        [SVProgressHUD showErrorWithStatus:@"外设未连接"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.peripheral = peripheral;
    vc.title = peripheral.name;
    [[Helper viewController:self].navigationController pushViewController:vc animated:YES];
    
}

- (void)appendDevice:(CBPeripheral *)peripheral {
    
    __block BOOL isExisted = NO;
    [self.dataArray enumerateObjectsUsingBlock:^(CBPeripheral * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (peripheral.identifier == obj.identifier) {
            isExisted = YES;
        }
    }];
    
    if (!isExisted) {
        [self.dataArray addObject:peripheral];
        [self reloadData];
    }
    
}

@end
