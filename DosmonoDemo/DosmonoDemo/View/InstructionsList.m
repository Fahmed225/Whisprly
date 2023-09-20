//
//  InstructionsList.m
//  DosmonoDemo
//
//  Created by 孙鹏 on 2020/11/25.
//

#import "InstructionsList.h"
#import "InstructionsListCell.h"
#import "AudioFilesListCollectionViewCell.h"



@interface InstructionsList () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSInteger page;
}


@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSMutableArray<NSString *> *fileList;
@end

@implementation InstructionsList


- (instancetype)initWithFrame:(CGRect)frame
{
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.estimatedItemSize = CGSizeMake(kScreenWidth, 80);

    if (self = [super initWithFrame:frame collectionViewLayout:_flowLayout]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.pagingEnabled = NO;
        self.alwaysBounceHorizontal = YES;
        self.alwaysBounceVertical = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        [self registerClass:[AudioFilesListCollectionViewCell class] forCellWithReuseIdentifier:@"AudioFilesListCollectionViewCell"];

        
        WEAKSELF
        [DOSBleConnectImpl sharedInstance].onFileList = ^(NSArray<NSString *> * _Nonnull list) {
            weakSelf.fileList = (NSMutableArray *)list;
            NSLog(@"文件列表: %@", list);
            [SVProgressHUD dismiss];
        };
        
    }
    return self;
}

- (void)createFilesModelList:(NSArray*)list {
    
    for(NSString *name in list) {
        AudioFileListModel *item = [AudioFileListModel init];
        item.fileName = name;
        [_audioFilesList addObject:item];
    }
    
    [self reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _audioFilesList.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    AudioFilesListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AudioFilesListCollectionViewCell" forIndexPath:indexPath];
    [cell reloadDataWithTitle:_audioFilesList[indexPath.row]];
    return cell;
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{

    return 30.0;//最小横向间距
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 30.0;
}

+ (NSString *)giveMeFileName:(void (^)(void))callback {
    
    return @"";
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    AudioFileListModel * file = _audioFilesList[indexPath.row];
    
    [_audioFileDelegate giveMeFileName:file.filePath];
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

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    view.layer.zPosition = 0.0;
    
}

@end

