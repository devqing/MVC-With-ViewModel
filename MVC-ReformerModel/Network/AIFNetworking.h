//
//  Networking.h
//  customer-ios
//
//  Created by liuweiqing on 15/12/4.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#ifndef customer_ios_AIFNetworking_h
#define customer_ios_AIFNetworking_h


typedef NS_ENUM (NSUInteger, RTAPIManagerErrorType){
    RTAPIManagerErrorTypeDefault,       //没有产生过API请求，这个是manager的默认状态。
    RTAPIManagerErrorTypeSuccess,       //API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
    RTAPIManagerErrorTypeNoContent,     //API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。
    RTAPIManagerErrorTypeParamsError,   //参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。
    RTAPIManagerErrorTypeTimeout,       //请求超时。RTApiProxy设置的是20秒超时，具体超时时间的设置请自己去看RTApiProxy的相关代码。
    RTAPIManagerErrorTypeNoNetWork      //网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。
};


#endif
