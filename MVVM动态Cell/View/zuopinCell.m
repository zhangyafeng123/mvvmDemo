//
//  zuopinCell.m
//  MVVM动态Cell
//
//  Created by linjianguo on 2018/5/20.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "zuopinCell.h"
#import "MomentsBodyView.h"
#import "MomentsToolBarView.h"
#import "zuopinViewModel.h"

@interface zuopinCell()

//主体
@property (nonatomic,weak) MomentsBodyView *bodyView;

//工具条
@property (nonatomic,weak) MomentsToolBarView *toolBarView;

@end

@implementation zuopinCell

+(instancetype)zuopinTableViewCellWithTableView:(UITableView *)tableView
{
    zuopinCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fengfengCell"];
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 阴影
        self.layer.shadowOffset = CGSizeMake(0, 1);  //阴影偏移量
        self.layer.shadowRadius = 1.5;
        self.layer.shadowColor = [UIColor grayColor].CGColor;
        self.layer.shadowOpacity = 1; //阴影透明度
        // 圆角
        self.layer.cornerRadius = 7.0;
        self.layer.masksToBounds = NO;
        
        // 添加子控件
        [self setChildView];
    }
    return self;
}
//添加子控件
- (void)setChildView{
    //Code圈主体
    MomentsBodyView *bodyView = [[MomentsBodyView alloc] init];
    [self addSubview:bodyView];
    self.bodyView = bodyView;
    
    //工具条
    MomentsToolBarView *toolBar = [[MomentsToolBarView alloc] init];
    [self addSubview:toolBar];
    self.toolBarView = toolBar;
}

- (void)setMomentFrames:(zuopinViewModel *)momentFrames{
    _momentFrames = momentFrames;
    
    //设置子控件的frame
    self.bodyView.frame = momentFrames.momentsBodyFrame;
    self.bodyView.momentFrames = momentFrames;
    self.toolBarView.frame = momentFrames.momentsToolBarFrame;
    self.toolBarView.momentFrames = momentFrames;
}

//设置cell的frame
//-(void)setFrame:(CGRect)frame{
//    frame.origin.x += circleCellMargin;
//    frame.size.width -= circleCellMargin * 2;
//    [super setFrame:frame];
//}
@end
