//
//  InstructionsList.h
//  DosmonoDemo
//
//  Created by 孙鹏 on 2020/11/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol InstructionsListDelegate <NSObject>
@optional
- (void)giveMeFileName:(NSString*)fileName;
//- (void)something:(id)something didFailWithError:(NSError *)error;
@end

@interface InstructionsList : UICollectionView

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSString *decodePath;

@property (nonatomic, strong) NSMutableArray *audioFilesList;
@property (nonatomic, weak) id <InstructionsListDelegate> audioFileDelegate;
- (void)createFilesModelList:(NSArray*)list;
@end

NS_ASSUME_NONNULL_END
