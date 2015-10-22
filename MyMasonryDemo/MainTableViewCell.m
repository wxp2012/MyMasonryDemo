//
//  MainTableViewCell.m
//  MyMasonryDemo
//
//  Created by 8107 on 15/10/22.
//  Copyright © 2015年  All rights reserved.
//

#import "MainTableViewCell.h"
#import "Masonry.h"

// 获取屏幕高度
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
// 获取屏幕宽度
#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width

static UIEdgeInsets const kPadding = {20, 20, 20, 20};

@interface MainTableViewCell ()

@property (nonatomic,strong) UIImageView *theImageV;
@property (nonatomic,strong) UILabel *nameL;

@end


@implementation MainTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _theImageV = [[UIImageView alloc] init];
        _theImageV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:_theImageV];
        
        _nameL = [[UILabel alloc] init];
        _nameL.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_nameL];
        
        UIView *topView = [UIView new];
        topView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:topView];
        
        /* 约束关系 */
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.width.and.height.equalTo(self.contentView.mas_height);
        }];
        
        [_theImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(topView).insets(UIEdgeInsetsMake(12, 12, 12, 12)); //各边偏移12个点
            make.center.equalTo(topView);
        }];
        
        [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(_theImageV.mas_right).insets(kPadding);
        }];
        
        
    }
    return self;
}

- (void)setTheImage:(UIImage *)image andTitle:(NSString *)title
{
    _theImageV.image = image;
    _nameL.text = title;
}

@end
