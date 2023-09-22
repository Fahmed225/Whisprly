//
//  ViewController.m
//  DosmonoDemo
//
//  Created by 孙鹏 on 2020/11/20.
//

#import "ViewController.h"
#import "DeviceList.h"
#import "DetailViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *searchBtn;

@property (nonatomic, strong) DeviceList *deviceList;

@property (nonatomic, assign) BOOL isSearching;



@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setCallback];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"蓝牙外设列表";
    self.view.backgroundColor = [Helper r:240 g:240 b:240 a:1];
    self.navigationController.navigationBar.translucent = NO;

    [self setLayout];
    
    [self authentication];
    
    
    WEAKSELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[[DOSBleConnectImpl sharedInstance] findConnectedPeripherals] enumerateObjectsUsingBlock:^(CBPeripheral * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            STRONGSELF
            [strongSelf.deviceList appendDevice:obj];

        }];
        [self.deviceList reloadData];
    });
    
    //TEsting
    


}

- (void)setLayout {
    
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.layer.borderColor = UIColor.blueColor.CGColor;
    _searchBtn.layer.borderWidth = 1;
    _searchBtn.layer.cornerRadius = 5;
    [_searchBtn setTitle:@"搜索" forState:0];
    [_searchBtn setTitleColor:UIColor.blueColor forState:0];
    [_searchBtn addTarget:self action:@selector(startSearch) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_searchBtn];
    [self.view addSubview:self.deviceList];
    
    [SVProgressHUD setContainerView:self.navigationController.view];
    
    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
    }];
    
    [_deviceList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_searchBtn.mas_bottom).offset(30);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (DeviceList *)deviceList {
    if (!_deviceList) {
        _deviceList = [[DeviceList alloc] initWithFrame:CGRectZero];
        _deviceList.onConnectTap = ^(CBPeripheral * _Nonnull peripheral) {
            [SVProgressHUD show];
            if (peripheral.state != CBPeripheralStateConnected) {
                [[DOSBleConnectImpl sharedInstance] connectDevice:peripheral];
                [[DOSBleConnectImpl sharedInstance] AutoReconnect:peripheral];
            } else {
                [[DOSBleConnectImpl sharedInstance] AutoReconnectCancel:peripheral];
                [[DOSBleConnectImpl sharedInstance] disconnectDevice:peripheral];
                
            }
        };
    }
    return _deviceList;
}

- (void)authentication {
    
    [SVProgressHUD show];
    DOSConfig *config = [[DOSConfig alloc] initWithAccessKey:@"com.dosmono.lianying.sdk.ios" secretKey:@"473a4acaad6923b14f4d60bb0e6ecdcdc47213e6b3789d16f07aa1982f69da20"];

    WEAKSELF
    [[DOSDosmono sharedInstance] initWithConfig:config callback:^(BOOL isSuccess) {
        
        NSLog(@"鉴权结果== %d",isSuccess);
        NSLog(@"authenticationState= %d", [DOSDosmono sharedInstance].authenticationState);
        NSLog(@"DOSSpeechRecognize= %@", [DOSSpeechRecognize sharedInstance]);
        
        if (isSuccess) {
            
            
            /*!
             * 开始蓝牙搜索
             * 此功能在DOSBleConnectImpl实例化1s后可正常使用
             * 启动后1s内会处理系统已连接但app未持有的设备，启动1s内进行搜索会被打断
             *
            */
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf startSearch];
            });
            
        } else {
            [SVProgressHUD showSuccessWithStatus:@"鉴权失败!"];
            [SVProgressHUD dismissWithDelay:1.5];
        }
        
    }];
    
    
}

- (void)setCallback {
    
    WEAKSELF
    [DOSBleSearchImpl sharedInstance].onFoundDevice = ^(CBPeripheral * _Nonnull peripheral, NSDictionary * _Nonnull advertisementData, NSNumber * _Nonnull RSSI) {
        STRONGSELF
        NSLog(@"*搜索到设备-> %@",  peripheral);
//        [[DOSBleConnectImpl sharedInstance] connectDevice:peripheral];
        [strongSelf.deviceList appendDevice:peripheral];
        
    };
    
    [DOSBleSearchImpl sharedInstance].onSearchStop = ^{
        NSLog(@"*搜索结束");
        STRONGSELF
        [strongSelf.searchBtn setTitle:@"搜索" forState:0];
        [SVProgressHUD dismiss];
        strongSelf.isSearching = NO;
        
        
        
    };
    
    
    [DOSBleConnectImpl sharedInstance].onConnectSuccess = ^{
        NSLog(@"蓝牙外设连接成功");
        [SVProgressHUD dismiss];
        
        STRONGSELF
        [strongSelf.deviceList reloadData];
        
    };
    
    [DOSBleConnectImpl sharedInstance].onConnectStatus = ^(CBPeripheralState state) {
        NSLog(@"蓝牙外设连接状态：%ld", state);
        [SVProgressHUD dismiss];
        STRONGSELF
        [strongSelf.deviceList reloadData];
    };
    
    [DOSBleConnectImpl sharedInstance].onConnectFail = ^{
        NSLog(@"蓝牙外设连接失败");
    };
    
    [DOSBleConnectImpl sharedInstance].onCmdReceive = ^(NSString * _Nonnull value, DOSBleFlag flag) {
        NSLog(@"蓝牙交互结果== %@ %ld", value, flag);
        

    };
    
    [DOSBleRecordImpl sharedInstance].onResult = ^(NSString * _Nonnull result) {
        NSLog(@"录音结果: %@", result);
    };
    
    [DOSBleRecordImpl sharedInstance].onAudioData = ^(NSData * _Nonnull data) {
//        NSLog(@"音频data: %@", data);
    };
    
//    [DOSBleRecordImpl sharedInstance].onDecodeFilePath = ^(NSString * _Nonnull filePath) {
//        NSLog(@"解码完成文件路径: %@", filePath);
//        
//        NSData *data = [NSData dataWithContentsOfFile:filePath];
//        NSLog(@"onDecodeFilePath data= %@", data);
//        
//    };
    
    [DOSBleRecordImpl sharedInstance].onUploadProgress = ^(double progress) {
        NSLog(@"%f", progress);
    };
    
    

}

- (void)startSearch {
    
    if (_isSearching) {
        [[DOSBleSearchImpl sharedInstance] stopSearch];
        [self.deviceList reloadData];
        return;
    }
    [SVProgressHUD show];
//    [[DOSBleSearchImpl sharedInstance] setFilterOnDiscoverPeripherals:@"智能录音笔0014"];
    [[DOSBleSearchImpl sharedInstance] setTimes:1];
    [[DOSBleSearchImpl sharedInstance] setDuration:3];
    [[DOSBleSearchImpl sharedInstance] startSearch];
    [_searchBtn setTitle:@"停止搜索" forState:0];
    _isSearching = YES;
}


@end
