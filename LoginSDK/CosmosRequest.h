//
//  CosmosRequest.h
//  LoginSDK
//
//  Created by wangxuefei on 2019/10/29.
//  Copyright © 2019 MOMO. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RequestSucceed)(NSDictionary *dic);

typedef void(^RequestFail)(NSError *error);

@interface CosmosRequest : NSObject

+ (void)requestWithUrlStr:(NSString *)urlStr
                    param:(NSDictionary *)dic
          succeedCallBack:(RequestSucceed)succeedCallBack
             failCallBack:(RequestFail)failCallBack;

@end

NS_ASSUME_NONNULL_END
