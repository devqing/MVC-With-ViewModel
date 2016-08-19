//
//  HomeDataController.h
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/8/17.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDataSource.h"
#import "Friend.h"

typedef void(^callBack)(NSError *error);

@interface HomeDataSource : BaseDataSource

@property (nonatomic, strong) NSArray<Friend *> *friendsArray;

- (void)requestUsersDataWithParams:(NSDictionary *)params callBack:(CompletionCallback)callBack;

@end
