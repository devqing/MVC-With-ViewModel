//
//  FriendViewCell.m
//  MVC-ReformerModel
//
//  Created by liuweiqing on 16/8/17.
//  Copyright © 2016年 liuweiqing. All rights reserved.
//

#import "FriendViewCell.h"
#import <UIImageView+WebCache.h>

@interface FriendViewCell()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel   *nikeNameLabel;

@end


@implementation FriendViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.iconView];
        [self addSubview:self.nikeNameLabel];
    }
    return self;
}

- (void)configWithViewModel:(HomeFriendCellViewModel *)viewModel
{
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:viewModel.avatar]];
    self.nikeNameLabel.text = viewModel.nikeName;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconView.frame = CGRectMake(10, 10, 40, 40);
    self.nikeNameLabel.frame = CGRectMake(100, 0, 100, self.frame.size.height);
}

#pragma mark --getter&setter
- (UIImageView *)iconView
{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *)nikeNameLabel
{
    if (_nikeNameLabel == nil) {
        _nikeNameLabel = [[UILabel alloc] init];
        _nikeNameLabel.textColor = [UIColor redColor];
    }
    return _nikeNameLabel;
}

@end
