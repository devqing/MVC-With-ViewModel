//
//  HomeFriendsViewModel.h
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/8/17.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Friend.h"
#import "HomeFriendCellViewModel.h"

@interface HomeFriendsViewModel : NSObject

@property (nonatomic, strong) NSArray <HomeFriendCellViewModel *> *friendsCellArray;

+ (HomeFriendsViewModel *)viewModelWithFriends:(NSArray<Friend *> *)friends;

@end
