//
//  SharkContext.h
//  customer-ios
//
//  Created by liuweiqing on 15/12/2.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIFNetworkingConfig.h"

@interface AIFAPPContext : NSObject

@property (nonatomic, readonly) BOOL isReachable;

+ (instancetype)sharedInstance;

@end
