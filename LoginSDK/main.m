//
//  main.m
//  LoginSDK
//
//  Created by wangxuefei on 2019/10/21.
//  Copyright © 2019 MOMO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    NSLog(@"begin");
    int re = UIApplicationMain(argc, argv, nil, appDelegateClassName);
    NSLog(@"end");
    return re;
}
