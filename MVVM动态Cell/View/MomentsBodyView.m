//
//  MomentsBodyView.m
//  SoolyMomentCell
//
//  Created by SoolyChristina on 2016/11/25.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import "MomentsBodyView.h"
#import "zuopinViewModel.h"
#import "PYPhotoBrowser.h"
#import "zuopinModel.h"

@interface MomentsBodyView ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *textLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) PYPhotosView *photosView;

@end

@implementation MomentsBodyView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setChildView];
    }
    return self;
}

- (void)setChildView{
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    // 昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    [self addSubview:nameLabel];
    nameLabel.font = circleCellNameFont;
    self.nameLabel = nameLabel;
    // 时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = circleCellTimeFont;
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    // 正文
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = circleCellTextFont;
    //换行
    textLabel.numberOfLines = 0;
    [self addSubview:textLabel];
    self.textLabel = textLabel;
    
    // 图片
    // 创建一个流水布局photosView(默认为流水布局)
    PYPhotosView *flowPhotosView = [PYPhotosView photosView];
    // 设置分页指示类型
    //    flowPhotosView.pageType = PYPhotosViewPageTypeLabel;
    //    flowPhotosView.py_centerX = self.py_centerX;
    //    flowPhotosView.py_y = 20 + 64;
    flowPhotosView.photoWidth = circleCellPhotosWH;
    flowPhotosView.photoHeight = circleCellPhotosWH;
    flowPhotosView.photoMargin = circleCellPhotosMargin;
    [self addSubview:flowPhotosView];
    self.photosView = flowPhotosView;
}

- (void)setMomentFrames:(zuopinViewModel *)momentFrames{
    _momentFrames = momentFrames;
    //给子控件赋值
    [self setData];
    //给子控件设置frame
    [self setFrame];
    //没有图片
    if (self.momentFrames.zuopin.body.images.length == 0) {
        self.photosView.hidden = YES;
    } else {
        //存在图片
        self.photosView.hidden = NO;
        //只有一张图片
        if (![self.momentFrames.zuopin.body.images containsString:@"|"]) {
            
            self.photosView.thumbnailUrls = @[self.momentFrames.zuopin.body.images];
            self.photosView.originalUrls = @[self.momentFrames.zuopin.body.images];
        } else {
            NSArray *arr  = [self.momentFrames.zuopin.body.images componentsSeparatedByString:@"|"];
            self.photosView.thumbnailUrls = arr;
            self.photosView.originalUrls = arr;
        }
        // 设置图片frame
        self.photosView.frame = self.momentFrames.bodyPhotoFrame;
        
    }
    
}

-(void)setData{
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.momentFrames.zuopin.body.user_head]];
    self.nameLabel.text = self.momentFrames.zuopin.body.nick_name;
    self.textLabel.text = self.momentFrames.zuopin.body.subject;
    self.timeLabel.text = self.momentFrames.zuopin.body.create_time;
}

-(void)setFrame{
    self.iconView.frame = self.momentFrames.bodyIconFrame;
    self.nameLabel.frame = self.momentFrames.bodyNameFrame;
    self.textLabel.frame = self.momentFrames.bodyTextFrame;
    self.timeLabel.frame = self.momentFrames.bodyTimeFrame;
}

@end
