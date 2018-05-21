//
//  TestCell.m
//  MVVM动态Cell
//
//  Created by linjianguo on 2018/5/21.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "TestCell.h"

// 定义这个常量，就可以不用在开发过程中使用"mas_"前缀。
#define MAS_SHORTHAND
// 定义这个常量，就可以让Masonry帮我们自动把基础数据类型的数据，自动装箱为对象类型。
#define MAS_SHORTHAND_GLOBALS
#import <Masonry.h>
@interface TestCell()
@property (nonatomic, strong)UIImageView *iconView;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong) PYPhotosView *photosView;
@end

@implementation TestCell

+(instancetype)testTableViewCellWithTableView:(UITableView *)tableView
{
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell"];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
        [self setupConstraints];
    }
    return self;
}
- (void)setupViews
{
    _iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:12];
    _nameLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_nameLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_timeLabel];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:15];
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    
    // 创建一个流水布局photosView(默认为流水布局)
//    _photosView = [PYPhotosView photosView];
//    [self.contentView addSubview:_photosView];
}
- (void)setupConstraints {
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.mas_right).with.offset(10);
        make.top.mas_equalTo(self.iconView.mas_top).with.offset(10);
        make.right.mas_equalTo(-10);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).with.offset(10);
        make.right.mas_equalTo(-10);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.mas_left);
        make.top.mas_equalTo(self.iconView.mas_bottom).with.offset(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
    }];
    
//    [self.photosView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.iconView.mas_left);
//        make.top.mas_equalTo(self.contentLabel.mas_bottom).with.offset(10);
////        make.right.mas_equalTo(-10);
////        make.bottom.mas_equalTo(-10);
//        make.width.mas_equalTo(screenWidth - 20);
//        make.height.mas_equalTo( (screenWidth-40)/3 +20);
//    }];
   
//    _photosView.py_x = 10;
//    _photosView.py_y = CGRectGetMaxY(self.contentLabel.frame);
//
//    _photosView.py_width = screenWidth;
//    _photosView.py_height =  (screenWidth-40)/3 +20;
    
//    _photosView.photoWidth = (screenWidth-40)/3;
//    _photosView.photoHeight = (screenWidth-40)/3;
//    _photosView.photoMargin = 10;
    
}

- (void)setTestModel:(zuopinModel *)model
{
    self.nameLabel.text = model.body.nick_name;
    self.timeLabel.text = model.body.create_time;
    self.contentLabel.text = model.body.subject;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.body.user_head]];
    
    //只有一张图片
//    if (![model.body.images containsString:@"|"]) {
//
//        self.photosView.thumbnailUrls = @[model.body.images];
//        self.photosView.originalUrls = @[model.body.images];
//    } else {
//        NSArray *arr  = [model.body.images componentsSeparatedByString:@"|"];
//        self.photosView.thumbnailUrls = arr;
//        self.photosView.originalUrls = arr;
//    }
    
}


@end
