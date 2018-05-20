//
//  zuopinViewModel.m
//  MVVM动态Cell
//
//  Created by linjianguo on 2018/5/20.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "zuopinViewModel.h"
#import "zuopinModel.h"
@implementation zuopinViewModel

- (void)setZuopin:(zuopinModel *)zuopin
{
    _zuopin = zuopin;
    //NSLog(@"111");
    //计算主体Frame
    [self setMomentsBodyFrames];
    //计算工具条Frame
    [self setMomentsToolBarFrames];
    //计算CellHeight
    [self setCellHeight];
}
//计算Code圈主体Frame
- (void)setMomentsBodyFrames{
    //头像
    CGFloat iconX = circleCellMargin;
    CGFloat iconY = circleCellMargin;
    CGFloat iconW = circleCelliconWH;
    CGFloat iconH = circleCelliconWH;
    self.bodyIconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    //昵称
    CGFloat nameX = circleCelliconWH + circleCellMargin * 2;
    CGFloat nameY = iconY;
    //    CGFloat nameW = 120;
    CGSize nameSize = [self.zuopin.body.nick_name sizeWithAttributes:circleCellNameattributes];
    self.bodyNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    //时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.bodyNameFrame) + circleCellMargin * 0.5;
    CGSize timeSize = [self.zuopin.body.create_time boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:circleCellTimeattributes context:nil].size;
    self.bodyTimeFrame = (CGRect){{timeX,timeY},timeSize};
    
    //正文
    CGFloat textX = circleCellMargin;//15
    CGFloat textY = CGRectGetMaxY(self.bodyIconFrame) + circleCellMargin;
    CGFloat textW = circleCellWidth - circleCellMargin * 2;
    CGSize textSize = [self.zuopin.body.subject boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:circleCellTextattributes context:nil].size;
    self.bodyTextFrame = (CGRect){{textX,textY},textSize};
    
    
    CGFloat photosX = circleCellMargin;
    CGFloat photosY = CGRectGetMaxY(self.bodyTextFrame) + circleCellMargin;
    CGFloat photosW = textW;
    //不存在图片
    if (self.zuopin.body.images.length == 0) {
        //主体frame
        CGFloat bodyH = CGRectGetMaxY(self.bodyTextFrame) + circleCellMargin;
        self.momentsBodyFrame = CGRectMake(0, 0, circleCellWidth, bodyH);
    } else {
        //存在图片
        CGFloat photosH = circleCellPhotosWH;
        if (![self.zuopin.body.images containsString:@"|"]) {
            //只有一张图片
             self.bodyPhotoFrame = CGRectMake(photosX, photosY, photosW/3, photosH);
        } else {
             self.bodyPhotoFrame = CGRectMake(photosX, photosY, photosW, photosH);
        }
        //主体frame
        CGFloat bodyH = CGRectGetMaxY(self.bodyPhotoFrame) + circleCellMargin;
        self.momentsBodyFrame = CGRectMake(0, 0, circleCellWidth, bodyH);
    }

}

//计算Code圈工具条Frame
- (void)setMomentsToolBarFrames{
    //工具条frame
    CGFloat toolBarX = 0;
    CGFloat toolBarY = CGRectGetMaxY(self.momentsBodyFrame);
    CGFloat toolBarW = circleCellWidth;
    CGFloat toolBarH = circleCellToolBarHeight;
    self.momentsToolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    //点赞
    CGFloat likeX = 0;
    CGFloat likeY = 0;
    CGFloat likeW = toolBarW / 2;
    CGFloat likeH = circleCellToolBarHeight;
    self.toolLikeFrame = CGRectMake(likeX, likeY, likeW, likeH);
    //评论
    CGFloat commentX = likeW;
    CGFloat commentY = 0;
    CGFloat commentW = likeW;
    CGFloat commentH = likeH;
    self.toolCommentFrame = CGRectMake(commentX, commentY, commentW, commentH);
}

- (void)setCellHeight{
    self.cellHeight = CGRectGetMaxY(self.momentsToolBarFrame);
}



@end
