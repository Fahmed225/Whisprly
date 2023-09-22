//
//  AudioFileListModel.h
//  DosmonoDemo
//
//  Created by Imran Ishaq on 20/09/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioFileListModel : NSObject

@property (nonatomic, assign) BOOL fileDeleteStatus;
@property (nonatomic, assign) NSString* fileName;
@property (nonatomic, strong) NSString * filePath;
@property (nonatomic, strong) NSString * fileTranslation;
@property (nonatomic, strong) NSString * isFileTranslated;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(NSString *)getFilePath;
-(NSDictionary *)toDictionary;
@end

NS_ASSUME_NONNULL_END
