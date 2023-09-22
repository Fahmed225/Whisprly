//
//  Helper.m
//  DosmonoDemo
//
//  Created by 孙鹏 on 2020/11/20.
//

#import "Helper.h"


@implementation Helper

+ (UIColor *)r:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a {
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a];
}

+ (UIViewController *)viewController:(UIView *)view {
    UIResponder *responder = view;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    }
    return nil;
}

+(void)saveAudioFilesInfo:(NSMutableArray*)list {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:list forKey:@"audioList"];
    [userDefaults synchronize];
}

+(NSMutableArray *)getAudioFilesList {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *files = [userDefaults objectForKey:@"audioList"];
    
    return files;
}


@end
