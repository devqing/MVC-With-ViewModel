//
//  LoginDataController.h
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/8/17.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import "BaseDataSource.h"

@interface LoginDataSource : BaseDataSource

- (void)requestToLoginWithParams:(NSDictionary *)params callBack:(CompletionCallback)callBack;

@end
