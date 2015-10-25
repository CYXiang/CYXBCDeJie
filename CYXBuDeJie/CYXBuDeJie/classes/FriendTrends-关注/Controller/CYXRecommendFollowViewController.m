//
//  CYXRecommendFollowViewController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/24.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXRecommendFollowViewController.h"
#import "CYXHTTPSessionManager.h"
#import "CYXRecommendCategory.h"
#import "CYXRecommendCategoryCell.h"
#import "CYXRecommendUser.h"
#import "CYXRecommendUserCell.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import <SVProgressHUD.h>

@interface CYXRecommendFollowViewController ()<UITableViewDataSource,UITableViewDelegate>


/** 分类的数据 */
@property (strong, nonatomic) NSArray<CYXRecommendCategory *> * categories;
/** 用户的数据 */
@property (strong, nonatomic) NSArray<CYXRecommendUser *> * users;

/** CYXHTTPSessionManager */
@property (nonatomic,weak) CYXHTTPSessionManager * manager;
@property (weak, nonatomic) IBOutlet UITableView *categoryView;
@property (weak, nonatomic) IBOutlet UITableView *userView;

@end

@implementation CYXRecommendFollowViewController

static NSString *const CYXCategoryCellID = @"category";
static NSString *const CYXUserCellID = @"user";



/** manager 懒加载*/
- (CYXHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [CYXHTTPSessionManager manager];
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = CYXCommonBgColor;

    [self setupTable];
    
    [self loadCategory];

}

- (void)setupTable{
    // 设置表格
    UIEdgeInsets inset = UIEdgeInsetsMake(CYXNavBarBottom, 0, 0, 0);
    self.categoryView.contentInset = inset;
    self.categoryView.scrollIndicatorInsets = inset;
    self.userView.contentInset = inset;
    self.userView.scrollIndicatorInsets = inset;
    self.userView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.userView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadUsers)];
}

- (void)loadCategory{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:CYXRequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        weakSelf.categories = [CYXRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];

        [weakSelf.categoryView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        CYXLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
    
}

- (void)loadUsers{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = self.categories[self.categoryView.indexPathForSelectedRow.row].id;
    
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:CYXRequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        weakSelf.users = [CYXRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        CYXLog(@"%@",weakSelf.users);
        
        [weakSelf.userView reloadData];
        
        [weakSelf.userView.header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        CYXLog(@"%@",error);
        [weakSelf.userView.header endRefreshing];
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.categoryView) {
        return self.categories.count;
    }
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryView) {
        
        CYXRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CYXCategoryCellID];
        cell.category = self.categories[indexPath.row];
        
        return cell;
        
    }else{
        CYXRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:CYXUserCellID];
        cell.user = self.users[indexPath.row];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryView) {
        CYXLog(@"👈 - 类别表格---%zd", indexPath.row);
        [self.userView.header beginRefreshing];
    } else { // 👉 - 用户表格
        CYXLog(@"👉 - 用户表格---%zd", indexPath.row);
    }
}

@end
