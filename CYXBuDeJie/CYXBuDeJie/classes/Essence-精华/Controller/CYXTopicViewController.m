//
//  CYXTopicViewController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/24.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXTopicViewController.h"
#import "CYXHTTPSessionManager.h"
#import "CYXTopic.h"
#import "CYXTopicCell.h"
#import "CYXNewController.h"
#import "CYXCommentViewController.h"
#import <MJExtension.h>
#import <MJRefresh.h>

@interface CYXTopicViewController ()

/** 请求管理者 */
@property (nonatomic,weak) CYXHTTPSessionManager * manager;

/** 帖子模型数组 */
@property (strong, nonatomic) NSMutableArray<CYXTopic *> * topics;

/** 用来加载下一页的参数 */
@property (strong, nonatomic) NSString * maxtime;

@end

@implementation CYXTopicViewController

static NSString *const CYXTopicCellID = @"topic";

/** manager 属性懒加载*/
- (CYXHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [CYXHTTPSessionManager manager];
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    
    [self setupRefresh];
    
    
}

/**
 *  设置tableView
 */
- (void)setupTable{
    // 设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(CYXNavBarBottom + CYXTitlesViewH, 0, CYXTabBarH + CYXMargin, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    // 分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.tableView.rowHeight = 200;
    // 关闭系统分割线样式
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CYXTopicCell class]) bundle:nil] forCellReuseIdentifier:CYXTopicCellID];
    self.tableView.backgroundColor = CYXCommonBgColor;
}

/**
 *  刷新
 */
- (void)setupRefresh{
    
    // 下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.header.automaticallyChangeAlpha = YES;
    
    // 开始刷新
    [self.tableView.header beginRefreshing];
    
    // 上拉刷新
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.tableView.footer beginRefreshing];
    
}

#pragma mark 数据处理

// 根据类判断是否新帖或精华
- (NSString *)paramA{

    if ([self.parentViewController isKindOfClass:[CYXNewController class]]) {
        return @"newlist";
    }
    return @"list";
}
/**
 *  加载新的帖子
 */
- (void)loadNewTopics{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.paramA;
    params[@"type"] = @(self.type),
    params[@"c"] = @"data";
    
    __weak typeof(self) weakSelf = self;
    // 发送请求
    [self.manager GET:CYXRequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 存储 maxtime
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        
        weakSelf.topics =  [CYXTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        CYXLog(@"%@",responseObject[@"list"]);
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [weakSelf.tableView.header endRefreshing];
    }];
}

/**
 *  加载更多
 */
- (void)loadMoreData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.paramA;
    params[@"type"] = @(self.type),
    params[@"c"] = @"data";
    params[@"maxtime"] = self.maxtime;
    
    __weak typeof(self) weakSelf = self;
    // 发送请求
    [self.manager GET:CYXRequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 存储 maxtime
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray *moreTopics =  [CYXTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
//        CYXLog(@"%@",responseObject[@"list"]);

        // 增加到以前数组的最后
        [weakSelf.topics addObjectsFromArray:moreTopics];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [weakSelf.tableView.footer endRefreshing];
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYXTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:CYXTopicCellID];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
// 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.topics[indexPath.row].cellHeight;
    
}
// 点击哪一行的Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CYXCommentViewController *commentVc = [[CYXCommentViewController alloc]init];
    commentVc.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commentVc animated:YES];
}

@end
