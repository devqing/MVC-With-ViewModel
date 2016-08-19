//
//  SharkApiBaseManager.m
//  customer-ios
//
//  Created by liuweiqing on 15/12/2.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "RTApiBaseManager.h"
#import "AIFCache.h"
#import "AIFAPPContext.h"
#import "AIFApiProxy.h"
#import "AIFURLResponse.h"
#import "AIFServiceFactory.h"
#import "AIFNetworkingConfig.h"


#define AXCallAPI(REQUEST_METHOD, REQUEST_ID)                                                       \
{                                                                                       \
REQUEST_ID = [[AIFApiProxy sharedInstance] call##REQUEST_METHOD##WithParams:apiParams serviceIdentifier:self.child.serviceType methodName:self.child.methodName success:^(AIFURLResponse *response) { \
[self successedOnCallingAPI:response];                                          \
} fail:^(AIFURLResponse *response) {                                                \
[self failedOnCallingAPI:response withErrorType:RTAPIManagerErrorTypeDefault];  \
}];                                                                                 \
[self.requestIdList addObject:@(REQUEST_ID)];                                          \
}

@interface RTApiBaseManager()

@property (nonatomic, strong, readwrite) id fetchedRawData;

@property (nonatomic, copy, readwrite) NSString *errorMessage;
@property (nonatomic, readwrite) RTAPIManagerErrorType errorType;
@property (nonatomic, strong) NSMutableArray *requestIdList;
@property (nonatomic, strong) AIFCache *cache;

@end

@implementation RTApiBaseManager

#pragma mark - getters and setters
- (AIFCache *)cache
{
    if (_cache == nil) {
        _cache = [AIFCache sharedInstance];
    }
    return _cache;
}

- (NSMutableArray *)requestIdList
{
    if (_requestIdList == nil) {
        _requestIdList = [[NSMutableArray alloc] init];
    }
    return _requestIdList;
}

- (BOOL)isReachable
{
    BOOL isReachability = [AIFAPPContext sharedInstance].isReachable;
    if (!isReachability) {
        self.errorType = RTAPIManagerErrorTypeNoNetWork;
    }
    return isReachability;
}

- (BOOL)isLoading
{
    return [self.requestIdList count] > 0;
}

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        _delegate = nil;
        _validator = nil;
        _paramSource = nil;
        
        _fetchedRawData = nil;
        
        _errorMessage = nil;
        _errorType = RTAPIManagerErrorTypeDefault;
        
        if ([self conformsToProtocol:@protocol(RTAPIManager)]) {
            self.child = (id <RTAPIManager>)self;
        }
    }
    return self;
}

- (void)dealloc
{
    [self cancelAllRequests];
    self.requestIdList = nil;
}

#pragma mark - public methods
- (void)cancelAllRequests
{
    [[AIFApiProxy sharedInstance] cancelRequestWithRequestIDList:self.requestIdList];
    [self.requestIdList removeAllObjects];
}

- (void)cancelRequestWithRequestId:(NSInteger)requestID
{
    [self removeRequestIdWithRequestID:requestID];
    [[AIFApiProxy sharedInstance] cancelRequestWithRequestID:@(requestID)];
}


#pragma mark - calling api
- (NSInteger)loadData
{
    NSDictionary *params = [self.paramSource paramsForApi:self];
    NSInteger requestId = [self loadDataWithParams:params];
    return requestId;
}

- (NSInteger)loadDataWithParams:(NSDictionary *)params
{
    NSInteger requestId = 0;
    NSDictionary *apiParams = [self reformParams:params];
    if ([self.validator manager:self isCorrectWithParamsData:apiParams]) {
        
        // 先检查一下是否有缓存
        if ([self shouldCache] && [self hasCacheWithParams:apiParams]) {
            return 0;
        }
        // 实际的网络请求
        if ([self isReachable]) {
            switch (self.child.requestType)
            {
                case RTAPIManagerRequestTypeGet:
                    AXCallAPI(GET, requestId);
                    break;
                case RTAPIManagerRequestTypePost:
                    AXCallAPI(POST, requestId);
                    break;
                case RTAPIManagerRequestTypeDELETE:
                    AXCallAPI(DELETE, requestId);
                    break;
                case RTAPIManagerRequestTypePUT:
                    AXCallAPI(PUT, requestId);
                    break;
                default:
                    break;
            }
            
            NSMutableDictionary *params = [apiParams mutableCopy];
            params[@"kRTAPIBaseManagerRequestID"] = @(requestId);
            return requestId;
            
        } else {
            [self failedOnCallingAPI:nil withErrorType:RTAPIManagerErrorTypeNoNetWork];
            return requestId;
        }
    } else {
        [self failedOnCallingAPI:nil withErrorType:RTAPIManagerErrorTypeParamsError];
        return requestId;
    }
    return requestId;
}

#pragma mark - api callbacks
- (void)apiCallBack:(AIFURLResponse *)response
{
    if (response.status == AIFURLResponseStatusSuccess) {
        [self successedOnCallingAPI:response];
    }else{
        [self failedOnCallingAPI:response withErrorType:RTAPIManagerErrorTypeTimeout];
    }
}

- (void)successedOnCallingAPI:(AIFURLResponse *)response
{
    if (response.content) {
        self.fetchedRawData = [response.content copy];
    } else {
        self.fetchedRawData = [response.responseData copy];
    }
    [self removeRequestIdWithRequestID:response.requestId];
    if ([self.validator manager:self isCorrectWithCallBackData:response.content]) {
        
        if (kAIFShouldCache && !response.isCache) {
            [self.cache saveCacheWithData:response.responseData serviceIdentifier:self.child.serviceType methodName:self.child.methodName requestParams:response.requestParams];
        }
        
        [self.delegate managerCallAPIDidSuccess:self responseData:self.fetchedRawData];
    } else {
        
        [self failedOnCallingAPI:response withErrorType:RTAPIManagerErrorTypeNoContent];
    }
}

- (void)failedOnCallingAPI:(AIFURLResponse *)response withErrorType:(RTAPIManagerErrorType)errorType
{
    self.errorType = errorType;
    [self removeRequestIdWithRequestID:response.requestId];
    [self.delegate managerCallAPIDidFailed:self responseData:self.fetchedRawData];
}


#pragma mark - method for child
- (void)cleanData
{
    IMP childIMP = [self.child methodForSelector:@selector(cleanData)];
    IMP selfIMP = [self methodForSelector:@selector(cleanData)];
    
    if (childIMP == selfIMP) {
        self.fetchedRawData = nil;
        self.errorMessage = nil;
        self.errorType = RTAPIManagerErrorTypeDefault;
    } else {
        if ([self.child respondsToSelector:@selector(cleanData)]) {
            [self.child cleanData];
        }
    }
}

//如果需要在调用API之前额外添加一些参数，比如pageNumber和pageSize之类的就在这里添加
//子类中覆盖这个函数的时候就不需要调用[super reformParams:params]了
- (NSDictionary *)reformParams:(NSDictionary *)params
{
    IMP childIMP = [self.child methodForSelector:@selector(reformParams:)];
    IMP selfIMP = [self methodForSelector:@selector(reformParams:)];
    
    if (childIMP == selfIMP) {
        return params;
    } else {
        // 如果child是继承得来的，那么这里就不会跑到，会直接跑子类中的IMP。
        // 如果child是另一个对象，就会跑到这里
        NSDictionary *result = nil;
        result = [self.child reformParams:params];
        if (result) {
            return result;
        } else {
            return params;
        }
    }
}

- (BOOL)shouldCache
{
    return kAIFShouldCache;
}

#pragma mark - private methods
- (void)removeRequestIdWithRequestID:(NSInteger)requestId
{
    NSNumber *requestIDToRemove = nil;
    for (NSNumber *storedRequestId in self.requestIdList) {
        if ([storedRequestId integerValue] == requestId) {
            requestIDToRemove = storedRequestId;
        }
    }
    if (requestIDToRemove) {
        [self.requestIdList removeObject:requestIDToRemove];
    }
}

- (BOOL)hasCacheWithParams:(NSDictionary *)params
{
    NSString *serviceIdentifier = self.child.serviceType;
    NSString *methodName = self.child.methodName;
    NSData *result = [self.cache fetchCachedDataWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:params];
    
    if (result == nil) {
        return NO;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        AIFURLResponse *response = [[AIFURLResponse alloc] initWithData:result];
        response.requestParams = params;
        [self successedOnCallingAPI:response];
    });
    return YES;
}

@end
