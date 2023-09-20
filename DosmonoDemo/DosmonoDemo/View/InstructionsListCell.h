//
//  InstructionsListCell.h
//  DosmonoDemo
//
//  Created by 孙鹏 on 2020/11/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InstructionsListCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;

- (void)reloadDataWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
