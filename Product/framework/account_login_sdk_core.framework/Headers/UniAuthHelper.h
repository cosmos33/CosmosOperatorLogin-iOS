//
//  UniAuthHelper.h
//  account_verify_sdk_core
//
//  Created by zhuof on 2018/3/8.
//  Copyright © 2018年 xiaowo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UniCustomModel.h"

typedef void (^UniResultListener)(NSDictionary *data);

@interface UniAuthHelper : NSObject

+(UniAuthHelper *) getInstance;

-(void) initWithAppId:(NSString*) appId appSecret:(NSString*) appSecret;

-(void) login :(double)timeout uiController:(UIViewController*)uiController listener:(UniResultListener) listener;

-(void) mobileAuth :(double)timeout listener:(UniResultListener) listener;

-(void)customUIWithParams:(UniCustomModel *)customUIParams customViews:(void(^)(UIView                                                                              *customAreaView))customViews;

- (void)printConsoleEnable:(BOOL)enable;

- (void)pageCloseEnable:(BOOL)enable;

@end
