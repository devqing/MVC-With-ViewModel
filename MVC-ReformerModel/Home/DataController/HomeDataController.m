//
//  HomeDataController.m
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/7/13.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import "HomeDataController.h"
#import "UsersDataController.h"

@interface HomeDataController()

@property (nonatomic, strong) UsersDataController *dataController;

@end

@implementation HomeDataController

- (void)requestUsersDataWithParams:(NSDictionary *)params callBack:(CompletionCallback)callBack
{
//    DataCallback dataCallBack = ^(NSError * _Nullable error ,NSDictionary * _Nullable errorMessage,RTAPIManagerErrorType errorType)
//    {
//        callBack(error,errorMessage,errorType);
//    };
    [self.dataController requestAllUsersWithParams:params callBack:callBack];
}

#pragma mark --getter&setter
- (UsersDataController *)dataController
{
    if (_dataController == nil) {
        _dataController = [[UsersDataController alloc] init];
    
    }
    return _dataController;
}

- (NSArray<Friend *> *)friendsArray
{
    return self.dataController.friends.count>0?self.dataController.friends:@[];
}

@end
