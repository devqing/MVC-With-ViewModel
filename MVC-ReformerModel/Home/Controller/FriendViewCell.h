//
//  FriendViewCell.h
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/8/17.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeFriendCellViewModel.h"

@interface FriendViewCell : UITableViewCell

- (void)configWithViewModel:(HomeFriendCellViewModel *)viewModel;

@end
