//
//  HomeViewController.m
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/7/13.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeDataController.h"
#import "FriendsListView.h"
#import "HomeFriendsViewModel.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface HomeViewController ()

@property (nonatomic, strong) FriendsListView *friendView;
@property (nonatomic, strong) HomeDataController *dataController;

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
    [self.dataController requestUsersDataWithParams:@{@"uid":@"5719d5916703c02377506e72"} callBack:^(NSError * _Nullable error, NSDictionary * _Nullable errorMessage, RTAPIManagerErrorType errorType) {
        if (error == nil) {
            [self.friendView configWithViewModel:[HomeFriendsViewModel viewModelWithFriends:self.dataController.friendsArray]];
        }else
        {
            
        }
    }];
}

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

- (HomeDataController *)dataController
{
    if (_dataController == nil) {
        _dataController = [[HomeDataController alloc] init];
    }
    return _dataController;
}

@end
