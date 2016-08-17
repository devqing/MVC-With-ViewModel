//
//  HomeDataController.h
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/7/13.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDataController.h"
#import "Friend.h"

typedef void(^callBack)(NSError *error);

@interface HomeDataController : BaseDataController

@property (nonatomic, strong) NSArray<Friend *> *friendsArray;

- (void)requestUsersDataWithParams:(NSDictionary *)params callBack:(CompletionCallback)callBack;

@end
