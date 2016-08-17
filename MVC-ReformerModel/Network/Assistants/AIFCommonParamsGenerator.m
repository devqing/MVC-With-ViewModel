//
//  SharkCommonParamsGenerator.m
//  customer-ios
//
//  Created by liuweiqing on 15/12/2.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "AIFCommonParamsGenerator.h"

@implementation AIFCommonParamsGenerator

+ (NSDictionary *)commonParamsDictionary
{
    return @{
             @"version":@"0,1",
             @"distribution":@"nightly",
             @"platform":@"ios"
             };
}



@end
