//
//  Friend.m
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/7/14.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import "Friend.h"

@implementation Friend

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)friendWithDict:(NSDictionary *)dict
{
    Friend *friend = [[Friend alloc] initWithDict:dict];
    
    return friend;
}

@end
