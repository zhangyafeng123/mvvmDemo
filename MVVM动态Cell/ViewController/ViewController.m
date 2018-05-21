//
//  ViewController.m
//  MVVM动态Cell
//
//  Created by linjianguo on 2018/5/20.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ViewController.h"
#import "zuopinViewModel.h"
#import "zuopinCell.h"
#import "zuopinRequest.h"
#import "NextViewController.h"


NSString * const FFCellIndetfier  = @"fengfengCell";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
//负责网络请求以及其他计算或者事件处理
@property (nonatomic, strong)zuopinRequest *ZRequest;
@property (nonatomic,strong) NSMutableArray *zuopinFrames; //ViewModel(包含cell子控件的Frame)
@end

@implementation ViewController
- (void)itemAction
{
    NextViewController *next = [[NextViewController alloc] init];
    next.title = @"FDTemplateLayoutCell";
    [self.navigationController pushViewController:next animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一页" style:(UIBarButtonItemStylePlain) target:self action:@selector(itemAction)];
    
    [self setUI];
    //请求数据
    [self loadData];
    [self refreshtoTopMethod];
    
}
- (void)setUI{
    self.title = @"MVVM动态Cell";
    //设置navigationBar不透明
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    //导航条颜色
    self.navigationController.navigationBar.barTintColor = iCodeNavigationBarColor;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}
- (void)loadData
{
    [SVProgressHUD showWithStatus:@"加载中"];
    WS(weakSelf);
    [self.ZRequest requestData:^{
        
        //数据模型 => ViewModel(包含cell子控件的Frame)
        for (zuopinModel *model in weakSelf.ZRequest.dataModelArray) {
            zuopinViewModel *vm = [zuopinViewModel new];
            vm.zuopin = model;
            [weakSelf.zuopinFrames addObject:vm];
        }
        
        [weakSelf.tableView reloadData];
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
                weakSelf.tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
                    //[weakSelf.tableView.mj_footer beginRefreshing];
                    [weakSelf loadData];
                    [weakSelf.tableView.mj_footer endRefreshing];
                }];
            } else {
                weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
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
- (NSMutableArray *)zuopinFrames
{
    if (!_zuopinFrames) {
        _zuopinFrames = [NSMutableArray new];
        
    }
    return _zuopinFrames;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        CGFloat tableViewH =  self.view.bounds.size.height - 64;
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, tableViewH) style:UITableViewStylePlain];
        _tableView = tableView;
        //防止tableView被tabBar遮挡
        _tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, CGRectGetHeight(self.tabBarController.tabBar.frame), 0.0f);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor grayColor];
        _tableView.backgroundColor = iCodeTableviewBgColor;
        [_tableView registerClass:[zuopinCell class] forCellReuseIdentifier:FFCellIndetfier];
        //下拉刷新
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        [_tableView.mj_header beginRefreshing];
    }
    return _tableView;
}
- (void)loadNewData
{
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}
#pragma mark - tableView的方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.zuopinFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    zuopinCell *cell = [zuopinCell zuopinTableViewCellWithTableView:tableView];
   cell.momentFrames = self.zuopinFrames[indexPath.row];
   // cell.textLabel.text = @"fengfeng";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //取数据
    zuopinViewModel *momentFrame = self.zuopinFrames[indexPath.row];
    return momentFrame.cellHeight;
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
