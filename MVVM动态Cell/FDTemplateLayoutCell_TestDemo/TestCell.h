//
//  TestCell.h
//  MVVM动态Cell
//
//  Created by linjianguo on 2018/5/21.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zuopinModel.h"
@interface TestCell : UITableViewCell

+(instancetype)testTableViewCellWithTableView:(UITableView *)tableView;

- (void)setTestModel:(zuopinModel *)model;

@end
