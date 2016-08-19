//
//  SharkApiBaseManager.h
//  customer-ios
//
//  Created by liuweiqing on 15/12/2.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIFURLResponse.h"

@class RTApiBaseManager;

//api回调
@protocol RTAPIManagerApiCallBackDelegate <NSObject>
@required
- (void)managerCallAPIDidSuccess:(RTApiBaseManager *)manager responseData:(id)responseData;
- (void)managerCallAPIDidFailed:(RTApiBaseManager *)manager responseData:(id)responseData;
@end


@protocol RTAPIManagerValidator <NSObject>
@required

- (BOOL)manager:(RTApiBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data;
- (BOOL)manager:(RTApiBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data;

@end


typedef NS_ENUM (NSUInteger, RTAPIManagerRequestType){
    RTAPIManagerRequestTypeGet,
    RTAPIManagerRequestTypePost,
    RTAPIManagerRequestTypeDELETE,
    RTAPIManagerRequestTypeHEAD,
    RTAPIManagerRequestTypePUT
};

@protocol RTAPIManagerParamSourceDelegate <NSObject>
@required

- (NSDictionary *)paramsForApi:(RTApiBaseManager *)manager;

@end

/*
 RTAPIBaseManager的派生类必须符合这些protocal
 */
@protocol RTAPIManager <NSObject>

@required
- (NSString *)methodName;
- (NSString *)serviceType;
- (RTAPIManagerRequestType)requestType;

@optional
- (void)cleanData;
- (NSDictionary *)reformParams:(NSDictionary *)params;
- (BOOL)shouldCache;

@end


@interface RTApiBaseManager : NSObject

@property (nonatomic, weak) id<RTAPIManagerApiCallBackDelegate> delegate;
@property (nonatomic, weak) id<RTAPIManagerParamSourceDelegate> paramSource;
@property (nonatomic, weak) id<RTAPIManagerValidator> validator;
@property (nonatomic, weak) NSObject<RTAPIManager> *child; //里面会调用到NSObject的方法，所以这里不用id
/*
 baseManager是不会去设置errorMessage的，派生的子类manager可能需要给controller提供错误信息。所以为了统一外部调用的入口，设置了这个变量。
 派生的子类需要通过extension来在保证errorMessage在对外只读的情况下使派生的manager子类对errorMessage具有写权限。
 */
@property (nonatomic, copy, readonly) NSString *errorMessage;
@property (nonatomic, readonly) RTAPIManagerErrorType errorType;

@property (nonatomic, assign, readonly) BOOL isReachable;
@property (nonatomic, assign, readonly) BOOL isLoading;


//尽量使用loadData这个方法,这个方法会通过param source来获得参数，这使得参数的生成逻辑位于controller中的固定位置
- (NSInteger)loadData;

- (void)cancelAllRequests;
- (void)cancelRequestWithRequestId:(NSInteger)requestID;


- (NSDictionary *)reformParams:(NSDictionary *)params;
- (void)cleanData;
- (BOOL)shouldCache;

@end
