//
//  HomeDataController.m
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/8/17.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import "HomeDataSource.h"
#import "UsersDataSource.h"

@interface HomeDataSource()

@property (nonatomic, strong) UsersDataSource *dataSource;

@end

@implementation HomeDataSource

- (void)requestUsersDataWithParams:(NSDictionary *)params callBack:(CompletionCallback)callBack
{
    [self.dataSource requestAllUsersWithParams:params callBack:callBack];
}

#pragma mark --getter&setter
- (UsersDataSource *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[UsersDataSource alloc] init];
    
    }
    return _dataSource;
}

- (NSArray<Friend *> *)friendsArray
{
    return self.dataSource.friends.count>0?self.dataSource.friends:@[];
}

@end
