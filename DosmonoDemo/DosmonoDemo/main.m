//
//  main.m
//  DosmonoDemo
//
//  Created by 孙鹏 on 2020/11/20.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Whisprly-Swift.h"
int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
