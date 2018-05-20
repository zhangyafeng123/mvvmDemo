//
//  zuopinViewModel.h
//  MVVM动态Cell
//
//  Created by linjianguo on 2018/5/20.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import <Foundation/Foundation.h>
@class zuopinModel;

@interface zuopinViewModel : NSObject
/**
 *  数据模型
 */
@property (nonatomic, strong)zuopinModel *zuopin;

/**
 *  主体Frame
 */
@property (nonatomic ,assign) CGRect momentsBodyFrame;

//昵称Frame
@property (nonatomic ,assign) CGRect bodyNameFrame;
//头像Frame
@property (nonatomic ,assign) CGRect bodyIconFrame;
//时间Frame
@property (nonatomic ,assign) CGRect bodyTimeFrame;
//正文Frame
@property (nonatomic ,assign) CGRect bodyTextFrame;
//图片Frame
@property (nonatomic ,assign) CGRect bodyPhotoFrame;

/**
 *  工具条Frame
 */
@property (nonatomic, assign) CGRect momentsToolBarFrame;

//点赞Frame
@property (nonatomic ,assign) CGRect toolLikeFrame;
//评论Frame
@property (nonatomic ,assign) CGRect toolCommentFrame;

/**
 *  cell高度
 */
@property (nonatomic ,assign) CGFloat cellHeight;
@end
