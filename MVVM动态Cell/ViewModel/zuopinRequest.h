//
//  zuopinRequest.h
//  MVVM动态Cell
//
//  Created by linjianguo on 2018/5/20.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import <Foundation/Foundation.h>

@class zuopinModel;


@interface zuopinRequest : NSObject
//返回的数据
@property (nonatomic, strong)NSArray *dataModelArray;
@property (nonatomic, assign)NSInteger currentPage;
@property (nonatomic, strong)void(^refreshToTopBlock)(NSInteger num);

//请求数据
- (void)requestData:(void(^)(void))sBlock fBlock:(void(^)(void))fBlock;
@end
