//
//  FriendsListView.m
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/8/17.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import "FriendsListView.h"
#import "FriendViewCell.h"

@interface FriendsListView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *homeTableView;
@property (nonatomic, strong) HomeFriendsViewModel *viewModel;

@end

@implementation FriendsListView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.homeTableView];
    }
    return self;
}

#pragma mark --public method
- (void)configWithViewModel:(HomeFriendsViewModel *)viewModel
{
    self.viewModel = viewModel;
    self.homeTableView.dataSource = self;
    self.homeTableView.delegate = self;
}

#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.friendsCellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendViewCell"];
    if (cell == nil) {
        cell = [[FriendViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FriendViewCell"];
    }
    [cell configWithViewModel:self.viewModel.friendsCellArray[indexPath.row]];
    return cell;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.homeTableView.frame = self.bounds;
}

#pragma mark --getter&setter
- (UITableView *)homeTableView
{
    if (_homeTableView == nil) {
        _homeTableView = [[UITableView alloc] init];
    }
    return _homeTableView;
}


@end
