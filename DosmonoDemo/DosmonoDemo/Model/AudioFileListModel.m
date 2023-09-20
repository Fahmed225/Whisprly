//
//  AudioFileListModel.m
//  DosmonoDemo
//
//  Created by Imran Ishaq on 20/09/2023.
//

#import "AudioFileListModel.h"


NSString *const kAudioFileListModelFileDeleteStatus = @"fileDeleteStatus";
NSString *const kAudioFileListModelFileName = @"fileName";
NSString *const kAudioFileListModelFilePath = @"filePath";
NSString *const kAudioFileListModelFileTranslation = @"fileTranslation";
NSString *const kAudioFileListModelIsFileTranslated = @"is_fileTranslated";



@interface AudioFileListModel ()

@end
@implementation AudioFileListModel





/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */





-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kAudioFileListModelFileDeleteStatus] isKindOfClass:[NSNull class]]){
        self.fileDeleteStatus = [dictionary[kAudioFileListModelFileDeleteStatus] boolValue];
    }

    if(![dictionary[kAudioFileListModelFileName] isKindOfClass:[NSNull class]]){
        self.fileName = dictionary[kAudioFileListModelFileName];
    }

    if(![dictionary[kAudioFileListModelFilePath] isKindOfClass:[NSNull class]]){
        self.filePath = dictionary[kAudioFileListModelFilePath];
    }
    if(![dictionary[kAudioFileListModelFileTranslation] isKindOfClass:[NSNull class]]){
        self.fileTranslation = dictionary[kAudioFileListModelFileTranslation];
    }
    if(![dictionary[kAudioFileListModelIsFileTranslated] isKindOfClass:[NSNull class]]){
        self.isFileTranslated = dictionary[kAudioFileListModelIsFileTranslated];
    }
    

    
    return self;
}

-(NSString *)getFilePath {
    NSString *path = [[DOSBleRecordImpl sharedInstance] getLocalFilePath:self.fileName];
    return path;
}
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[kAudioFileListModelFileDeleteStatus] = @(self.fileDeleteStatus);
    
    if(self.fileName != nil){
            dictionary[kAudioFileListModelFileName] = self.fileName;
        }
    
    if(self.filePath != nil){
        dictionary[kAudioFileListModelFilePath] = self.filePath;
    }
    if(self.fileTranslation != nil){
        dictionary[kAudioFileListModelFileTranslation] = self.fileTranslation;
    }
    if(self.isFileTranslated != nil){
        dictionary[kAudioFileListModelIsFileTranslated] = self.isFileTranslated;
    }
    return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:@(self.fileDeleteStatus) forKey:kAudioFileListModelFileDeleteStatus];
    if(self.filePath != nil){
        [aCoder encodeObject:self.filePath forKey:kAudioFileListModelFilePath];
    }
    if(self.fileName != nil){
            [aCoder encodeObject:self.fileName forKey:kAudioFileListModelFileName];
        }
    if(self.fileTranslation != nil){
        [aCoder encodeObject:self.fileTranslation forKey:kAudioFileListModelFileTranslation];
    }
    if(self.isFileTranslated != nil){
        [aCoder encodeObject:self.isFileTranslated forKey:kAudioFileListModelIsFileTranslated];
    }

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.fileDeleteStatus = [[aDecoder decodeObjectForKey:kAudioFileListModelFileDeleteStatus] boolValue];
    self.fileName = [aDecoder decodeObjectForKey:kAudioFileListModelFileName] ;
    self.filePath = [aDecoder decodeObjectForKey:kAudioFileListModelFilePath];
    self.fileTranslation = [aDecoder decodeObjectForKey:kAudioFileListModelFileTranslation];
    self.isFileTranslated = [aDecoder decodeObjectForKey:kAudioFileListModelIsFileTranslated];
    return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    AudioFileListModel *copy = [AudioFileListModel new];

    copy.fileDeleteStatus = self.fileDeleteStatus;
    copy.fileName = self.fileName;
    copy.filePath = [self.filePath copy];
    copy.fileTranslation = [self.fileTranslation copy];
    copy.isFileTranslated = [self.isFileTranslated copy];

    return copy;
}
@end
