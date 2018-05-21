//
//  NextViewController.m
//  MVVM动态Cell
//
//  Created by linjianguo on 2018/5/21.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "NextViewController.h"
#import "zuopinRequest.h"
#import "zuopinModel.h"
#import "TestCell.h"
NSString * const cellidentifer  = @"TestCell";
@interface NextViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView11;
//负责网络请求以及其他计算或者事件处理
@property (nonatomic, strong)zuopinRequest *ZRequest;
@property (nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation NextViewController
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    //请求数据
    [self loadData];
    [self refreshtoTopMethod];
    
}
- (void)setUI{
    self.title = @"MVVM动态Cell";
//    //设置navigationBar不透明
//    self.navigationController.navigationBar.translucent = NO;
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//    //导航条颜色
//    self.navigationController.navigationBar.barTintColor = iCodeNavigationBarColor;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView11];
    self.tableView11.fd_debugLogEnabled = YES;
}
- (void)loadData
{
    [SVProgressHUD showWithStatus:@"加载中"];
    WS(weakSelf);
    
    [self.ZRequest requestData:^{
        //
        for (zuopinModel *model in weakSelf.ZRequest.dataModelArray) {
            [weakSelf.dataArray addObject:model];
        }
        
        [weakSelf.tableView11 reloadData];
        [SVProgressHUD dismiss];
    } fBlock:^{
        //会自动消失
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
    }];
    
    
    
}
- (void)refreshtoTopMethod
{
    WS(weakSelf);
    self.ZRequest.refreshToTopBlock = ^(NSInteger num){
        if (num > self.ZRequest.currentPage) {
            ++weakSelf.ZRequest.currentPage;
            weakSelf.tableView11.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
                //[weakSelf.tableView.mj_footer beginRefreshing];
                [weakSelf loadData];
                [weakSelf.tableView11.mj_footer endRefreshing];
            }];
        } else {
            weakSelf.tableView11.mj_footer.state = MJRefreshStateNoMoreData;
        }
    };
    
    
}
//请求懒加载
- (zuopinRequest *)ZRequest
{
    if (!_ZRequest) {
        _ZRequest = [zuopinRequest new];
        _ZRequest.currentPage = 1;
    }
    return _ZRequest;
}
- (UITableView *)tableView11
{
    if (!_tableView11) {
        CGFloat tableViewH =  self.view.bounds.size.height - 64;
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, tableViewH) style:UITableViewStylePlain];
        _tableView11 = tableView;
        //防止tableView被tabBar遮挡
        _tableView11.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, CGRectGetHeight(self.tabBarController.tabBar.frame), 0.0f);
        _tableView11.dataSource = self;
        _tableView11.delegate = self;
        //_tableView11.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView11.backgroundColor = [UIColor grayColor];
        _tableView11.backgroundColor = iCodeTableviewBgColor;
        [_tableView11 registerClass:[TestCell class] forCellReuseIdentifier:cellidentifer];
        //下拉刷新
        _tableView11.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        [_tableView11.mj_header beginRefreshing];
    }
    return _tableView11;
}

- (void)loadNewData
{
    [self.tableView11 reloadData];
    [self.tableView11.mj_header endRefreshing];
}
#pragma mark - tableView的方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TestCell *cell = [TestCell testTableViewCellWithTableView:tableView];
    [cell setTestModel:self.dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:cellidentifer cacheByIndexPath:indexPath configuration:^(TestCell *cell) {
        [cell setTestModel:self.dataArray[indexPath.row]];
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
