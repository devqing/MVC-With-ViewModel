//
//  UsersDataController.m
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/8/17.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import "UsersDataController.h"
#import "ApiFriendsManager.h"
#import <UIImageView+WebCache.h>

@interface UsersDataController()<RTAPIManagerApiCallBackDelegate,RTAPIManagerParamSourceDelegate>

@property (nonatomic, strong) ApiFriendsManager *apiManager;
@property (nonatomic, copy)   DataCallback dataCallBack;
@property (nonatomic, strong) NSDictionary *params;

@end

@implementation UsersDataController


#pragma mark --public method

- (void)requestAllUsersWithParams:(NSDictionary *)params callBack:(DataCallback)dataCallBack
{
    self.dataCallBack = dataCallBack;
    self.params = params;
    [self.apiManager loadData];
}

#pragma mark --RTAPIManagerApiCallBackDelegate

- (void)managerCallAPIDidFailed:(RTApiBaseManager *)manager responseData:(id)responseData
{
    self.dataCallBack(nil,@{},manager.errorType);
}

- (void)managerCallAPIDidSuccess:(RTApiBaseManager *)manager responseData:(id)responseData
{
    NSArray *friends = responseData[@"data"][@"friends"];
    NSMutableArray *friendsArray = [NSMutableArray array];
    for (NSDictionary *friendDict in friends) {
        Friend *friend = [Friend friendWithDict:friendDict];
        [friendsArray addObject:friend];
    }
    self.friends = friendsArray;
    self.dataCallBack(nil,nil,RTAPIManagerErrorTypeDefault);
}


#pragma mark --RTAPIManagerParamSourceDelegate

- (NSDictionary *)paramsForApi:(RTApiBaseManager *)manager
{
    return self.params;
}


#pragma mark --getter&setter

- (ApiFriendsManager *)apiManager
{
    if (_apiManager == nil) {
        _apiManager = [[ApiFriendsManager alloc] init];
        _apiManager.delegate = self;
        _apiManager.paramSource = self;
    }
    return _apiManager;
}

@end
