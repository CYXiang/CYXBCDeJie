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
    self.userView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
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
        
        //选中第0行
        [weakSelf.categoryView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:
         UITableViewScrollPositionTop];
 
        [weakSelf.userView.header beginRefreshing];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        CYXLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
    
}

- (void)loadUsers{
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    CYXRecommendCategory *category = self.categories[self.categoryView.indexPathForSelectedRow.row];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = category.id;
    
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:CYXRequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        category.page = 1;
        
        category.users = [CYXRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        category.total = [responseObject[@"total"]integerValue];
        
        [weakSelf.userView reloadData];
        
        [weakSelf.userView.header endRefreshing];
        
        if (category.users.count == category.total) {
            weakSelf.userView.footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        CYXLog(@"%@",error);
        [weakSelf.userView.header endRefreshing];
    }];
    
}

- (void)loadMoreUsers{
    // 取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    CYXRecommendCategory *categoty = self.categories[self.categoryView.indexPathForSelectedRow.row];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = categoty.id;
    NSInteger page = categoty.page + 1;
    params[@"page"] = @(page);
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:CYXRequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 赋值新页码
        categoty.page = page;
        // 字典数组转模型数组
        NSArray *moreUsers = [CYXRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [categoty.users addObjectsFromArray:moreUsers];
        
        categoty.total = [responseObject[@"total"]integerValue];
        
        [weakSelf.userView reloadData];
        
        if (categoty.users.count == categoty.total) {
            weakSelf.userView.footer.hidden = YES;
        }else{
            [weakSelf.userView.footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [weakSelf.categoryView.footer endRefreshing];
    }];
    
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.categoryView) {
        return self.categories.count;
    }
    CYXRecommendCategory *category = self.categories[self.categoryView.indexPathForSelectedRow.row];
    return category.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryView) {
        
        CYXRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CYXCategoryCellID];
        cell.category = self.categories[indexPath.row];
        
        return cell;
        
    }else{
        CYXRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:CYXUserCellID];
        CYXRecommendCategory *category = self.categories[self.categoryView.indexPathForSelectedRow.row];
        
        cell.user = category.users[indexPath.row];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryView) {
        CYXRecommendCategory *category = self.categories[indexPath.row];
        if (category.users.count == 0) { // 这个被选中的类别 没有任何用户数据
            // 让 👉 - 用户表格 进入下拉刷新状态 (加载最新的用户数据)
            [self.userView.header beginRefreshing];
        }
        [self.userView reloadData];
    } else { // 👉 - 用户表格
        CYXLog(@"👉 - 用户表格---%zd", indexPath.row);
    }
}

@end
