//
//  HomeViewController.m
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/8/17.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeDataSource.h"
#import "FriendsListView.h"
#import "HomeFriendsViewModel.h"

@interface HomeViewController ()

@property (nonatomic, strong) FriendsListView *friendView;
@property (nonatomic, strong) HomeDataSource *dataSource;

@end

@implementation HomeViewController


#pragma mark --life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.friendView];
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self layoutSubviews];
}


- (void)requestData
{
    [self.dataSource requestUsersDataWithParams:@{@"uid":@"5719d5916703c02377506e72"} callBack:^(NSError * _Nullable error, NSDictionary * _Nullable errorMessage, RTAPIManagerErrorType errorType) {
        if (error == nil) {
            [self.friendView configWithViewModel:[HomeFriendsViewModel viewModelWithFriends:self.dataSource.friendsArray]];
        }else
        {
            // 请求错误  错误处理
        }
    }];
}

#pragma mark --private method
- (void)layoutSubviews
{
    self.friendView.frame = self.view.bounds;
}


#pragma mark --getter&setter
- (FriendsListView *)friendView
{
    if (_friendView == nil) {
        _friendView = [[FriendsListView alloc] init];
    }
    return _friendView;
}


- (HomeDataSource *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[HomeDataSource alloc] init];
    }
    return _dataSource;
}

@end
