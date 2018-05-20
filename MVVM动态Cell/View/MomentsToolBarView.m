//
//  momentsToolBarView.m
//  SoolyMomentCell
//
//  Created by SoolyChristina on 2016/11/25.
//  Copyright © 2016年 SoolyChristina. All rights reserved.
//

#import "MomentsToolBarView.h"
#import "zuopinViewModel.h"
#import "zuopinModel.h"

@interface MomentsToolBarView ()

@property (nonatomic ,weak) UIButton *likeBtn;
@property (nonatomic ,weak) UIButton *commentBtn;

@end

@implementation MomentsToolBarView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setChildView];
        self.layer.cornerRadius = 1.0;
        self.layer.masksToBounds = NO;
    }
    return self;
}

- (void)setChildView{
    self.backgroundColor = [UIColor colorWithHexString:@"#555555"];
    //点赞
    UIButton *likeBtn = [[UIButton alloc] init];
    [likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    //    [likeBtn setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
    [likeBtn setTitleColor:circleCellToolBarTintColor forState:UIControlStateNormal];
    likeBtn.titleLabel.font = circleCellToolBarTittleFont;
    [self addSubview:likeBtn];
    self.likeBtn = likeBtn;
    
    //评论
    UIButton *commentBtn = [[UIButton alloc] init];
    [commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    [commentBtn setTitleColor:circleCellToolBarTintColor forState:UIControlStateNormal];
    commentBtn.titleLabel.font = circleCellToolBarTittleFont;
    [self addSubview:commentBtn];
    self.commentBtn = commentBtn;
}

- (void)setMomentFrames:(zuopinViewModel *)momentFrames{
    _momentFrames = momentFrames;
    self.likeBtn.frame = momentFrames.toolLikeFrame;
    [self.likeBtn setTitle:[NSString stringWithFormat:@" %ld",(long)momentFrames.zuopin.body.relay_number] forState:UIControlStateNormal];
    
    self.commentBtn.frame = momentFrames.toolCommentFrame;
    [self.commentBtn setTitle:[NSString stringWithFormat:@" %ld",(long)momentFrames.zuopin.body.comments_number] forState:UIControlStateNormal];
}

@end
