//
//  DetailViewController.m
//  DosmonoDemo
//
//  Created by 孙鹏 on 2020/11/23.
//

#import "DetailViewController.h"
#import "Whisprly-Swift.h"



@interface DetailViewController ()

@property (nonatomic, strong) NSArray *instructions;
@property (nonatomic, strong) NSMutableArray *audioFilesList;
@property (nonatomic, strong) InstructionsList *instructionsList;
@property (nonatomic,weak)  NSTimer *timer;

@end



@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    //切换到新的外设
    if (_peripheral != nil) {
        [[DOSBleConnectImpl sharedInstance] switchCurrentPeripheral:_peripheral];
        NSLog(@"详情== %@", _peripheral);

    }
    

    
    
//    self.instructions = [[NSArray alloc]init];
//    _instructions = @[
//        @"激活",
//        @"同步时间",
//        @"录音状态",
//        @"开始录音",
//        @"结束录音",
//        @"电量",
//        @"文件列表",
//        @"序列号",
//        @"禁用录音键",
//        @"启用录音键",
//        @"录音键状态",
//        @"上传文件",
//        @"停止上传",
//        @"删除文件",
//        @"开始解码",
//        @"停止解码",
//        @"获取文件",
//        @"暂停录音",
//        @"恢复录音",
//    ];
    
    
    WEAKSELF
    [DOSBleConnectImpl sharedInstance].onFileList = ^(NSArray<NSString *> * _Nonnull list) {
        weakSelf.instructions = (NSMutableArray *)list;
        NSLog(@"Audio files list: %@", list);
        [self.instructions arrayByAddingObjectsFromArray:list.copy];
        [self setLayout];
        NSLog(@"Number OF files: %lu", self.instructions.count);
        [SVProgressHUD dismiss];
        [self.timer invalidate];
    };
    
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timerCalled) userInfo:nil repeats:NO];
    
    [self setCallback];
    
//    [self setLayout];


    
}

-(void)timerCalled
{
    if (_instructions.count > 0) {
        [self.timer invalidate];
        self.timer = nil;
    } else {
        [SVProgressHUD show];
        [[DOSBleConnectImpl sharedInstance] sendCmdWithValue:@"" flags:DOSBleFlag_FILE_LIST];
    }
     NSLog(@"Timer Called");
    
     // Your Code
}


- (void)viewDidAppear:(BOOL)animated {
    
    self.audioFilesList = [[NSMutableArray alloc]init];
    [SVProgressHUD show];
    
    sleep(5);
    [[DOSBleConnectImpl sharedInstance] sendCmdWithValue:@"" flags:DOSBleFlag_FILE_LIST];
    
}

- (InstructionsList *)instructionsList {
    if (!_instructionsList) {
        _instructionsList = [[InstructionsList alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _instructionsList.backgroundColor = UIColor.redColor;
        _instructionsList.audioFileDelegate = self;
    }
    
    return _instructionsList;
}

- (void)setLayout {
    
    self.instructionsList.dataArray = _instructions;
    [self.instructionsList createFilesModelList:_instructions];
   // [_instructionsList reloadData];
    [self.view addSubview:_instructionsList];
    
    [self.instructionsList audioFileDelegate];
    [_instructionsList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(self.view.frame.size.height);
    }];
    
    [_instructionsList reloadData];
        
}

- (void)giveMeFileName:(NSString*)fileName {
    
    [self showAlertView:fileName];
}

-(void)showAlertView:(NSString *)path {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"File Path"
                                   message:path
                                   preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {}];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)setCallback {
    
    WEAKSELF
    [DOSBleConnectImpl sharedInstance].onCmdReceive = ^(NSString * _Nonnull value, DOSBleFlag flag) {
        NSLog(@"detail蓝牙交互结果=== %@ %ld", value, flag);
        
        if (flag == DOSBleFlag_STOP_TRANSFER) {
            weakSelf.instructionsList.decodePath = value;
            NSData *data = [NSData dataWithContentsOfFile:value];
            NSLog(@"pcm = %@", data);
        }
        
        
    };
    
    [DOSBleConnectImpl sharedInstance].onConnectSuccess = ^{
        NSLog(@"detail蓝牙外设连接成功");
        [SVProgressHUD dismiss];
        [[DOSBleConnectImpl sharedInstance] sendCmdWithValue:@"" flags:DOSBleFlag_ELECTRICITY];

    };
    
    [DOSBleRecordImpl sharedInstance].onDecodeProgress = ^(double size) {
        NSLog(@"onDecodeProgress= %f", size);
    };
    
    [DOSBleRecordImpl sharedInstance].onDecodeFilePath = ^(NSString * _Nonnull filePath, DOSAudioFormat format) {
        NSLog(@"onDecodeFilePath= %@", filePath);
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSLog(@"data.length = %ld", data.length);
        
        if (format == DOSAudioFormat_PCM) {
            [[DOSAudioEncoder sharedInstance] encodeFileWithInputPcm:data encodeFormat:DOSAudioFormat_AMR complete:^(BOOL success, NSString * _Nonnull path) {
                NSLog(@"amr path= %@", path);
                NSData *data = [NSData dataWithContentsOfFile:path];
                NSLog(@"amr = %@", data);
                [self.instructions arrayByAddingObject:path];
                NSLog(@"Number OF FIles %lu",(unsigned long)self.instructions.count);
                [self.instructionsList reloadData];
//                self.instructions = [_audioFilesList copy];
            }];
        }
    };
    
    [DOSBleRecordImpl sharedInstance].onUploadData = ^(NSData * _Nonnull data) {
        NSLog(@"onUploadData= %@", data);
        
        [[DOSBleRecordImpl sharedInstance] startDecodeOpus:data];

    };

    
}

- (void)getStatus {

    [[DOSBleConnectImpl sharedInstance] sendCmdWithValue:@"" flags:DOSBleFlag_RECORD_STATUS];
}

- (void)dealloc {
    
}

- (void) translateAudioToTextUsingOpenAIApi{
  //  [AppController translateAUdioFile];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
