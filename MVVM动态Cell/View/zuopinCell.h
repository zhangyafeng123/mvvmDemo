//
//  zuopinCell.h
//  MVVM动态Cell
//
//  Created by linjianguo on 2018/5/20.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class zuopinViewModel;
@interface zuopinCell : UITableViewCell

@property (nonatomic,strong) NSMutableArray *moments;
@property (nonatomic,strong) zuopinViewModel *momentFrames;

+(instancetype)zuopinTableViewCellWithTableView:(UITableView *)tableView;

@end
