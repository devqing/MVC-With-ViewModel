//
//  HomeFriendCellViewModel.m
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/8/17.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import "HomeFriendCellViewModel.h"
#import <UIImageView+WebCache.h>

@implementation HomeFriendCellViewModel

+ (HomeFriendCellViewModel *)viewModelWithFriend:(Friend *)friend
{
    HomeFriendCellViewModel *cellViewModel = [[HomeFriendCellViewModel alloc] init];
    cellViewModel.avatar = friend.avatar;
    cellViewModel.nikeName = friend.nike_name;
    return cellViewModel;
}

@end
