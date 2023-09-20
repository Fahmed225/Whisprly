//
//  SceneDelegate.m
//  DosmonoDemo
//
//  Created by 孙鹏 on 2020/11/20.
//

#import "SceneDelegate.h"


@interface SceneDelegate ()

@property (nonatomic, assign) UIBackgroundTaskIdentifier bgTask;
@property(strong, nonatomic)NSTimer *timer;

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    //在后台模式下解码需要添加如下代码
    [[DOSBleRecordImpl sharedInstance] setSleepForTimeInterval:0.001];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    //在后台模式下解码需要添加如下代码，后台保活+降低CPU占用率
    [[DOSBleRecordImpl sharedInstance] setSleepForTimeInterval:0.001];
    [[DOSBleConnectImpl sharedInstance] sendCmdWithValue:@"" flags:DOSBleFlag_ELECTRICITY];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        [[DOSBleConnectImpl sharedInstance] sendCmdWithValue:@"" flags:DOSBleFlag_ELECTRICITY];
        
    }];
}



@end
