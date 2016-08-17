//
//  SharkContext.m
//  customer-ios
//
//  Created by liuweiqing on 15/12/2.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "AIFAPPContext.h"
#import <UIKit/UIKit.h>
#import "AFNetworkReachabilityManager.h"

@interface AIFAPPContext()

@end

@implementation AIFAPPContext

#pragma mark - getters and setters


- (BOOL)isReachable
{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static AIFAPPContext *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AIFAPPContext alloc] init];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    });
    return sharedInstance;
}



@end
