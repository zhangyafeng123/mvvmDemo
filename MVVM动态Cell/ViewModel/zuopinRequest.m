//
//  zuopinRequest.m
//  MVVM动态Cell
//
//  Created by linjianguo on 2018/5/20.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "zuopinRequest.h"
#import "zuopinModel.h"
@implementation zuopinRequest
//请求数据
- (void)requestData:(void(^)(void))sBlock fBlock:(void(^)(void))fBlock
{
    [SVProgressHUD showWithStatus:@"加载中"];
    NSString *typeStr  = @"ot";
    WS(weakSelf);
    [NetWorkManager requestForGetWithUrl:[NSString stringWithFormat:@"%@?token=%@&type=%@&category=%@&page_no=%ld",bbslistURL,[UserInfoManager getUserInfo].token,typeStr,typeStr,self.currentPage] parameter:@{} success:^(id reponseObject) {
        if ([reponseObject[@"code"] integerValue] == 1) {
            
            weakSelf.dataModelArray = [zuopinModel mj_objectArrayWithKeyValuesArray:reponseObject[@"result"][@"result"][@"list"]];
            if (sBlock) {
                sBlock();
            }
            //   [self.listArray addObjectsFromArray:self.dataArray];
        }
        //        [self.tableview reloadData];
            [self refreshfooternew:[reponseObject[@"result"][@"result"][@"totalPage"] integerValue]];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        if (fBlock) {
            fBlock();
        }
    }];
}
- (void)refreshfooternew:(NSInteger)totalpages
{

    if (self.refreshToTopBlock) {
        self.refreshToTopBlock(totalpages);
    }
}
@end
