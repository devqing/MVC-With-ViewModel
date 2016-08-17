//
//  SharkService.m
//  customer-ios
//
//  Created by liuweiqing on 15/12/2.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "AIFService.h"

@implementation AIFService

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(AIFServiceProtocal)]) {
            self.child = (id<AIFServiceProtocal>)self;
        }
    }
    return self;
}

#pragma mark - getters and setters
- (NSString *)privateKey
{
    return self.child.onlinePrivateKey;
}

- (NSString *)publicKey
{
    return self.child.onlinePublicKey;
}

- (NSString *)apiBaseUrl
{
    return self.child.onlineApiBaseUrl;
}

- (NSString *)apiVersion
{
    return self.child.onlineApiVersion;
}

@end
