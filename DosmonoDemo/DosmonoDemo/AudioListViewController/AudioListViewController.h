//
//  AudioListViewController.h
//  DosmonoDemo
//
//  Created by Imran Ishaq on 22/09/2023.
//

#import <UIKit/UIKit.h>
#import "InstructionsListCell.h"
#import "AudioFilesListCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface AudioListViewController : UIViewController
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSString *decodePath;

@property (nonatomic, strong) NSMutableArray *audioFilesList;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) CBPeripheral *peripheral;
//@property (nonatomic, weak) id <InstructionsListDelegate> audioFileDelegate;
- (void)createFilesModelList:(NSArray*)list;

@end

NS_ASSUME_NONNULL_END
