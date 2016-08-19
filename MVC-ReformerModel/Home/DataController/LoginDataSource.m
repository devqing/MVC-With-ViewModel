//
//  LoginDataController.m
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/8/17.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import "LoginDataController.h"
#import "WKApiLoginManager.h"

@interface LoginDataController()<RTAPIManagerApiCallBackDelegate,RTAPIManagerParamSourceDelegate>

@property (nonatomic, strong) WKApiLoginManager *apiManager;
@property (nonatomic, copy) CompletionCallback callBack;
@property (nonatomic, strong) NSDictionary *params;

@end

@implementation LoginDataController

- (void)requestToLoginWithParams:(NSDictionary *)params callBack:(CompletionCallback)callBack
{
    self.params = params;
    self.callBack = callBack;
    [self.apiManager loadData];
}

#pragma mark --RTAPIManagerApiCallBackDelegate
- (void)managerCallAPIDidFailed:(RTApiBaseManager *)manager responseData:(id)responseData
{
    self.callBack(nil,@{},manager.errorType);
}

- (void)managerCallAPIDidSuccess:(RTApiBaseManager *)manager responseData:(id)responseData
{
    self.callBack(nil,nil,manager.errorType);
}

#pragma mark --RTAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(RTApiBaseManager *)manager
{
    return self.params;
}

#pragma mark --getter&setter
- (WKApiLoginManager *)apiManager
{
    if (_apiManager == nil) {
        _apiManager = [[WKApiLoginManager alloc] init];
        _apiManager.delegate = self;
        _apiManager.paramSource = self;
    }
    return _apiManager;
}

@end
