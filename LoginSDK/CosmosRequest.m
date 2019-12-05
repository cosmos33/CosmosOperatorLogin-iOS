//
//  CosmosRequest.m
//  LoginSDK
//
//  Created by wangxuefei on 2019/10/29.
//  Copyright © 2019 MOMO. All rights reserved.
//

#import "CosmosRequest.h"

@implementation CosmosRequest

+ (void)requestWithUrlStr:(NSString *)urlStr
          param:(NSDictionary *)dic
succeedCallBack:(RequestSucceed)succeedCallBack
   failCallBack:(RequestFail)failCallBack
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 5.0f;
    if (![request valueForHTTPHeaderField:@"Accept"]) {
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }
    if (![request valueForHTTPHeaderField:@"User-Agent"]) {
        [request setValue:@"ios" forHTTPHeaderField:@"User-Agent"];
    }

    __block NSString *str = @"";
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        str = [str stringByAppendingFormat:@"%@=%@&",key,obj];
    }];
    if(str.length >= 2){
        str = [str substringToIndex:str.length - 1];
    }
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *postLength = [NSString stringWithFormat:@"%zd",[data length]];

    request.HTTPBody = data;
    if (![request valueForHTTPHeaderField:@"Content-Type"]) {
           [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
       }
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];

    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session  dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            return failCallBack(error);
        }else{
            NSError *jsonError;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            if(!jsonError){
                if(dic && [dic isKindOfClass:[NSDictionary class]]){
                    NSString *ec = [dic objectForKey:@"ec"];
                    if(ec && ec.intValue == 0){
                        succeedCallBack(dic);
                    }
                }else{
                    NSError *error = [NSError errorWithDomain:@"fail" code:10020 userInfo:dic];
                    failCallBack(error);
                }
            }else{
                failCallBack(jsonError);
            }
        }
        
    }];
    [sessionDataTask resume];
}

@end
