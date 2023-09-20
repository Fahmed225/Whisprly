//
//  AudioFilesListCollectionViewCell.h
//  DosmonoDemo
//
//  Created by Imran Ishaq on 20/09/2023.
//

#import <UIKit/UIKit.h>
#import "AudioFileListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AudioFilesListCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIView *dataContainerView;

- (void)reloadDataWithTitle:(AudioFileListModel *)title;

@end

NS_ASSUME_NONNULL_END
