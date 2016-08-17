//
//  LoginDataController.h
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/7/14.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import "BaseDataController.h"

@interface LoginDataController : BaseDataController

- (void)requestToLoginWithParams:(NSDictionary *)params callBack:(CompletionCallback)callBack;

@end
