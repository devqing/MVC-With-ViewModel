//
//  Friend.h
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/8/17.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *nike_name;
@property (nonatomic, strong) NSString *_id;

+ (instancetype)friendWithDict:(NSDictionary *)dict;

@end
