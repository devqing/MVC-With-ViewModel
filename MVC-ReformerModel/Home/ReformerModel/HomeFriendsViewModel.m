//
//  HomeFriendsViewModel.m
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/7/14.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import "HomeFriendsViewModel.h"

@implementation HomeFriendsViewModel

+ (HomeFriendsViewModel *)viewModelWithFriends:(NSArray<Friend *> *)friends
{
    NSMutableArray *array = [NSMutableArray array];
    HomeFriendsViewModel *h = [[HomeFriendsViewModel alloc] init];
    for (Friend *friend in friends) {
        [array addObject:[HomeFriendCellViewModel viewModelWithFriend:friend]];
    }
    h.friendsCellArray = array;
    return h;
}

@end
