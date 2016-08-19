//
//  BaseDataController.h
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/8/17.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompletionCallback)( NSError * _Nullable error ,NSDictionary * _Nullable errorMessage,RTAPIManagerErrorType errorType);
typedef void (^DataCallback)( NSError * _Nullable error ,NSDictionary * _Nullable errorMessage,RTAPIManagerErrorType errorType);
@interface BaseDataController : NSObject

@end
