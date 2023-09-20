//
//  InstructionsListCell.m
//  DosmonoDemo
//
//  Created by 孙鹏 on 2020/11/25.
//

#import "InstructionsListCell.h"

@implementation InstructionsListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = UIColor.grayColor;
      //  _titleLabel.backgroundColor = UIColor.blueColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        [self.contentView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)reloadDataWithTitle:(NSString *)title {
    _titleLabel.text = title;
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    
//    CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size];
    CGRect cellFrame = layoutAttributes.frame;
    cellFrame.size.height = 60;
    cellFrame.size.width = kScreenWidth; /// 4;
    layoutAttributes.frame = cellFrame;
    
    return layoutAttributes;
}

@end
