//
//  AudioListViewController.m
//  DosmonoDemo
//
//  Created by Imran Ishaq on 22/09/2023.
//

#import "AudioListViewController.h"

@interface AudioListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSMutableArray<NSString *> *fileList;
@property (nonatomic,weak)  NSTimer *timer;
@property (nonatomic, strong) NSArray *instructions;


@end

@implementation AudioListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = UIColor.lightGrayColor;
    self.collectionView.backgroundColor = UIColor.lightGrayColor;
    self.collectionView.backgroundView.backgroundColor = UIColor.lightGrayColor;
//    self.navigationController.navigationBar.backgroundColor = UIColor.whiteColor;
    //切换到新的外设
    if (_peripheral != nil) {
        [[DOSBleConnectImpl sharedInstance] switchCurrentPeripheral:_peripheral];
        NSLog(@"详情== %@", _peripheral);
    }
    

    [self setCallback];
    
    self.instructions = [[NSArray alloc]init];
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
//        weakSelf.instructions = (NSMutableArray *)list;
//        NSLog(@"Audio files list: %@", list);
//        [self.instructions arrayByAddingObjectsFromArray:list.copy];
//        [self.collectionView reloadData];
        [self createFilesModelList:list];
        NSLog(@"Number OF files: %lu", list.count);
        [SVProgressHUD dismiss];
        [self.timer invalidate];
    };
    
    [self SetupCollectionView];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerCalled) userInfo:nil repeats:NO];
//    [self createFilesModelList:_instructions];
//    [self.collectionView reloadData];
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


-(void)SetupCollectionView{
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"AudioFilesListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"AudioFilesListCollectionViewCell"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)createFilesModelList:(NSArray*)list {
    _audioFilesList = [[NSMutableArray alloc]init];
    for(NSString *name in list) {
        AudioFileListModel *item = [[AudioFileListModel alloc] init];
        item.fileName = name;
        [_audioFilesList addObject:item];
    }
    
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _audioFilesList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    AudioFilesListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AudioFilesListCollectionViewCell" forIndexPath:indexPath];
    [cell reloadDataWithTitle:_audioFilesList[indexPath.section]];
    return cell;
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{

    return 0.0;//最小横向间距
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

+ (NSString *)giveMeFileName:(void (^)(void))callback {
    
    return @"";
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    AudioFileListModel * file = _audioFilesList[indexPath.section];
    
    [self giveMeFileName:file.getFilePath];

    return;
    switch (indexPath.row) {
        case 0:
        {
            NSLog(@"activation");
            [[DOSBleConnectImpl sharedInstance] sendCmdWithValue:@"" flags:DOSBleFlag_ACTIVE];
        }
            break;
        case 1:
        {
            NSLog(@"synchronised time");
            [[DOSBleConnectImpl sharedInstance] sendCmdWithValue:@"" flags:DOSBleFlag_SYNC_TIME];
        }
            break;
        case 2:
        {
            NSLog(@"Get recording status");
            [[DOSBleConnectImpl sharedInstance] sendCmdWithValue:@"" flags:DOSBleFlag_RECORD_STATUS];
        }
            break;
        case 3:
        {
            NSLog(@"start recording");
            DOSBleRecordBuilder *recordBuilder = [[DOSBleRecordBuilder alloc] init];
            recordBuilder.encodeFormat = @"mp3";
            [[DOSBleRecordImpl sharedInstance] startRecord:recordBuilder];
            
//            DOSBleRecordBuilder *builder = [[DOSBleRecordBuilder alloc]init];
//            builder.encodeFormat = @"amr";
//            builder.isSendCmd = YES;
//            builder.isStartRecognize = YES;
//            builder.serverUrl = @"https://test.zhaohu365.com/api//fsk-external/soundRecording/addSoundRecording/GD210118000075";
//            builder.externalToken = @"shuanghou.5fe8c1619a6a0d19cce89cbe9d586db2b2a00f08";
//            builder.deviceSerialNumber = @"318182005000410";
//            [[DOSBleRecordImpl sharedInstance] startRecord:builder];
        }
            break;

        case 4:
        {
            NSLog(@"end recording");
            [[DOSBleRecordImpl sharedInstance] stopRecognize];
        }
            break;
        case 5:
        {
            NSLog(@"Get power");
            [[DOSBleConnectImpl sharedInstance] sendCmdWithValue:@"" flags:DOSBleFlag_ELECTRICITY];
        }
            break;
        case 6:
        {
            NSLog(@"Get file list");
            [SVProgressHUD show];
            [[DOSBleConnectImpl sharedInstance] sendCmdWithValue:@"" flags:DOSBleFlag_FILE_LIST];
        }
            break;
        case 7:
        {
            NSLog(@"Get device serial number");
            [[DOSBleConnectImpl sharedInstance] sendCmdWithValue:@"" flags:DOSBleFlag_SN_NUMBER];
        }
            break;
        case 8:
        {
            NSLog(@"Disable recording key");
            [[DOSBleConnectImpl sharedInstance] sendCmdWithValue:@"" flags:DOSBleFlag_BTN_SETTING_DISABLE];
        }
            break;
        case 9:
        {
            NSLog(@"Enable recording key");
            [[DOSBleConnectImpl sharedInstance] sendCmdWithValue:@"" flags:DOSBleFlag_BTN_SETTING_ENABLE];
        }
            break;
        case 10:
        {
            NSLog(@"Record key status");
            [[DOSBleConnectImpl sharedInstance] sendCmdWithValue:@"" flags:DOSBleFlag_BTN_STATUS];
        }
            break;
            
        case 11:
        {
            NSLog(@"upload files");
            NSString *path = [[DOSBleRecordImpl sharedInstance] getLocalFilePath:@"01_20210130101628"];
            NSData *data = [NSData dataWithContentsOfFile:path];
            NSLog(@"data= %@", data);
            [[DOSBleRecordImpl sharedInstance] startTransferWithFileName:@"01_20210130101628" startPoint:data.length  keepFile:NO];
        }
            break;
        case 12:
        {
            NSLog(@"Stop uploading");
            [[DOSBleConnectImpl sharedInstance] sendCmdWithValue:@"" flags:DOSBleFlag_STOP_TRANSFER];
        }
            break;
        case 13:
        {
            NSLog(@"Delete Files");
            [[DOSBleConnectImpl sharedInstance] sendCmdWithValue:_fileList.lastObject flags:DOSBleFlag_DELETE_FILE];
            [_fileList removeLastObject];
        }
            break;
        case 14:
        {
            NSLog(@"Start decoding %@", self.decodePath);
            [[DOSBleRecordImpl sharedInstance] startDecode:self.decodePath];
        }
            break;
        case 15:
        {
            NSLog(@"Stop decoding");
            [[DOSBleRecordImpl sharedInstance] cancelDecode];
        }
            break;
        case 16:
        {
            self.decodePath = [[DOSBleRecordImpl sharedInstance] getLocalFilePath:@"01_20210203114610"];
            NSLog(@"Get file: %@", self.decodePath);
            
        }
            break;
        case 17:
        {
            NSLog(@"Pause recording");
            [[DOSBleRecordImpl sharedInstance] pauseRecognize];
        }
            break;
        case 18:
        {
            NSLog(@"resume recording");
            [[DOSBleRecordImpl sharedInstance] recoverRecognize];
            
        }
            break;
            
        default:
            break;
    }
    
}

//- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
//
//    view.layer.zPosition = 0.0;
//
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   // CGSizeMake cellSize = CGSizeMake(kScreenWidth, 80);
    NSLog(@"%f",CGSizeMake(kScreenWidth, 80));
    return CGSizeMake(kScreenWidth, 70);
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
          //  weakSelf.instructionsList.decodePath = value;
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
            //    [self.instructionsList reloadData];
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


@end
