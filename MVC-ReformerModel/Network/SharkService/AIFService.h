//
//  SharkService.h
//  customer-ios
//
//  Created by liuweiqing on 15/12/2.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AIFServiceProtocal <NSObject>

@property (nonatomic, readonly) NSString *onlineApiBaseUrl;
@property (nonatomic, readonly) NSString *onlineApiVersion;
@property (nonatomic, readonly) NSString *onlinePublicKey;
@property (nonatomic, readonly) NSString *onlinePrivateKey;

@end

@interface AIFService : NSObject

@property (nonatomic, strong, readonly) NSString *publicKey;
@property (nonatomic, strong, readonly) NSString *privateKey;
@property (nonatomic, strong, readonly) NSString *apiBaseUrl;
@property (nonatomic, strong, readonly) NSString *apiVersion;

@property (nonatomic, weak) id<AIFServiceProtocal> child;

@end
