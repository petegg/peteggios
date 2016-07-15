//
//  AFHttpClient+Account.m
//  petegg
//
//  Created by ldp on 16/4/5.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient+Account.h"

@implementation AFHttpClient (Account)



-(void)loginWithUserName:(NSString *)userName password:(NSString *)password complete:(void (^)(BaseModel *))completeBlock{
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    params[@"common"] = @"memberLogin";
    
    params[@"accountnumber"] = userName;
    params[@"password"] = password;
    
    params[@"model"] = [[UIDevice currentDevice] model];
    params[@"brand"] = @"iphone";
    params[@"version"] = [[UIDevice currentDevice] systemVersion];
    params[@"imei"] = @"";
    params[@"imsi"] = @"";
    params[@"type"] = @"ios";

    [self POST:@"clientAction.do" parameters:params result:^(BaseModel *model) {
        if (model){
            
        model.list = [LoginModel arrayOfModelsFromDictionaries:model.list];        }
        if (completeBlock) {
            completeBlock(model);
        }
    }];





}



@end
