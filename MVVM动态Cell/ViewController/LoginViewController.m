//
//  LoginViewController.m
//  MVPDemo
//
//  Created by linjianguo on 2018/5/19.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "LoginViewController.h"
#import "PersonModel.h"
#import "ViewController.h"
@interface LoginViewController ()
@property (nonatomic, strong)UIButton *btn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame  = CGRectMake(100, 200, 100, 40);
    [btn setTitle:@"点击登录" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(btnaction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];

}
- (void)btnaction:(UIButton *)sender
{
    [NetWorkManager requestForPostWithUrl:loginURL parameter:@{@"phone":@"17704609876",@"password":@"123456",@"device":@"ios"} success:^(id reponseObject) {
        [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
        
        if ([reponseObject[@"code"] integerValue] == 1) {
            [UserInfoManager cleanUserInfo];
            PersonModel *model = [[PersonModel alloc] init];
            model.token = reponseObject[@"result"][@"token"];
            model.nick_name = reponseObject[@"result"][@"user"][@"nick_name"];
            model.rong_token = reponseObject[@"result"][@"user"][@"rong_token"];
            model.id = reponseObject[@"result"][@"user"][@"id"];
            model.user_head = reponseObject[@"result"][@"user"][@"user_head"];
            [UserInfoManager saveUserInfoWithModel:model];
            
            ViewController *f = [ViewController new];
            [self.navigationController pushViewController:f animated:YES];
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
    }];
}


@end
