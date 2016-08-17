//
//  HomeFriendCellViewModel.h
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/7/14.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Friend.h"

@interface HomeFriendCellViewModel : NSObject

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *nikeName;
+ (HomeFriendCellViewModel *)viewModelWithFriend:(Friend *)friend;

@end
