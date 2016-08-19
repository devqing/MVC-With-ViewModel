//
//  UsersDataController.h
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/8/17.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import "BaseDataController.h"
#import "Friend.h"

@interface UsersDataController : BaseDataController

@property (nonatomic, strong) NSArray<Friend *> *friends;

- (void)requestAllUsersWithParams:(NSDictionary *)params callBack:(DataCallback)dataCallBack;

@end
