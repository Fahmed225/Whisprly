//
//  AudioFilesListCollectionViewCell.m
//  DosmonoDemo
//
//  Created by Imran Ishaq on 20/09/2023.
//

#import "AudioFilesListCollectionViewCell.h"

@implementation AudioFilesListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.dataContainerView.layer.cornerRadius = 8.0;
}

- (void)reloadDataWithTitle:(AudioFileListModel*)model {
    self.titleLabel.text = model.fileName;
}

@end
