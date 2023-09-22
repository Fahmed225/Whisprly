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
    
    self.dataContainerView.layer.cornerRadius = 5.0;
    self.backgroundView.backgroundColor = UIColor.lightGrayColor;
    self.backgroundColor = UIColor.lightGrayColor;
    
}

- (void)reloadDataWithTitle:(AudioFileListModel*)model {
    self.titleLabel.text = model.fileName;
    self.titleLabel.textColor = UIColor.redColor;
}

@end
